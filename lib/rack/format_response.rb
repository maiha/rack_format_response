module Rack
  #
  # A Rack middleware for automatically formatting response body
  #
  # e.g.
  #   # in usual case
  #   get "/ping" do
  #     {"message"=>"pong"}
  #   end
  # ->
  #   # forced to to_s
  #   messagepong
  #
  #
  #   # use Rack::FormatResponse # with string response
  #   get "/ping" do
  #     "pong"
  #   end
  # ->
  #   # calls Rack::FormatResponse#format_string that effects nothing
  #   # in short, nothing special
  #   Content-Type: text/html
  #   "pong"
  #
  #   # use Rack::FormatResponse # with hash response
  #   get "/ping" do
  #     {"message"=>"pong"}
  #   end
  # ->
  #   # calls Rack::FormatResponse#format_hash_to_json
  #   # due to Rack::FormatResponse::MAPPINGS
  #   Content-Type: application/json;charset=utf-8
  #   {"message":"pong"}
  #

  class FormatResponse
    MAPPINGS = {
      "Hash" => :format_hash_to_json,
    }

    class UnknownFormat < RuntimeError; end
    class InvalidFormat < RuntimeError; end

    def initialize(app, opts = {})
      @app  = app
      @opts = opts
    end

    def call(env)
      @status, @headers, body = @app.call(env)
      body = [apply(body)].flatten
      [@status, @headers, @body || body]
    end

    private
      def lookup(body)
        body = body[0] if body.class == Array and body.size == 1
        MAPPINGS[body.class.name] or
          "format_" + body.class.name.gsub(/::/,'_').downcase
      end

      def apply(data)
        func = lookup(data)
        case func
        when Proc
          return func.call(data)
        when Symbol, String
          return __send__(func, data) if respond_to?(func, true)
          raise UnknownFormat, "no formatters named `#{func}'"
        else
          raise UnknownFormat, "no formatters typed `#{func.class}'"
        end
      end

      ######################################################################
      ### Formatters

      def format_array(ary)
        ary
      end

      def format_string(str)
        str
      end

      def format_hash_to_json(hash)
        require 'yajl'
        @headers['Content-Type'] = "application/json;charset=utf-8"
        Yajl.dump(hash)
      end
  end
end

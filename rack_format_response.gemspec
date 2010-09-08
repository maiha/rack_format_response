# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rack_format_response}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["maiha"]
  s.date = %q{2010-09-08}
  s.description = %q{A Rack middleware for automatically formatting response body}
  s.email = %q{maiha@wota.jp}
  s.extra_rdoc_files = ["README", "MIT-LICENSE"]
  s.files = ["MIT-LICENSE", "README", "Rakefile", "lib/rack", "lib/rack/format_response.rb"]
  s.homepage = %q{http://github.com/maiha/rack_format_response}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{asakusarb}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A Rack middleware for automatically formatting response body}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

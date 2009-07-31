# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{multi-methods}
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corey Haines", "Jon Kern"]
  s.date = %q{2009-07-31}
  s.description = %q{TODO: longer description of your gem}
  s.email = %q{coreyhaines@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "features/multi-methods.feature",
     "features/step_definitions/multi-methods_steps.rb",
     "features/support/env.rb",
     "lib/multi-methods.rb",
     "spec/multi-methods_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/coreyhaines/multi-methods}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "spec/multi-methods_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

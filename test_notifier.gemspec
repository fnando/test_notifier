# frozen_string_literal: true

require_relative "lib/test_notifier/version"

Gem::Specification.new do |s|
  s.name        = "test_notifier"
  s.version     = TestNotifier::Version::STRING.to_s
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.required_ruby_version = ">= 2.7"
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/test_notifier"
  s.summary     = "Display system notifications (dbus, terminal notifier, " \
                  "snarl, and more) after running tests."
  s.description = "Display system notifications after running tests. It " \
                  "works on Mac OS X, Linux and Windows. Powerful when used " \
                  "with autotest or guard."

  s.metadata["rubygems_mfa_required"] = "true"
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map do |f|
    File.basename(f)
  end
  s.require_paths = ["lib"]

  s.add_dependency "notifier"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", ">= 3.0.0"
  s.add_development_dependency "rubocop"
  s.add_development_dependency "rubocop-fnando"
end

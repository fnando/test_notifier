# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "test_notifier/version"

Gem::Specification.new do |s|
  s.name        = "test_notifier"
  s.version     = "#{TestNotifier::Version::STRING}"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nando Vieira"]
  s.email       = ["fnando.vieira@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/test_notifier"
  s.summary     = "Display system notifications (dbus, growl and snarl) after running tests."
  s.description = <<-DESC
Display system notifications (dbus, growl and snarl) after
running tests. It works on Mac OS X, Linux and Windows. Powerful when used
with Autotest ZenTest gem and alike for Rails apps.
DESC

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "notifier"
  s.add_development_dependency "rspec", ">= 3.0.0"
  s.add_development_dependency "rake"
end

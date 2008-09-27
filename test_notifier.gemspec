# WARNING : RAKE AUTO-GENERATED FILE. DO NOT MANUALLY EDIT!
# RUN : 'rake gem:update_gemspec'

Gem::Specification.new do |s|
  s.date = "Sat Sep 27 15:24:55 -0300 2008"
  s.authors = ["Nando Vieira"]
  s.require_paths = ["lib"]
  s.required_rubygems_version = ">= 0"
  s.has_rdoc = false
  s.files = ["Rakefile",
 "test_notifier.gemspec",
 "History.txt",
 "License.txt",
 "README.markdown",
 "TODO.txt",
 "lib/test_notifier",
 "lib/test_notifier/autotest.rb",
 "lib/test_notifier/icons",
 "lib/test_notifier/icons/error.png",
 "lib/test_notifier/icons/failure.png",
 "lib/test_notifier/icons/passed.png",
 "lib/test_notifier/rspec.rb",
 "lib/test_notifier/test_unit.rb",
 "lib/test_notifier.rb"]
  s.email = ["fnando.vieira@gmail.com"]
  s.version = "0.0.10"
  s.homepage = "http://github.com/fnando/test_notifier"
  s.requirements = ["You'll need Growl (Mac OS X), Libnotify (Linux) or Snarl (Windows)"]
  s.name = "test_notifier"
  s.summary = "Display system notifications (dbus, growl and snarl) after running tests."
  s.description = "Display system notifications (dbus, growl and snarl) after   running tests. It works on Mac OS X, Linux and Windows. Powerful when used   with Autotest ZenTest gem for Rails apps."
  s.add_dependency "rubigen", ">= 0"
  s.bindir = "bin"
end
require "rake/testtask"
require "jeweler"
require "lib/test_notifier/version"

Rake::TestTask.new do |t|
  t.libs += %w[test lib]
  t.ruby_opts = %w[-rubygems]
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

JEWEL = Jeweler::Tasks.new do |gem|
  gem.name = "test_notifier"
  gem.email = "fnando.vieira@gmail.com"
  gem.homepage = "http://github.com/fnando/test_notifier"
  gem.authors = ["Nando Vieira"]
  gem.version = TestNotifier::Version::STRING
  gem.summary = "Display system notifications (dbus, growl and snarl) after running tests."
  gem.description = <<-TEXT
Display system notifications (dbus, growl and snarl) after
running tests. It works on Mac OS X, Linux and Windows. Powerful when used
with Autotest ZenTest gem for Rails apps.
TEXT

  gem.files =  FileList["{README}.rdoc", "{lib,resources}/**/*"]
  gem.requirements << "You'll need Growl (Mac OS X), Libnotify, OSD or KDE (Linux) or Snarl (Windows)"
end

Jeweler::GemcutterTasks.new

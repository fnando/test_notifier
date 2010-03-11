require "jeweler"

JEWEL = Jeweler::Tasks.new do |gem|
  gem.name = "test_notifier"
  gem.email = "fnando.vieira@gmail.com"
  gem.homepage = "http://github.com/fnando/test_notifier"
  gem.authors = ["Nando Vieira"]
  gem.version = "0.1.1"
  gem.summary = "Display system notifications (dbus, growl and snarl) after running tests."
  gem.description = <<-TEXT
Display system notifications (dbus, growl and snarl) after
running tests. It works on Mac OS X, Linux and Windows. Powerful when used
with Autotest ZenTest gem for Rails apps.
TEXT

  gem.files =  FileList["{README}.rdoc", "{lib}/**/*"]
  gem.requirements << "You'll need Growl (Mac OS X), Libnotify (Linux) or Snarl (Windows)"
end

Jeweler::GemcutterTasks.new

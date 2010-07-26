module TestNotifier
  module Notifier
    autoload :Growl,      "test_notifier/notifier/growl"
    autoload :Snarl,      "test_notifier/notifier/snarl"
    autoload :OsdCat,     "test_notifier/notifier/osd_cat"
    autoload :Knotify,    "test_notifier/notifier/knotify"
    autoload :Kdialog,    "test_notifier/notifier/kdialog"
    autoload :NotifySend, "test_notifier/notifier/notify_send"
  end
end

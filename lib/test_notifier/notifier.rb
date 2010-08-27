module TestNotifier
  module Notifier
    autoload :Growl,      "test_notifier/notifier/growl"
    autoload :Snarl,      "test_notifier/notifier/snarl"
    autoload :OsdCat,     "test_notifier/notifier/osd_cat"
    autoload :Knotify,    "test_notifier/notifier/knotify"
    autoload :Kdialog,    "test_notifier/notifier/kdialog"
    autoload :NotifySend, "test_notifier/notifier/notify_send"

    extend self

    def notifiers
      constants.collect do |name|
        const_get(name)
      end
    end

    def supported_notifiers
      notifiers.select {|notifier| notifier.supported?}
    end

    def from_name(name)
      notifier = const_get(classify(name.to_s))
    rescue NameError
      nil
    end

    def supported_notifier_from_name(name)
      notifier = from_name(name)
      notifier && notifier.supported? ? notifier : nil
    end

    private
    def classify(string)
      string.gsub(/_(.)/sm) { "#{$1.upcase}" }.gsub(/^(.)/) { "#{$1.upcase}" }
    end
  end
end

module TestNotifier
  module Notifier
    autoload :Growl,      "test_notifier/notifier/growl"
    autoload :Snarl,      "test_notifier/notifier/snarl"
    autoload :OsdCat,     "test_notifier/notifier/osd_cat"
    autoload :Knotify,    "test_notifier/notifier/knotify"
    autoload :Kdialog,    "test_notifier/notifier/kdialog"
    autoload :NotifySend, "test_notifier/notifier/notify_send"
    autoload :Placebo,    "test_notifier/notifier/placebo"

    extend self

    def notifiers
      sorted_constants = constants - ['Placebo'] + ['Placebo']
      sorted_constants.collect {|name| const_get(name)}
    end

    def supported_notifiers
      notifiers.select {|notifier| notifier.supported?}
    end

    def from_name(name)
      notifier = const_get(classify(name.to_s))
    rescue Exception
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

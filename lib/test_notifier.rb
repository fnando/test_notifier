module TestNotifier
  class << self
    attr_accessor :__notifier__
    attr_accessor :default_notifier
  end

  extend self

  class UnsupportedNotifierError < StandardError; end

  IMAGES = {
    :fail    => File.dirname(__FILE__) + "/../resources/fail.png",
    :error   => File.dirname(__FILE__) + "/../resources/error.png",
    :success => File.dirname(__FILE__) + "/../resources/success.png"
  }

  TITLES = {
    :fail    => "Failed!",
    :success => "Passed!",
    :error   => "Error!"
  }

  def notify(options)
    options.merge!({
      :title => TITLES[options[:status]],
      :image => IMAGES[options[:status]]
    })

    notifier.notify(options)
  end

  def notifier
    self.__notifier__ ||= begin
      notifier = nil
      notifier = TestNotifier::Notifier.supported_notifier_from_name(default_notifier) if default_notifier
      notifier = TestNotifier::Notifier.supported_notifiers.first unless notifier

      raise UnsupportedNotifierError, "You have no supported notifiers installed. Please read documentation." unless notifier
      notifier
    end
  end

  autoload :Notifier,   "test_notifier/notifier"
  autoload :Runner,     "test_notifier/runner"
  autoload :Stats,      "test_notifier/stats"
end

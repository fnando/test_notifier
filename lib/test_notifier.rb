require "notifier"

module TestNotifier
  class << self
    attr_accessor :silence_no_notifier_warning
  end

  extend self

  NO_NOTIFIERS_MESSAGE = "[TEST NOTIFIER] You have no supported notifiers installed. Please read documentation.\n"

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

  COLORS = {
    :fail    => "orange",
    :success => "green",
    :error   => "red"
  }

  def default_notifier=(notifier)
    Notifier.default_notifier = notifier
  end

  def notify(options)
    options.merge!({
      :title => TITLES[options[:status]],
      :image => IMAGES[options[:status]],
      :color => COLORS[options[:status]]
    })

    notifier.notify(options)
  end

  def notifier
    notifier = Notifier.notifier

    if notifier == Notifier::Placebo && !silence_no_notifier_warning
      STDERR << NO_NOTIFIERS_MESSAGE
    end

    notifier
  end

  require "test_notifier/runner"
  require "test_notifier/stats"
end

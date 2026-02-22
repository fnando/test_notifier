# frozen_string_literal: true

require "notifier"

module TestNotifier
  extend self

  NO_NOTIFIERS_MESSAGE = "[TEST NOTIFIER] You have no supported notifiers " \
                         "installed. Please read documentation.\n"

  IMAGES = {
    fail: File.expand_path("#{__dir__}/../resources/fail.png"),
    error: File.expand_path("#{__dir__}/../resources/error.png"),
    success: File.expand_path("#{__dir__}/../resources/success.png")
  }.freeze

  HUD_SYMBOLS = {
    fail: "exclamationmark.triangle",
    error: "xmark.octagon",
    success: "checkmark.circle"
  }.freeze

  TITLES = {
    fail: "Failed!",
    success: "Passed!",
    error: "Error!"
  }.freeze

  COLORS = {
    fail: "orange",
    success: "green",
    error: "red"
  }.freeze

  attr_accessor :silence_no_notifier_warning

  def default_notifier=(notifier)
    Notifier.default_notifier = notifier
  end

  def notify(options)
    options = options.merge(
      title: TITLES[options[:status]],
      image: IMAGES[options[:status]],
      color: COLORS[options[:status]]
    )

    if Notifier.notifier == Notifier::Hud
      options[:image] = HUD_SYMBOLS[options[:status]]
    end

    notifier.notify(options)
  end

  def notifier
    notifier = Notifier.notifier

    if notifier == Notifier::Noop && !silence_no_notifier_warning
      $stderr << NO_NOTIFIERS_MESSAGE
    end

    notifier
  end

  require "test_notifier/stats"
  require "test_notifier/runner/minitest" if defined?(Minitest)
  require "test_notifier/runner/rspec" if defined?(RSpec)
end

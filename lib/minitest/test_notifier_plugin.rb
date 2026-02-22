# frozen_string_literal: true

module Minitest
  def self.plugin_test_notifier_init(_options)
    reporter << TestNotifier::MinitestReporter.new
  end
end

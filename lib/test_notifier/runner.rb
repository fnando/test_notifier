# frozen_string_literal: true

module TestNotifier
  module Runner
    autoload :RSpec,    "test_notifier/runner/rspec"
    autoload :Minitest, "test_notifier/runner/minitest"
  end
end

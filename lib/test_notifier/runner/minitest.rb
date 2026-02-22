# frozen_string_literal: true

require "test_notifier"
require "minitest"

module TestNotifier
  class MinitestReporter < Minitest::AbstractReporter
    attr_reader :count, :assertions, :failures, :errors, :pending

    def initialize(*)
      super
      @assertions = 0
      @count = 0
      @failures = 0
      @errors = 0
      @pending = 0
    end

    def start
    end

    def prerecord(*)
    end

    def record(result)
      flunked = result.failures.count { flunk?(it) }

      @count += 1
      @assertions += result.assertions
      @assertions -= flunked if flunked.nonzero?
      @errors += result.failures.count { error?(it) }
      @failures += result.failures.count { failure?(it) }
      @pending += flunked
    end

    def flunk?(failure)
      (failure.backtrace_locations || [])
        .any? { it.label == "Minitest::Assertions#flunk" }
    end

    def failure?(failure)
      failure.is_a?(Minitest::Assertion) && !flunk?(failure)
    end

    def error?(failure)
      failure.is_a?(Minitest::UnexpectedError)
    end

    def report
      stats = TestNotifier::Stats.new(
        :minitest,
        count:,
        assertions:,
        failures:,
        errors:,
        pending:
      )

      TestNotifier.notify(status: stats.status, message: stats.message)
    end
  end
end

Minitest.load(:test_notifier)

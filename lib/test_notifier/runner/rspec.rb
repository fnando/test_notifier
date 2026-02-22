# frozen_string_literal: true

require "test_notifier"
require "rspec/core"
require "rspec/core/formatters/base_text_formatter"

module RSpec
  module Core
    module Formatters
      class BaseTextFormatter
        alias dump_summary_original dump_summary

        def error_filter
          proc do |error|
            error.exception.is_a?(UncaughtThrowError)
          end
        end

        def failure_filter
          proc do |error|
            error.exception
                 .instance_of?(RSpec::Expectations::ExpectationNotMetError)
          end
        end

        def dump_summary(options)
          dump_summary_original(options)

          count = options.example_count
          pending = options.pending_count
          errors = options.failed_examples.count(&error_filter)
          failures = options.failed_examples.size - errors

          return if count.zero?

          stats = TestNotifier::Stats.new(
            :rspec,
            count:,
            failures:,
            pending:,
            errors:
          )

          TestNotifier.notify(status: stats.status, message: stats.message)
        end
      end
    end
  end
end

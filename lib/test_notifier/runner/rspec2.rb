# frozen_string_literal: true

require "test_notifier"
require "rspec/core/formatters/base_text_formatter"

module RSpec
  module Core
    module Formatters
      class BaseTextFormatter
        alias dump_summary_original dump_summary

        def dump_summary(duration, example_count, failure_count, pending_count)
          dump_summary_original(
            duration,
            example_count,
            failure_count,
            pending_count
          )

          return if example_count.zero?

          failure_filter = proc do |error|
            error
              .instance_variable_get(:@exception)
              .instance_of?(RSpec::Expectations::ExpectationNotMetError)
          end

          error_filter = proc do |error|
            %w[
              RSpec::Expectations::ExpectationNotMetError
              NilClass
            ].include?(error.instance_variable_get(:@exception).class.name)
          end

          stats = TestNotifier::Stats.new(
            :rspec,
            {
              count: example_count,
              failures: examples.count(&failure_filter),
              pending: pending_count,
              errors: examples.count(&error_filter)
            }
          )

          TestNotifier.notify(status: stats.status, message: stats.message)
        end
      end
    end
  end
end

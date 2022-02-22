# frozen_string_literal: true

require "test_notifier"
require "rspec/core"
require "rspec/core/formatters/base_text_formatter"

module RSpec
  module Core
    module Formatters
      class BaseTextFormatter
        alias dump_summary_original dump_summary

        def dump_summary(options)
          dump_summary_original(options)

          example_count = options.example_count
          pending_count = options.pending_count
          examples = options.examples

          return if example_count.zero?

          failure_filter = proc do |error|
            error
              .instance_variable_get(:@exception)
              .instance_of?(RSpec::Expectations::ExpectationNotMetError)
          end

          error_filter = proc {|e|
            %w[
              RSpec::Expectations::ExpectationNotMetError
              NilClass
            ].include?(e.instance_variable_get(:@exception).class.name)
          }

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

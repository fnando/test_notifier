# frozen_string_literal: true

require "test_notifier"
require "test/unit/ui/console/testrunner"

module Test
  module Unit
    module UI
      module Console
        class TestRunner
          alias finished_original finished

          def finished(elapsed_time)
            finished_original(elapsed_time)

            begin
              re = /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/
              _, tests, assertions, failures, errors = *@result.to_s.match(re)
              return if tests.to_i.zero?

              stats = TestNotifier::Stats.new(:test_unit, {
                                                count: tests,
                                                assertions: assertions,
                                                failures: failures,
                                                errors: errors
                                              })

              TestNotifier.notify(status: stats.status, message: stats.message)
            rescue StandardError => error
              puts error
              puts error.backtrace
            end
          end
        end
      end
    end
  end
end

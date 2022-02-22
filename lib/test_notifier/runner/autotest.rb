# frozen_string_literal: true

require "test_notifier"

Autotest.add_hook :ran_command do |at|
  content = at.results.to_s

  rspec_re = /(\d+) examples?, (\d+) failures?(, (\d+) pendings?)?/
  test_unit_re = /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/

  rspec_matches = content.match(rspec_re)
  test_unit_matches = content.match(test_unit_re)

  if rspec_matches
    _, examples, failures, _, pending = *rspec_matches

    stats = TestNotifier::Stats.new(
      :spec,
      {
        count: examples,
        failures: failures,
        pending: pending
      }
    )

    unless examples.to_i.zero?
      TestNotifier.notify(status: stats.status, message: stats.message)
    end
  elsif test_unit_matches
    _, tests, assertions, failures, errors = *test_unit_matches

    stats = TestNotifier::Stats.new(
      :test_unit,
      {
        count: tests,
        assertions: assertions,
        failures: failures,
        errors: errors
      }
    )

    unless tests.to_i.zero?
      TestNotifier.notify(status: stats.status, message: stats.message)
    end
  end
rescue StandardError => error
  puts error
  puts error.backtrace
end

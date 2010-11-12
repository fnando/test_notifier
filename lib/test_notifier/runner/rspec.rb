require "test_notifier"
require "rspec/core/formatters/base_text_formatter"

class RSpec::Core::Formatters::BaseTextFormatter
  alias dump_summary_original dump_summary

  def dump_summary(duration, example_count, failure_count, pending_count)
    dump_summary_original(duration, example_count, failure_count, pending_count)

    return if example_count.zero?

    failure_filter = proc {|e|
      e.instance_variable_get("@exception").class.name == "RSpec::Expectations::ExpectationNotMetError"
    }

    error_filter = proc {|e|
      %w[RSpec::Expectations::ExpectationNotMetError NilClass].include?(e.instance_variable_get("@exception").class.name)
    }

    stats = TestNotifier::Stats.new(:rspec, {
      :count    => example_count,
      :failures => examples.select(&failure_filter).count,
      :pending  => pending_count,
      :errors   => examples.reject(&error_filter).count
    })

    TestNotifier.notify(:status => stats.status, :message => stats.message)
  end
end

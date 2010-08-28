require "test_notifier"
require "rspec/core/formatters/base_text_formatter"

class RSpec::Core::Formatters::BaseTextFormatter
  alias dump_summary_original dump_summary

  def dump_summary(duration, example_count, failure_count, pending_count)
    dump_summary_original(duration, example_count, failure_count, pending_count)

    return if example_count.zero?

    stats = TestNotifier::Stats.new(:rspec, {
      :total   => example_count,
      :fail    => failure_count,
      :pending => pending_count,
      :errors  => examples.reject {|e| e.instance_variable_get("@exception").nil?}.count
    })

    TestNotifier.notify(:status => stats.status, :message => stats.message)
  end
end

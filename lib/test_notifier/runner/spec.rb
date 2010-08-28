require "test_notifier"
require "spec/runner/formatter/base_text_formatter"

class Spec::Runner::Formatter::BaseTextFormatter
  alias dump_summary_original dump_summary

  def dump_summary(duration, example_count, failure_count, pending_count)
    dump_summary_original(duration, example_count, failure_count, pending_count)

    return if example_count.zero?

    stats = TestNotifier::Stats.new(:spec, {
      :total   => example_count,
      :fail    => failure_count,
      :pending => pending_count,
      :error   => nil
    })

    TestNotifier.notify(:status => stats.status, :message => stats.message) if example_count > 0
  end
end

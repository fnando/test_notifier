require "test_notifier"
require "spec/runner/formatter/base_text_formatter"

class Spec::Runner::Formatter::BaseTextFormatter
  alias dump_summary_original dump_summary

  def dump_summary(duration, examples, failed, pending)
    dump_summary_original(duration, examples, failed, pending)

    begin
      return if examples == 0
      status = failed > 0 ? :fail : :success
      message = "#{examples} examples, #{failed} failed, #{pending} pending"
      TestNotifier.notify(:status => status, :message => message)
    rescue
    end
  end
end

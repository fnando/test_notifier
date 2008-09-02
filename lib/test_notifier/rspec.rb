require 'test_notifier'
require 'spec/runner/formatter/base_text_formatter'

class Spec::Runner::Formatter::BaseTextFormatter
  alias dump_summary_original dump_summary
  
  def dump_summary(duration, examples, failed, pending)
    dump_summary_original(duration, examples, failed, pending)
    
    begin
      return if examples == 0
      
      if failed > 0
        title = TestNotifier::FAILURE_TITLE
        image = TestNotifier::ERROR_IMAGE
      else
        title = TestNotifier::PASSED_TITLE
        image = TestNotifier::PASSED_IMAGE
      end
      
      message = "#{examples} examples, #{failed} failed, #{pending} pending"
      TestNotifier::notify(image, title, message)
    rescue
    end
  end
end
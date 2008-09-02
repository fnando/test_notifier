require 'test_notifier'
require 'test/unit/ui/console/testrunner'

class Test::Unit::UI::Console::TestRunner
  alias finished_original finished
          
  def finished(elapsed_time)
    finished_original(elapsed_time)
    
    begin
      content = @result.to_s
      TestNotifier.notification_for_test_unit(content)
    rescue
    end
  end
end
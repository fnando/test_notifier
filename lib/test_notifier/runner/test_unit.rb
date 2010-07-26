require "test_notifier"
require "test/unit/ui/console/testrunner"

class Test::Unit::UI::Console::TestRunner
  alias finished_original finished

  def finished(elapsed_time)
    finished_original(elapsed_time)

    begin
      re = /(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/
      _, tests, assertions, failures, errors = *@result.to_s.match(re)

      return if tests.to_i == 0

      status = (failures.to_i + errors.to_i) > 0 ? :fail : :success
      message = "#{tests} tests, #{assertions} assertions, #{failures} failures, #{errors} errors"
      TestNotifier.notify(:status => status, :message => message)
    rescue
    end
  end
end

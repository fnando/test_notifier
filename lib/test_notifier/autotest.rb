require 'test_notifier'

Autotest.add_hook :ran_command do |at|
  begin
    content = at.results.to_s
  
    TestNotifier.rspec?(content) ? 
      TestNotifier.notification_for_rspec(content) : 
      TestNotifier.notification_for_test_unit(content)
  rescue
  end
end
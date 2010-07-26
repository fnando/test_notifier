require "test_notifier"

Autotest.add_hook :ran_command do |at|
  begin
    content = at.results.to_s
    rspec_matches = content.match(/(\d+) examples?, (\d+) failures?(, (\d+) pendings?)?/)
    test_unit_matches = content.match(/(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/)

    if rspec_matches
      _, examples, failures, pending = *rspec_matches
      status = failures.to_i > 0 ? :fail : :success
      message = "#{examples} examples, #{failures} failed, #{pending} pending"
      TestNotifier.notify(:status => status, :message => message) unless examples.to_i.zero?
    elsif test_unit_matches
      _, tests, assertions, failures, errors = *test_unit_matches

      status = failures.to_i > 0 ? :fail : :success
      message = "#{tests} tests, #{assertions} assertions, #{failures} failures, #{errors} errors"
      TestNotifier.notify(:status => status, :message => message) unless tests.to_i.zero?
    end
  rescue
  end
end

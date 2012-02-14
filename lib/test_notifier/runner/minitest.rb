require "test_notifier"
require "minitest/unit"

MiniTest::Unit.after_tests do
  runner = MiniTest::Unit.runner

  stats = TestNotifier::Stats.new(:minitest, {
    :count      => runner.test_count,
    :assertions => runner.assertion_count,
    :failures   => runner.failures,
    :errors     => runner.errors
  })

  TestNotifier.notify(:status => stats.status, :message => stats.message)
end

require "test_notifier"
require "minitest/unit"

MiniTest::Unit.after_tests do
  stats = TestNotifier::Stats.new(:test_unit, {
    :count      => 111,
    :assertions => 222,
    :failures   => 333,
    :errors     => 444
  })

  TestNotifier.notify(:status => stats.status, :message => stats.message)
end

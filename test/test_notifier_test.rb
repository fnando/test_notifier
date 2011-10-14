require "test_helper"

class TestNotifierTest < Test::Unit::TestCase
  def setup
    unsupport_all_notifiers
  end

  test "use default notifier" do
    Notifier::Growl.stubs(:supported?).returns(true)
    Notifier::Snarl.stubs(:supported?).returns(true)
    TestNotifier.default_notifier = :snarl

    assert_equal Notifier::Snarl, TestNotifier.notifier
  end

  test "output error message to $stderr when there's no supported notifier" do
    STDERR.expects(:<<).with(TestNotifier::NO_NOTIFIERS_MESSAGE).once
    Notifier::Placebo.expects(:supported?).returns(true)
    Notifier::Placebo.expects(:notify).once
    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  test "output error message won't display when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true
    STDERR.expects(:<<).with(TestNotifier::NO_NOTIFIERS_MESSAGE).never
    Notifier::Placebo.expects(:supported?).returns(true)
    Notifier::Placebo.expects(:notify).once
    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  test "send notification to supported notifier" do
    Notifier::Snarl.expects(:supported?).returns(true)
    Notifier::Snarl.expects(:notify).with({
      :status  => :fail,
      :message => "You have failed!",
      :title   => TestNotifier::TITLES[:fail],
      :image   => TestNotifier::IMAGES[:fail],
      :color   => TestNotifier::COLORS[:fail]
    })

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end
end

require "test_helper"

class TestNotifierTest < Test::Unit::TestCase
  def setup
    TestNotifier.__notifier__ = nil
    unsupport_all_notifiers
  end

  test "return default notifier when is set" do
    TestNotifier.default_notifier = :osd_cat
    TestNotifier::Notifier::OsdCat.expects(:supported?).returns(true)

    assert_equal TestNotifier::Notifier::OsdCat, TestNotifier.notifier
  end

  test "return next available notifier when default notifier is not supported" do
    TestNotifier.default_notifier = :osd_cat
    TestNotifier::Notifier::Snarl.expects(:supported?).returns(true)

    assert_equal TestNotifier::Notifier::Snarl, TestNotifier.notifier
  end

  test "raise error when there's no supported notifier" do
    assert_raise TestNotifier::UnsupportedNotifierError do
      TestNotifier.notifier
    end
  end

  test "send notification to supported notifier" do
    TestNotifier::Notifier::Snarl.expects(:supported?).returns(true)
    TestNotifier::Notifier::Snarl.expects(:notify).with({
      :status  => :fail,
      :message => "You have failed!",
      :title   => TestNotifier::TITLES[:fail],
      :image   => TestNotifier::IMAGES[:fail]
    })

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end
end

require "test_helper"

class TestNotifier::NotifierTest < Test::Unit::TestCase
  def setup
    unsupport_all_notifiers
  end

  test "retrieve list of supported notifiers" do
    TestNotifier::Notifier::Snarl.expects(:supported?).returns(true)
    TestNotifier::Notifier::Knotify.expects(:supported?).returns(true)

    assert_equal 2, TestNotifier::Notifier.supported_notifiers.size
  end

  test "retrieve list of all notifiers" do
    assert_equal 6, TestNotifier::Notifier.notifiers.size
  end

  test "return notifier by its name" do
    assert_equal TestNotifier::Notifier::OsdCat, TestNotifier::Notifier.from_name(:osd_cat)
    assert_equal TestNotifier::Notifier::NotifySend, TestNotifier::Notifier.from_name(:notify_send)
    assert_equal TestNotifier::Notifier::Growl, TestNotifier::Notifier.from_name(:growl)
  end

  test "return notifier by its name when supported" do
    TestNotifier::Notifier::Snarl.expects(:supported?).returns(true)

    assert_equal TestNotifier::Notifier::Snarl, TestNotifier::Notifier.supported_notifier_from_name(:snarl)
  end

  test "return nil when have supported notifiers" do
    assert_nil TestNotifier::Notifier.supported_notifier_from_name(:snarl)
  end

  test "return nil when an invalid notifier name is provided" do
    assert_nil TestNotifier::Notifier.from_name(:invalid)
    assert_nil TestNotifier::Notifier.supported_notifier_from_name(:invalid)
  end
end

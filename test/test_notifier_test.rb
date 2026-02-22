# frozen_string_literal: true

require "test_helper"

class TestNotifierTest < Minitest::Test
  setup { unsupport_all_notifiers }
  teardown { TestNotifier.default_notifier = :hud }

  test "uses default notifier" do
    Notifier::Knotify.stubs(:supported?).returns(true)
    Notifier::Snarl.stubs(:supported?).returns(true)
    TestNotifier.default_notifier = :snarl

    assert_equal Notifier::Snarl, TestNotifier.notifier
  end

  test "outputs error message to when there's no supported notifier" do
    Notifier.stubs(:notifier).returns(Notifier::Noop)
    TestNotifier.silence_no_notifier_warning = false

    _, err = capture_io do
      TestNotifier.notify status: :fail, message: "You have failed!"
    end

    assert_includes err, TestNotifier::NO_NOTIFIERS_MESSAGE
  end

  test "doesn't output error message when silence is enabled" do
    TestNotifier.silence_no_notifier_warning = true

    $stderr.expects(:<<).never
    Notifier::Noop.expects(:notify).at_least(1)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  test "sends notification to supported notifier" do
    args = {
      status: :fail,
      message: "You have failed!",
      title: TestNotifier::TITLES[:fail],
      image: TestNotifier::IMAGES[:fail],
      color: TestNotifier::COLORS[:fail]
    }

    Notifier::Snarl.stubs(:supported?).returns(true)
    Notifier::Snarl.expects(:notify).with(args)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  test "sets symbol name for hud notifier (failed)" do
    args = {
      message: "You have failed!",
      title: "Failed!",
      image: "exclamationmark.triangle",
      color: "orange",
      status: :fail
    }

    Notifier::Hud.stubs(:supported?).returns(true)
    Notifier::Hud.expects(:notify).with(args)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  test "sets symbol name for hud notifier (success)" do
    args = {
      message: "You passed!",
      title: "Passed!",
      image: "checkmark.circle",
      color: "green",
      status: :success
    }

    Notifier::Hud.stubs(:supported?).returns(true)
    Notifier::Hud.expects(:notify).with(args)

    TestNotifier.notify status: :success, message: "You passed!"
  end

  test "sets symbol name for hud notifier (error)" do
    args = {
      message: "You have errored!",
      title: "Error!",
      image: "xmark.octagon",
      color: "red",
      status: :error
    }

    Notifier::Hud.stubs(:supported?).returns(true)
    Notifier::Hud.expects(:notify).with(args)

    TestNotifier.notify status: :error, message: "You have errored!"
  end
end

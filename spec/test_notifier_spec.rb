# frozen_string_literal: true

require "spec_helper"

describe TestNotifier do
  before { unsupport_all_notifiers }

  it "uses default notifier" do
    allow(Notifier::Hud).to receive(:supported?).and_return(true)
    allow(Notifier::Snarl).to receive(:supported?).and_return(true)
    TestNotifier.default_notifier = :snarl

    expect(TestNotifier.notifier).to eql(Notifier::Snarl)
  end

  it "outputs error message to $stderr when there's no supported notifier" do
    expect($stderr).to receive(:<<).with(TestNotifier::NO_NOTIFIERS_MESSAGE)
    expect(Notifier::Placebo).to receive(:notify)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  it "doesn't output error message when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true

    expect($stderr).not_to receive(:<<)
    expect(Notifier::Placebo).to receive(:notify)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  it "sends notification to supported notifier" do
    args = {
      status: :fail,
      message: "You have failed!",
      title: TestNotifier::TITLES[:fail],
      image: TestNotifier::IMAGES[:fail],
      color: TestNotifier::COLORS[:fail]
    }

    allow(Notifier::Snarl).to receive(:supported?).and_return(true)
    expect(Notifier::Snarl).to receive(:notify).with(args)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  it "sets symbol name for hud notifier (failed)" do
    args = {
      message: "You have failed!",
      title: "Failed!",
      image: "exclamationmark.triangle",
      color: "orange",
      status: :fail
    }

    allow(Notifier::Hud).to receive(:supported?).and_return(true)
    expect(Notifier::Hud).to receive(:notify).with(args)

    TestNotifier.notify status: :fail, message: "You have failed!"
  end

  it "sets symbol name for hud notifier (success)" do
    args = {
      message: "You passed!",
      title: "Passed!",
      image: "checkmark.circle",
      color: "green",
      status: :success
    }

    allow(Notifier::Hud).to receive(:supported?).and_return(true)
    expect(Notifier::Hud).to receive(:notify).with(args)

    TestNotifier.notify status: :success, message: "You passed!"
  end

  it "sets symbol name for hud notifier (error)" do
    args = {
      message: "You have errored!",
      title: "Error!",
      image: "xmark.octagon.fill",
      color: "red",
      status: :error
    }

    allow(Notifier::Hud).to receive(:supported?).and_return(true)
    expect(Notifier::Hud).to receive(:notify).with(args)

    TestNotifier.notify status: :error, message: "You have errored!"
  end
end

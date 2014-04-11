require "spec_helper"

describe TestNotifier do
  before { unsupport_all_notifiers }

  it "uses default notifier" do
    allow(Notifier::Growl).to receive(:supported?).and_return(true)
    allow(Notifier::Snarl).to receive(:supported?).and_return(true)
    TestNotifier.default_notifier = :snarl

    expect(TestNotifier.notifier).to eql(Notifier::Snarl)
  end

  it "outputs error message to $stderr when there's no supported notifier" do
    expect(STDERR).to receive(:<<).with(TestNotifier::NO_NOTIFIERS_MESSAGE)
    expect(Notifier::Placebo).to receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "outputs error message won't display when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true

    expect(STDERR).not_to receive(:<<)
    expect(Notifier::Placebo).to receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "outputs error message won't display when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true

    expect(STDERR).not_to receive(:<<)
    expect(Notifier::Placebo).to receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "sends notification to supported notifier" do
    allow(Notifier::Snarl).to receive(:supported?).and_return(true)
    expect(Notifier::Snarl).to receive(:notify).with({
      :status  => :fail,
      :message => "You have failed!",
      :title   => TestNotifier::TITLES[:fail],
      :image   => TestNotifier::IMAGES[:fail],
      :color   => TestNotifier::COLORS[:fail]
    })

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end
end

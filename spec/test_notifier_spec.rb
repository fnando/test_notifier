require "spec_helper"

describe TestNotifier do
  before { unsupport_all_notifiers }

  it "uses default notifier" do
    Notifier::Growl.stub :supported? => true
    Notifier::Snarl.stub :supported? => true
    TestNotifier.default_notifier = :snarl

    expect(TestNotifier.notifier).to eql(Notifier::Snarl)
  end

  it "outputs error message to $stderr when there's no supported notifier" do
    STDERR
      .should_receive(:<<)
      .with(TestNotifier::NO_NOTIFIERS_MESSAGE)

    Notifier::Placebo.should_receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "outputs error message won't display when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true

    STDERR.should_not_receive(:<<)
    Notifier::Placebo.should_receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "outputs error message won't display when silence_no_notifier_warning is true" do
    TestNotifier.silence_no_notifier_warning = true

    STDERR.should_not_receive(:<<)
    Notifier::Placebo.should_receive(:notify)

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end

  it "sends notification to supported notifier" do
    Notifier::Snarl.stub :supported? => true
    Notifier::Snarl.should_receive(:notify).with({
      :status  => :fail,
      :message => "You have failed!",
      :title   => TestNotifier::TITLES[:fail],
      :image   => TestNotifier::IMAGES[:fail],
      :color   => TestNotifier::COLORS[:fail]
    })

    TestNotifier.notify :status => :fail, :message => "You have failed!"
  end
end

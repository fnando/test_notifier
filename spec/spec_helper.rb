require "test_notifier"

module SpecHelpers
  def unsupport_all_notifiers
    Notifier.notifiers.each do |notifier|
      allow(notifier).to receive(:supported?).and_return(false) unless notifier == Notifier::Placebo
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end

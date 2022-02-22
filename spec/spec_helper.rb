# frozen_string_literal: true

require "bundler/setup"
require "test_notifier"

module SpecHelpers
  def unsupport_all_notifiers
    Notifier.notifiers.each do |notifier|
      unless notifier == Notifier::Placebo
        allow(notifier).to receive(:supported?).and_return(false)
      end
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end

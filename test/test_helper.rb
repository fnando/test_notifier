# frozen_string_literal: true

require "bundler/setup"
require "minitest/utils"
require "minitest/autorun"
require "test_notifier"

module Minitest
  class Test
    def unsupport_all_notifiers
      Notifier.notifiers.each do |notifier|
        next if notifier == Notifier::Noop

        notifier.stubs(:supported?).returns(false)
      end
    end
  end
end

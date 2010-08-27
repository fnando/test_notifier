gem "test-unit"
require "test/unit"
require "mocha"

require "test_notifier"

class Test::Unit::TestCase
  private
  def unsupport_all_notifiers
    TestNotifier::Notifier.constants.each do |name|
      notifier = TestNotifier::Notifier.const_get(name)
      notifier.stubs(:supported?).returns(false)
    end
  end
end

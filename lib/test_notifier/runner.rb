module TestNotifier
  module Runner
    autoload :RSpec,    "test_notifier/runner/rspec"
    autoload :Spec,     "test_notifier/runner/spec"
    autoload :TestUnit, "test_notifier/runner/test_unit"
  end
end

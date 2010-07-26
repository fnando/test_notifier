if defined?(RSpec)
  require "test_notifier/runner/rspec"
else
  require "test_notifier/runner/spec"
end

warn <<-TXT
[TestNotifier] Using `require "test_notifier/rspec"` is deprecated and
will be removed in the future. Please use `require "test_notifier/runner/spec"`
or `require "test_notifier/runner/rspec"` for RSpec 2 instead.
TXT

require "test_notifier/runner/autotest"

warn <<-TXT
[TestNotifier] Using `require "test_notifier/autotest"` is deprecated and
will be removed in the future. Please update your `~/.autotest` file to use
`require "test_notifier/runner/autotest"` instead.
TXT

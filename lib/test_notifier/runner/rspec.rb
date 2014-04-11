require "rspec/core/version"

if RSpec::Core::Version::STRING >= "3.0.0"
  require "test_notifier/runner/rspec3"
else
  require "test_notifier/runner/rspec2"
end

require "test_notifier"

Autotest.add_hook :ran_command do |at|
  begin
    content = at.results.to_s

    rspec_matches = content.match(/(\d+) examples?, (\d+) failures?(, (\d+) pendings?)?/)
    test_unit_matches = content.match(/(\d+) tests, (\d+) assertions, (\d+) failures, (\d+) errors/)

    if rspec_matches
      _, examples, failures, _, pending = *rspec_matches

      stats = TestNotifier::Stats.new(:spec, {
        :count    => examples,
        :failures => failures,
        :pending  => pending
      })

      TestNotifier.notify(:status => stats.status, :message => stats.message) unless examples.to_i.zero?
    elsif test_unit_matches
      _, tests, assertions, failures, errors = *test_unit_matches

      stats = TestNotifier::Stats.new(:test_unit, {
        :count      => tests,
        :assertions => assertions,
        :failures   => failures,
        :errors     => errors
      })

      TestNotifier.notify(:status => stats.status, :message => stats.message) unless tests.to_i.zero?
    end
  rescue => e
    puts e
    puts e.backtrace
  end
end

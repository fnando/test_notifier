# frozen_string_literal: true

require "test_helper"

class StatsMinitestTest < Minitest::Test
  let(:stats) { TestNotifier::Stats.new(:minitest) }

  test "returns success message" do
    stats.options = {count: 10, assertions: 20}

    assert_equal "10 tests, 20 assertions", stats.message
  end

  test "message with failing tests" do
    stats.options = {count: 10, assertions: 20, failures: 5}

    assert_equal "10 tests, 20 assertions, 5 failed", stats.message
  end

  test "message with error tests" do
    stats.options = {count: 10, assertions: 20, errors: 5}

    assert_equal "10 tests, 20 assertions, 5 errors", stats.message
  end

  test "message with pending tests" do
    stats.options = {count: 10, assertions: 20, pending: 5}

    assert_equal "10 tests, 20 assertions, 5 pending", stats.message
  end

  test "message with all types" do
    stats.options = {
      count: 6,
      failures: 2,
      errors: 3,
      assertions: 20,
      pending: 4
    }

    expected = "6 tests, 20 assertions, 2 failed, 3 errors, 4 pending"

    assert_equal expected, stats.message
  end
end

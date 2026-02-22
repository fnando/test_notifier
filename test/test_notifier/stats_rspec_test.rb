# frozen_string_literal: true

require "test_helper"

class StatsTest < Minitest::Test
  let(:stats) { TestNotifier::Stats.new(:rspec) }

  test "returns success message" do
    stats.options = {count: 10}

    assert_equal "10 examples", stats.message
  end

  test "returns message with failing examples" do
    stats.options = {count: 10, failures: 5}

    assert_equal "10 examples, 5 failed", stats.message
  end

  test "returns message with pending examples" do
    stats.options = {count: 10, pending: 5}

    assert_equal "10 examples, 5 pending", stats.message
  end

  test "returns message with error examples" do
    stats.options = {count: 10, failures: 5, errors: 5}

    assert_equal "10 examples, 5 failed, 5 errors", stats.message
  end

  test "returns message with all types" do
    stats.options = {count: 6, failures: 3, errors: 2, pending: 3}

    assert_equal "6 examples, 3 failed, 3 pending, 2 errors", stats.message
  end
end

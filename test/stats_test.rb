require "test_helper"

class TestNotifier::Stats::RSpecTest < Test::Unit::TestCase
  def setup
    @stats = TestNotifier::Stats.new(:rspec)
  end

  test "success message" do
    @stats.options = { :total => 10 }
    assert_equal "10 examples", @stats.message
  end

  test "message with failing examples" do
    @stats.options = { :total => 10, :fail => 5 }
    assert_equal "10 examples, 5 failed", @stats.message
  end

  test "message with pending examples" do
    @stats.options = { :total => 10, :pending => 5 }
    assert_equal "10 examples, 5 pending", @stats.message
  end

  test "message with error examples" do
    @stats.options = { :total => 10, :fail => 5, :errors => 5 }
    assert_equal "10 examples, 5 errors", @stats.message
  end

  test "message with all types" do
    @stats.options = { :total => 6, :fail => 3, :errors => 2, :pending => 3 }
    assert_equal "6 examples, 1 failed, 3 pending, 2 errors", @stats.message
  end
end

class TestNotifier::Stats::SpecTest < Test::Unit::TestCase
  def setup
    @stats = TestNotifier::Stats.new(:spec)
  end

  test "success message" do
    @stats.options = { :total => 10 }
    assert_equal "10 examples", @stats.message
  end

  test "message with failing examples" do
    @stats.options = { :total => 10, :fail => 5 }
    assert_equal "10 examples, 5 failed", @stats.message
  end

  test "message with pending examples" do
    @stats.options = { :total => 10, :pending => 5 }
    assert_equal "10 examples, 5 pending", @stats.message
  end

  test "message with all types" do
    @stats.options = { :total => 6, :fail => 2, :pending => 3 }
    assert_equal "6 examples, 2 failed, 3 pending", @stats.message
  end
end

class TestNotifier::Stats::TestUnitTest < Test::Unit::TestCase
  def setup
    @stats = TestNotifier::Stats.new(:test_unit)
  end

  test "success message" do
    @stats.options = { :total => 10, :assertions => 20 }
    assert_equal "10 tests, 20 assertions", @stats.message
  end

  test "message with failing examples" do
    @stats.options = { :total => 10, :assertions => 20, :fail => 5 }
    assert_equal "10 tests, 20 assertions, 5 failed", @stats.message
  end

  test "message with error examples" do
    @stats.options = { :total => 10, :assertions => 20, :errors => 5 }
    assert_equal "10 tests, 20 assertions, 5 errors", @stats.message
  end

  test "message with all types" do
    @stats.options = { :total => 6, :fail => 2, :errors => 3, :assertions => 20 }
    assert_equal "6 tests, 20 assertions, 2 failed, 3 errors", @stats.message
  end
end

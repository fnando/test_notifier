# frozen_string_literal: true

require "bundler/setup"
require "minitest/autorun"
require "test_notifier"

class MinitestSample < Minitest::Test
  def test_passes
    assert true
    assert true
  end

  def test_fails
    refute true
  end

  def test_errors
    raise "foo"
  end

  def test_flunks
    flunk "this is pending"
  end
end

class MinitestSample2 < Minitest::Test
  def test_passes
    assert true
  end
end

# frozen_string_literal: true

require "bundler/setup"
require "rspec/autorun"
require "test_notifier"

describe "test" do
  it "passes" do
    expect(true).to be
  end

  it "passes too" do
    expect(true).to be
  end

  it "fails" do
    expect(false).to be
  end

  it "pending" do
    expect(true).to be
  end

  it "raises" do
    throw "error"
  end
end

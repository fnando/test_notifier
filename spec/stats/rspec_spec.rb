require "spec_helper"

describe TestNotifier::Stats, "RSpec" do
  subject(:stats) { TestNotifier::Stats.new(:rspec) }

  it "returns success message" do
    stats.options = { :count => 10 }
    expect(stats.message).to eql("10 examples")
  end

  it "returns message with failing examples" do
    stats.options = { :count => 10, :failures => 5 }
    expect(stats.message).to eql("10 examples, 5 failed")
  end

  it "returns message with pending examples" do
    stats.options = { :count => 10, :pending => 5 }
    expect(stats.message).to eql("10 examples, 5 pending")
  end

  it "returns message with error examples" do
    stats.options = { :count => 10, :failures => 5, :errors => 5 }
    expect(stats.message).to eql("10 examples, 5 failed, 5 errors")
  end

  it "returns message with all types" do
    stats.options = { :count => 6, :failures => 3, :errors => 2, :pending => 3 }
    expect(stats.message).to eql("6 examples, 3 failed, 3 pending, 2 errors")
  end
end

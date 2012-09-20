require "spec_helper"

describe TestNotifier::Stats, "MiniTest" do
  subject(:stats) { TestNotifier::Stats.new(:minitest) }

  it "returns success message" do
    stats.options = { :count => 10, :assertions => 20 }
    expect(stats.message).to eql("10 tests, 20 assertions")
  end

  it "message with failing examples" do
    stats.options = { :count => 10, :assertions => 20, :failures => 5 }
    expect(stats.message).to eql("10 tests, 20 assertions, 5 failed")
  end

  it "message with error examples" do
    stats.options = { :count => 10, :assertions => 20, :errors => 5 }
    expect(stats.message).to eql("10 tests, 20 assertions, 5 errors")
  end

  it "message with all types" do
    stats.options = { :count => 6, :failures => 2, :errors => 3, :assertions => 20 }
    expect(stats.message).to eql("6 tests, 20 assertions, 2 failed, 3 errors")
  end
end


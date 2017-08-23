require_relative "./spec_helper"

RSpec.describe VivialConnect::Log do

  #todo add the aggregate one

  it "responds to .create" do
    expect(VivialConnect::Log).to respond_to(:create)
  end

  it "builds the correct .create path"

  it "responds to .find_by_time" do
    expect(VivialConnect::Log).to respond_to(:find_by_time)
  end

  it "builds the correct .find_by_time path"
end

require_relative "./spec_helper"

RSpec.describe VivialConnect::Contact do

  it "responds to .create" do 
    expect(VivialConnect::Contact).to respond_to(:create) 
  end

  it "responds to .all" do
    expect(VivialConnect::Contact).to respond_to(:all)  
  end

  it "responds to .find" do
    expect(VivialConnect::Contact).to respond_to(:find) 
  end 

  it "responds to .count" do 
    expect(VivialConnect::Contact).to respond_to(:count) 
  end

  it "responds to .update" do 
    expect(VivialConnect::Contact).to respond_to(:update) 
  end

  it "responds to .delete" do 
    expect(VivialConnect::Contact).to respond_to(:delete) 
  end 

end

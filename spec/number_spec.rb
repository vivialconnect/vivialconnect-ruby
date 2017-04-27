require_relative "./spec_helper"

RSpec.describe VivialConnect::Number do

  it "responds to .create" do 
    expect(VivialConnect::Number).to respond_to(:create) 
  end

  it "responds to .all" do
    expect(VivialConnect::Number).to respond_to(:all)  
  end

  it "responds to .find" do
    expect(VivialConnect::Number).to respond_to(:find) 
  end 

  it "responds to .count" do 
    expect(VivialConnect::Number).to respond_to(:count) 
  end

  it "responds to .update" do 
    expect(VivialConnect::Number).to respond_to(:update) 
  end

  it "responds to .delete" do 
    expect(VivialConnect::Number).to respond_to(:delete) 
  end

  it "responds to .available_numbers" do 
    expect(VivialConnect::Number).to respond_to(:available_numbers) 
  end

  it "responds to .lookup" do 
    expect(VivialConnect::Number).to respond_to(:lookup) 
  end

  it "responds to .buy" do 
    expect(VivialConnect::Number).to respond_to(:buy) 
  end

end



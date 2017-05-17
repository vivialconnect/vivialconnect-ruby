require_relative "./spec_helper"

RSpec.describe VivialConnect::Account do

  #todo add subaccount user creation

  it "responds to .create" do 
    expect(VivialConnect::Account).to respond_to(:create) 
  end

  it "responds to .all" do
    expect(VivialConnect::Account).to respond_to(:all)  
  end

  it "responds to .find" do
    expect(VivialConnect::Account).to respond_to(:find) 
  end 

  it "responds to .count" do 
    expect(VivialConnect::Account).to respond_to(:count) 
  end

  it "responds to .update" do 
    expect(VivialConnect::Account).to respond_to(:update) 
  end

  it "responds to .delete" do 
    expect(VivialConnect::Account).to respond_to(:delete) 
  end 

end

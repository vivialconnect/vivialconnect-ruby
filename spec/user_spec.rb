require_relative "./spec_helper"

RSpec.describe VivialConnect::User do

  #TODO check which ones -- 

  it "responds to .create" do 
    expect(VivialConnect::User).to respond_to(:create) 
  end

  it "responds to .all" do
    expect(VivialConnect::User).to respond_to(:all)  
  end

  it "responds to .find" do
    expect(VivialConnect::User).to respond_to(:find) 
  end 

  it "responds to .count" do 
    expect(VivialConnect::User).to respond_to(:count) 
  end

  it "responds to .update" do 
    expect(VivialConnect::User).to respond_to(:update) 
  end

  it "responds to .delete" do 
    expect(VivialConnect::User).to respond_to(:delete) 
  end

  it "responds to .update_password" do 
    expect(VivialConnect::User).to respond_to(:update_password) 
  end 



end



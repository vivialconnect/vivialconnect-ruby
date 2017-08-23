require_relative "./spec_helper"

RSpec.describe VivialConnect::Account do

  before do
    @client = VivialConnect::Client.instance
  end

  it "responds to .create" do
    expect(VivialConnect::Account).to respond_to(:create)
  end

  it "builds the correct create path" do
    expect(@client).to receive(:make_request).with('POST', "accounts.json", anything)
    VivialConnect::Account.create(name: 'hello world')
  end

  it "responds to .all" do
    expect(VivialConnect::Account).to respond_to(:all)
  end

  it "builds the correct all .path" do
    allow(@client).to receive(:make_request).with('GET', "accounts.json?page=1&limit=100").and_return([])
    VivialConnect::Account.all
  end

  it "responds to .find" do
    expect(VivialConnect::Account).to respond_to(:find)
  end

  it "builds the correct .find path" do
    expect(@client).to receive(:make_request).with('GET', "accounts/1.json")
    VivialConnect::Account.find(1)
  end

  it "responds to .count" do
    expect(VivialConnect::Account).to respond_to(:count)
  end

  it "builds the correct .count path" do
    expect(@client).to receive(:make_request).with("GET", "/accounts/count.json")
    VivialConnect::Account.count
  end

  it "responds to .update" do
    expect(VivialConnect::Account).to respond_to(:update)
  end

  it "builds correct update path" do
    expect(@client).to receive(:make_request).with("PUT", "accounts/1.json", anything)
    VivialConnect::Account.update(1, name:"new name")
  end

  it "responds to .delete" do
    expect(VivialConnect::Account).to respond_to(:delete)
  end

  it 'builds the correct .delete path' do
    expect(@client).to receive(:make_request).with("DELETE", "accounts/1.json", anything)
    VivialConnect::Account.delete(1)
  end

end

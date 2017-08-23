require_relative "./spec_helper"

RSpec.describe VivialConnect::Connector do

  context "class" do

    before do 
      @client = VivialConnect::Client.instance
    end

    it "responds to .create" do
      expect(VivialConnect::Connector).to respond_to(:create)
    end

    it "builds the correct create path" do
      expect(@client).to receive(:make_request).with('POST', "/connectors.json", anything)
      VivialConnect::Connector.create(name: 'hello world')
    end

    it "responds to .all" do
      expect(VivialConnect::Connector).to respond_to(:all)
    end

    it "builds the correct all .path" do
      allow(@client).to receive(:make_request).with("GET", "/connectors.json?page=1&limit=100").and_return([])
      VivialConnect::Connector.all
    end

    it "responds to .find" do
      expect(VivialConnect::Connector).to respond_to(:find)
    end

    it "builds the correct .find path" do
      expect(@client).to receive(:make_request).with('GET', "/connectors/1.json")
      VivialConnect::Connector.find(1)
    end

    it "responds to .count" do
      expect(VivialConnect::Connector).to respond_to(:count)
    end

    it "builds the correct .count path" do
      expect(@client).to receive(:make_request).with("GET", "/connectors/count.json")
      VivialConnect::Connector.count
    end

    it "responds to .update" do
      expect(VivialConnect::Connector).to respond_to(:update)
    end

    it "builds the correct .update path" do
      expect(@client).to receive(:make_request).with('PUT', "/connectors/1.json", anything)
      VivialConnect::Connector.update(1, name: "New World")
    end

    it "responds to .delete" do
      expect(VivialConnect::Connector).to respond_to(:delete)
    end

    it "builds the correct .delete path" do
      expect(@client).to receive(:make_request).with('DELETE', "/connectors/1.json", anything)
      VivialConnect::Connector.delete(1)
    end
  end

  context "instance" do

    it "responds to #save" do
      expect(VivialConnect::Connector.new()).to respond_to(:save)
    end

    it "responds to #add_connector" do
      expect(VivialConnect::Connector.new()).to respond_to(:add_callback)
    end

    it "performs #add_callback correctly"

    it "responds to #delete_callback" do
      expect(VivialConnect::Connector.new()).to respond_to(:delete_callback)
    end

    it "performs #delete_callback correctly"

    it "responds to #add_number" do
      expect(VivialConnect::Connector.new()).to respond_to(:add_number)
    end

    it "performs #add_number correctly"

    it "responds to #delete_number" do
      expect(VivialConnect::Connector.new()).to respond_to(:delete_number)
    end

    it "performs #delete_number correctly"

  end

end

RSpec.describe VivialConnect::Connector::Callback do

  before do 
    @client = VivialConnect::Client.instance
  end

  it "responds to .create_by_connector_id" do
    expect(VivialConnect::Connector::Callback).to respond_to(:create_by_connector_id)
  end

  it "builds the correct create_by_connector_id path" do
    expect(@client).to receive(:make_request).with("POST", "/connectors/1/callbacks.json", anything)
    VivialConnect::Connector::Callback.create_by_connector_id(1, event_type: "status", message_type: "text", url: "path/for/call")
  end

  it "responds to .update_by_connector_id" do
    expect(VivialConnect::Connector::Callback).to respond_to(:update_by_connector_id)
  end

  it "builds the correct .update path" do
    expect(@client).to receive(:make_request).with("PUT", "/connectors/1/callbacks.json", anything)
    VivialConnect::Connector::Callback.update_by_connector_id(1, event_type: "status", message_type: "text", url: "path/for/call/part2")
  end

  it "responds to .delete_by_connector_id" do
    expect(VivialConnect::Connector::Callback).to respond_to(:delete)
  end

  it "builds the correct .delete_by_connector_id path" do
    expect(@client).to receive(:make_request).with("DELETE", "/connectors/1/callbacks.json", anything)
    VivialConnect::Connector::Callback.delete(1)
  end

end

RSpec.describe VivialConnect::Connector::Number do

  before do 
    @client = VivialConnect::Client.instance
  end

  it "responds to .create_by_connector_id" do
    expect(VivialConnect::Connector::Number).to respond_to(:create_by_connector_id)
  end

  it "builds the correct create path" do
    expect(@client).to receive(:make_request).with("POST", "/connectors/1/phone_numbers.json", anything)
    VivialConnect::Connector::Number.create_by_connector_id(1, phone_number: "+18887776666", phone_number_id: 1)
  end

  it "builds the correct .count path" do
    expect(@client).to receive(:make_request).with("GET", "/connectors/1/phone_numbers/count.json")
    VivialConnect::Connector::Number.count_by_connector_id(1)
  end

  it "responds to .update_by_connector_id" do
    expect(VivialConnect::Connector::Number).to respond_to(:update_by_connector_id)
  end

  it "builds the correct .update path" do
    expect(@client).to receive(:make_request).with("PUT", "/connectors/1/phone_numbers.json", anything)
    VivialConnect::Connector::Number.update_by_connector_id(1, phone_number: "+15557776666", phone_number_id: 2)
  end

  it "responds to .delete" do
    expect(VivialConnect::Connector::Number).to respond_to(:delete)
  end

  it "builds the correct .delete path" do
    expect(@client).to receive(:make_request).with("DELETE", "/connectors/1/phone_numbers.json", anything)
    VivialConnect::Connector::Number.delete(1)
  end

end
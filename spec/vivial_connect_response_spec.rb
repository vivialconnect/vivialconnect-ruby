
require_relative "./spec_helper"
require 'faraday/adapter/test'
require_relative "./stubbed_response"

  context "client processes responses correctly" do 
    # using account as example

    before do
      VivialConnect::Client.configure('1234', '45678', 910)
      @client = VivialConnect::Client.instance
      @stubs = Faraday::Adapter::Test::Stubs.new
      @conn = Faraday.new do |builder|
        builder.adapter :test, @stubs 
      end
    end

    url = Addressable::URI.parse('https://api.vivialconnect.net/api/v1.0/accounts.json')

    it "processes ::Account.all" do
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts.json') { [200, {'Content-Type' => 'application/json'}, account_all] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(Array)
      expect(vivial_connect_response.count).to be(5)
      expect(vivial_connect_response.first.company_name).to eq("a first company")
      expect(vivial_connect_response.first.class).to be(VivialConnect::Account)
      expect(vivial_connect_response.first.id).to_not be(nil)
    end 

    it "processes ::Account.find" do 
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json') { [200, {'Content-Type' => 'application/json'}, account_find] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(VivialConnect::Account)
      expect(vivial_connect_response.id).to_not be(nil)
      expect(vivial_connect_response.id.class).to be(Fixnum)
      expect(vivial_connect_response.company_name).to eq("a first company")
    end 

    it "processes ::Account.count" do 
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts/count.json') { [200, {'Content-Type' => 'application/json'}, generic_count] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts/count.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(Fixnum)
      expect(vivial_connect_response).to_not be(nil)
      expect(vivial_connect_response).to eq(5)
    end

    it "processes ::Account.create (makes subaccount)" do 
      @stubs.post('https://api.vivialconnect.net/api/v1.0/accounts.json') { [200, {'Content-Type' => 'application/json'}, account_create] }
      resp = @conn.post('https://api.vivialconnect.net/api/v1.0/accounts.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(VivialConnect::Account)
      expect(vivial_connect_response.id).to be(10074)
      expect(vivial_connect_response.company_name).to eq("pauls pizza")
      expect(vivial_connect_response.id).to_not be(nil)
      expect(vivial_connect_response.id.class).to be(Fixnum)

    end 

    it "processes ::Account.update" do 
      @stubs.put('https://api.vivialconnect.net/api/v1.0/accounts/1.json') { [200, {'Content-Type' => 'application/json'}, account_update] }
      resp = @conn.put('https://api.vivialconnect.net/api/v1.0/accounts/1.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(VivialConnect::Account)
      expect(vivial_connect_response.id).to be(10074)
      expect(vivial_connect_response.company_name).to eq("paulo's pizza")
      expect(vivial_connect_response.id).to_not be(nil)
      expect(vivial_connect_response.id.class).to be(Fixnum)

    end 

    it "processes ::Configuration.delete" do 
      #Account.delete is not a supported endpoint, so using Configuration as the example
      @stubs.delete('https://api.vivialconnect.net/api/v1.0/configuration/1.json') { [200, {'Content-Type' => 'application/json'}, "{}"] }
      resp = @conn.delete('https://api.vivialconnect.net/api/v1.0/configuration/1.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response).to be(true)
    end 

    it "raises VivialConnectClientError for response codes >=400" do 
      @stubs.delete('https://api.vivialconnect.net/api/v1.0/configuration/39.json') { [400, {'Content-Type' => 'application/json'}, '{"message": "Resource not found for id 39"}'] }
      resp = @conn.delete('https://api.vivialconnect.net/api/v1.0/configuration/39.json')
      expect{ @client.process_api_response(resp, url) }.to raise_error("Resource not found for id 39")
    end 

    it "doesn't break when given valid json and < 400 status" do 
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json') { [301, {'Content-Type' => 'application/json'},  not_our_json_good] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json')
      vivial_connect_response = @client.process_api_response(resp, url)
      expect(vivial_connect_response.class).to be(VivialConnect::Account)
    end 

    it "breaks when given invalid json and < 400 status" do 
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json') { [301, {'Content-Type' => 'application/json'},  not_our_json_broken] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts/1.json')
      expect{ @client.process_api_response(resp, url) }.to raise_error(JSON::ParserError)
    end 


  end
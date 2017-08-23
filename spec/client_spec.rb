require_relative "./spec_helper"


RSpec.describe VivialConnect::Client do

  before do
    VivialConnect::Client.configure('1234', '45678', 999)
    @client = VivialConnect::Client.instance
  end

  context ".configure" do

    it "sets the class variables used in the singleton initialization" do
      expect(VivialConnect::Client.class_variable_get(:@@api_key)).to eq('1234')
      expect(VivialConnect::Client.class_variable_get(:@@api_secret)).to eq('45678')
      expect(VivialConnect::Client.class_variable_get(:@@account_id)).to eq(999)
      expect(VivialConnect::Client.class_variable_get(:@@host)).to eq("https://api.vivialconnect.net/api/")
      expect(VivialConnect::Client.class_variable_get(:@@api_version)).to eq("v1.0")
      expect(VivialConnect::Client.class_variable_get(:@@configured)).to eq(true)
    end

  end

  context ".reset" do

    it "nils out the set up variables to start fresh" do
      VivialConnect::Client.instance.reset 
      expect(VivialConnect::Client.class_variable_get(:@@api_key)).to eq(nil)
      expect(VivialConnect::Client.class_variable_get(:@@api_secret)).to eq(nil)
      expect(VivialConnect::Client.class_variable_get(:@@account_id)).to eq(nil)
      expect(VivialConnect::Client.class_variable_get(:@@host)).to eq(nil)
      expect(VivialConnect::Client.class_variable_get(:@@api_version)).to eq(nil)
      expect(VivialConnect::Client.class_variable_get(:@@configured)).to eq(false)
    end

  end



  context "#host" do

    it "returns the class variable @@host" do
      expect(@client.host).not_to be(nil)
      expect(@client.host).to eq("https://api.vivialconnect.net/api/")
    end

  end

  context "#account_id" do

    it "sets and gets the class variable @@account_id" do
      @client.account_id = 999
      expect(@client.account_id).to eq(999)
    end

  end

  context "reset_api_base_path" do

    it "changes the @base_api_path" do
      @client.reset_api_base_path("https://www.vivial.net/", "v3.0")
      expect(@client.base_api_path).to eq("https://www.vivial.net/v3.0/")
    end

    it "changes the @base_api_path again" do
      @client.reset_api_base_path("https://api.vivialconnect.net/api/", "v1.0" )
      expect(@client.base_api_path).to eq("https://api.vivialconnect.net/api/v1.0/")
    end

  end

  context "#api_version" do

    it "returns @@api_version" do
      expect(@client.api_version).to eq("v1.0")
    end

  end

  context "#base_api_path" do
    it "returns @base_api_path" do
      expect(@client.base_api_path).to eq("https://api.vivialconnect.net/api/v1.0/")
    end
  end

  context "request timestamp instance methods" do

    time = Time.now.utc.strftime('%Y%m%dT%H%M%SZ')

    it "sets timestamp" do
      expect(@client.set_request_timestamp).to eq(time)
    end

    it "gets timestamp" do
      expect(@client.request_timestamp).to eq(time)
    end
  end

  context "date header instance methods" do

    header_time = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S GMT')

    it "sets date for header" do
      expect(@client.set_date_for_date_header).to eq(header_time)
    end

    it "gets date for header" do
      expect(@client.date_for_date_header).to eq(header_time)
    end

  end

  context "api_key / api_secret instance methods" do

    it "returns value of @@api_key for initialize" do
      expect(@client.api_key).to eq("1234")
    end

    it "returns value of @@api_secret for initialize" do
      expect(@client.api_secret).to eq("45678")
    end

  end

  context "#build_canonical_request" do

    it "returns a string" do
      canonical_request = @client.build_canonical_request("GET", Addressable::URI.parse("www.someurl.com"), "timestamp", "string of headers", "accept;date;host", {dog: "pug"})
      expect(canonical_request).to_not be(nil)
      expect(canonical_request.class).to be(String)
    end

  end

  context "#sign_request" do

    it "returns an hmac string" do
      url = Addressable::URI.parse("www.someurl.com")
      hmac = @client.sign_request("POST", url , {dog: "pug"})
      expect(hmac.bytesize).to eq(64)
    end

  end


  context "hmac_sha256 methods" do

    canonical_request = "stuff+things&otherstuff"

    it "sets hmac_sha256" do
      hmac = @client.set_hmac_sha256(canonical_request) 
      expect(@client.set_hmac_sha256(canonical_request)).to_not be(nil)
      expect(@client.set_hmac_sha256(canonical_request).class).to be(String)
      expect(@client.set_hmac_sha256(canonical_request)).to eq(hmac)
    end

    it "gets hmac_sha256" do
      hmac = @client.set_hmac_sha256(canonical_request)
      expect(@client.hmac_sha256).to eq(hmac)
    end

    it "returns the right number of bytes" do
      hmac = @client.set_hmac_sha256(canonical_request)
      expect(hmac.bytesize).to eq(64)
    end

  end

  context "#get_canonicalized_query_string" do

    url = "http://www.google.com"
    url_no_params = Addressable::URI.parse(url)
    params = "?x=y&a=b&g=q"
    url_with_params = Addressable::URI.parse(url + params)

    it "returns nothing if the string has no params" do
      expect(@client.get_canonicalized_query_string(url_no_params)).to eq("")
    end

    it "returns sorted params if url has params" do
      expect(@client.get_canonicalized_query_string(url_with_params)).to eq(("a=b&g=q&x=y"))
    end

  end

  context "#connection" do

    it "returns a Faraday::Connection" do
      connection = @client.connection 
      expect(connection.class).to eq(Faraday::Connection)
    end

  end


  context "#create_request_headers" do

    it "creates request headers" do
      headers = ['Content-Type', 'Host', 'X-Auth-Date', 'X-Auth-SignedHeaders', 'Authorization', 'Date', 'Accept' ]
      @client.create_request_headers.each do |header|
        raise "This header doesn't look right: #{header[0]}" unless headers.include?(header[0])
      end
    end

    it "doesn't return blank header values" do
      @client.create_request_headers.each do |key, value|
        expect(value).to_not eq("")
        expect(value).to_not be(nil)
      end
    end

  end


  context "account endpoint testing methods" do

    it "#no_account_number_endpoints" do
      url = @client.no_account_number_endpoints.include?('accounts.json')
      expect(url).to eq(true)

      url = @client.no_account_number_endpoints.include?('/accounts/count.json')
      expect(url).to eq(true)

      url = @client.no_account_number_endpoints.include?('/messages.json')
      expect(url).to eq(false)
    end

    it "#account_regex_match" do
      expect(@client.account_regex_match?('/accounts/1.json')).to eq(true)
      expect(@client.account_regex_match?('/accounts/92.json')).to eq(true)
      expect(@client.account_regex_match?('/accounts/1000999888.json')).to eq(true)
      expect(@client.account_regex_match?('/accounts/1/message.json')).to eq(false)
    end

    it "#account_query_match" do
      expect(@client.account_query_match?('/accounts/1.json')).to eq(false)
      expect(@client.account_query_match?('/accounts/92.json')).to eq(false)
      expect(@client.account_query_match?('/accounts/1/message.json')).to eq(false)
      expect(@client.account_query_match?('/accounts.json?')).to eq(true)
      expect(@client.account_query_match?('/accounts.json?a=b&cat=cleo&dog=loki')).to eq(true)
    end

  end

  context "#get_request_path" do

    it "adds --accounts/account_id-- for non-base Account resources" do
      # standard tests 

      expect(@client.get_request_path('/numbers.json').path).to eq('/api/v1.0/accounts/999/numbers.json')
      expect(@client.get_request_path('/configurations.json').path).to eq('/api/v1.0/accounts/999/configurations.json')
      expect(@client.get_request_path('/messages/1.json').path).to eq('/api/v1.0/accounts/999/messages/1.json')

      # testing all exceptions


      # attachments
      expect(@client.get_request_path('/messages/1/attachments.json').path).to eq('/api/v1.0/accounts/999/messages/1/attachments.json')
      expect(@client.get_request_path('/messages/1/attachments/1.json').path).to eq('/api/v1.0/accounts/999/messages/1/attachments/1.json')
      expect(@client.get_request_path('/messages/1/attachments/count.json').path).to eq('/api/v1.0/accounts/999/messages/1/attachments/count.json')
      expect(@client.get_request_path('/messages/1/attachments/count.json').path).to eq('/api/v1.0/accounts/999/messages/1/attachments/count.json')

      # logs 
      expect(@client.get_request_path('/logs.json').path).to eq('/api/v1.0/accounts/999/logs.json')
      expect(@client.get_request_path('/logs/aggregate.json').path).to eq('/api/v1.0/accounts/999/logs/aggregate.json')
      

      # numbers 
      expect(@client.get_request_path('/numbers/available/US/local.json').path).to eq('/api/v1.0/accounts/999/numbers/available/US/local.json')
      expect(@client.get_request_path('/numbers/lookup.json').path).to eq('/api/v1.0/accounts/999/numbers/lookup.json')
      expect(@client.get_request_path('/numbers/local.json').path).to eq('/api/v1.0/accounts/999/numbers/local.json')

      # users 
      expect(@client.get_request_path('/users/1/profile/password.json').path).to eq('/api/v1.0/accounts/999/users/1/profile/password.json')

      # accounts 
      expect(@client.get_request_path('/accounts/count').path).to eq('/api/v1.0/accounts/999/accounts/count')
    end


    it "doesn't add --accounts/account_id-- for base Account resource" do
      expect(@client.get_request_path('accounts.json').path).to eq('/api/v1.0/accounts.json')
      expect(@client.get_request_path('accounts/1.json').path).to eq('/api/v1.0/accounts/1.json')
    end

  end


  context "#choose_response_class" do

    it "should return the right response class based request path" do
      expect(@client.choose_response_class('/api/v1.0/accounts.json')).to be(VivialConnect::Account)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/attachments.json')).to be(VivialConnect::Attachment)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/logs.json')).to be(VivialConnect::Log)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/messages/1.json')).to be(VivialConnect::Message)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/numbers.json')).to be(VivialConnect::Number)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/users/1.json')).to be(VivialConnect::User)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/users/register.json')).to be(VivialConnect::User)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/connectors.json')).to be(VivialConnect::Connector)
      expect(@client.choose_response_class('/api/v1.0/accounts/999/connectors/1.json')).to be(VivialConnect::Connector)
    end

  end


  context "#make_request" do

    before do
      # using dotenv in development for this
      # With the gem installed you just need to create a file called .env in the root dir and
      # store the ENV variables like this:
      # API_KEY=yourapikey
      # API_SECRET=yoursecret
      # ACCOUNT_ID=youraccountid
      # and they can be accessed as follows
      VivialConnect::Client.configure(ENV['API_KEY'], ENV['API_SECRET'], ENV['ACCOUNT_ID'])
      @client = VivialConnect::Client.instance
    end

    it "raises invalid request method" do
      expect{ @client.make_request('HEAD', 'google.com') }.to raise_error("invalid request method")
    end

    it "makes a succesful request" do
      response = @client.make_request('GET', '/users.json')
      expect(response).to be_an(Array)
      expect(response.first.class).to be(VivialConnect::User)
    end

    it "handles normal 404 request" do
      expect{ @client.make_request('GET', '/users/1.json') }.to raise_error("Resource not found for id 1")
    end

  end

  context ".process_api_response" do
    it "raises and error if response status is >= 400"
    it "returns true if the response status is 200 - 299 and no or empty json is returned"
    it "returns false if response staus is < 400, not between 200 - 299"
    it "returns array of objects for the standard case"
    it "returns array of objects for VivialConnect:Connector::Number"
    it "returns array of objects for VivialConnect:Connector::Callback"
    it "returns array of objects for VivialConnect:Connector::Log"
    it "returns a FixNum for .count"
    it "returns an individual object for non get all calls"
  end

end



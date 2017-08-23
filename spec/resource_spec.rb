require_relative "./spec_helper"
require_relative "./stubbed_response"
require 'json'

RSpec.describe Resource do


  context ".path_builder" do

    it "builds correct paths for base actions" do
      path = Resource.path_builder(:create)
      expect(path).to eq('/resources.json')
      path = Resource.path_builder(:all)
      expect(path).to eq('/resources.json')
      path = Resource.path_builder(:find, 1)
      expect(path).to eq('/resources/1.json')
      path = Resource.path_builder(:update, 1)
      expect(path).to eq('/resources/1.json')
      path = Resource.path_builder(:delete, 1)
      expect(path).to eq('/resources/1.json')
      path = Resource.path_builder(:count)
      expect(path).to eq('/resources/count.json')
    end

  end

  context ".class_to_json_root" do

    it "builds no CamelCase root correctly" do
      class Tester < Resource ; end
      expect(Tester.class_to_json_root).to eq('tester')
    end

    it "builds one Camel root correctly" do
      class TestTest < Resource ; end
      expect(TestTest.class_to_json_root).to eq('test_test')
    end

    it "builds two Camel root correctly" do
      class TestTestTest < Resource ; end
      expect(TestTestTest.class_to_json_root).to eq('test_test_test')
    end

  end

  context ".build_hash_root_and_add_user_hash" do

    it "works normally for non-Number resources" do
      class Message < Resource ; end
      root = Message.build_hash_root_and_add_user_hash({hello: 'world'})
      expect(root.keys[0]).to eq('message')

    end

    it "makes correct change for Number resources" do
      class Number < Resource ; end
      root = Number.build_hash_root_and_add_user_hash({hello: 'world'})
      expect(root.keys[0]).to eq('phone_number')
    end

  end

  context ".class_to_path" do

    it 'builds Account path correctly' do
      expect(VivialConnect::Account.class_to_path).to eq('accounts')
    end

    it 'builds Attachment path correctly' do
      expect(VivialConnect::Attachment.class_to_path).to eq('/attachments')
    end

    it 'builds Log path correctly' do
     expect(VivialConnect::Log.class_to_path).to eq('/logs')

    end

    it 'builds Message path correctly' do
      expect(VivialConnect::Message.class_to_path).to eq('/messages')
    end

    it 'builds Number path correctly' do
      expect(VivialConnect::Number.class_to_path).to eq('/numbers')
    end

    it 'builds User path correctly' do
      expect(VivialConnect::User.class_to_path).to eq('/users')
    end

  end

  context ".pluralize" do

    it "adds s" do
      expect(Resource.pluralize('cat')).to eq('cats')
    end

  end

  context "#add_methods" do

    it "adds the methods passed as hash to the object" do
      resource = Resource.new
      resource.add_methods({dog_one: "pug", dog_two: "great dane" })
      expect(resource.dog_one).to eq("pug")
      expect(resource.dog_two).to eq("great dane")
      expect(resource.some_undefined_method).to be(nil)
    end

  end

  context "#save / #delete" do

    it "responds to #save" do
      a = VivialConnect::Account.new
      expect(a).to respond_to(:save)
    end

    it "completes object on #save (with no id) and updates object on save (with id)" do

      client = VivialConnect::Client.instance
      @stubs = Faraday::Adapter::Test::Stubs.new
      @conn = Faraday.new do |builder|
        builder.adapter :test, @stubs
      end

      message = VivialConnect::Message.new
      message.to_number = "+18005551111"
      message.from_number = "+19194332323"
      message.body = "Test message"

      #before the post there should be no id
      expect(message.id).to be(nil)

      uri = "/messages.json"
      data = "{\"message\":{\"to_number\":\"+18005551111\",\"from_number\":\"+19194332323\",\"body\":\"Test message\"}}"
      @stubs.post('https://api.vivialconnect.net/api/v1.0/messages.json') { [200, {'Content-Type' => 'application/json'}, message_post_response] }
      resp = @conn.post('https://api.vivialconnect.net/api/v1.0/messages.json')

      url = Addressable::URI.parse('https://api.vivialconnect.net/api/v1.0/messages.json')

      post_request_resp = client.process_api_response(resp, url, :post)

      allow(client).to receive(:make_request).with('POST', uri, data).and_return(post_request_resp)
      message.save

      expect(message.class).to be(VivialConnect::Message)
      expect(message.to_number).to eq("+18005551111")
      expect(message.from_number).to eq("+19194332323")
      expect(message.body).to eq("Test message")
      expect(message.id).to eq(231323)


      @stubs.put('https://api.vivialconnect.net/api/v1.0/messages/231323.json') { [200, {'Content-Type' => 'application/json'}, message_put_response] }
      resp = @conn.put('https://api.vivialconnect.net/api/v1.0/messages/231323.json')
      put_request_resp = client.process_api_response(resp, url, :post)

      message.body = ""
      uri = "/messages/231323.json"
      allow(client).to receive(:make_request).with('PUT', uri, anything).and_return(put_request_resp)
      expect(client).to receive(:make_request).with('PUT', "/messages/231323.json", anything)
      message.save
    end

    it "respond_to #delete" do
      a = VivialConnect::Account.new
      expect(a).to respond_to(:delete)
    end

    it "should make a delete request with the right args" do
      expect(VivialConnect::Client.instance).to receive(:make_request).with("DELETE", "/messages/1.json", "{\"id\":1}")
      message = VivialConnect::Message.new
      message.to_number = "+18005551111"
      message.from_number = "+19194332323"
      message.body = "Test message"
      message.id = 1
      message.delete
    end

  end

  context "it responds to all the base methods the other resource classes are expecting and forumates the correct responses" do

    it "responds to .create" do
      expect(Resource).to respond_to(:create)
    end

    it ".create formulates the correct request" do 
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with('POST', "/messages.json", "{\"message\":{\"from_number\":\"+1608421999\",\"to_number\":\"+16128887777\",\"body\":\"test\"}}")
      VivialConnect::Message.send(from_number: "+1608421999", to_number: "+16128887777", body: "test")
    end

    it "responds to .all" do
      expect(Resource).to respond_to(:all)
    end

    it ".all formulates the correct request" do
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with('POST', "/messages.json", "{\"message\":{\"from_number\":\"+1608421999\",\"to_number\":\"+16128887777\",\"body\":\"test\"}}")
      VivialConnect::Message.send(from_number: "+1608421999", to_number: "+16128887777", body: "test")
    end

    it "responds to .find" do
      expect(Resource).to respond_to(:find)
    end

    it ".find formulates the correct request" do
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with("GET", "/messages/1.json")
      VivialConnect::Message.find(1)
    end

    it "responds to .count" do
      expect(Resource).to respond_to(:count)
    end

    it ".count formulates the correct request" do
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with("GET", "/messages/count.json")
      VivialConnect::Message.count
    end

    it "responds to .update" do
      expect(Resource).to respond_to(:update)
    end

    it ".update formulates the correct request" do
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with("PUT", "accounts/1.json", "{\"account\":{\"name\":\"Bob\",\"id\":1}}")
      VivialConnect::Account.update(1, name: "Bob")
    end

    it "responds to .delete" do
      expect(Resource).to respond_to(:delete)
    end

    it ".delete formulates the correct request" do
      client = VivialConnect::Client.instance
      expect(client).to receive(:make_request).with("DELETE", "/contacts/1.json", "{\"id\":1}")
      VivialConnect::Contact.delete(1)
    end

  end

  context ".update_final_array" do

    it "adds new array into final array and flattens into one" do
      array = Resource.update_final_array([1, 2, 3], [4, 5, 6])
      expect(array.class).to be(Array)
      expect(array.count).to eq(6)
      expect(array[3]).to eq(1)
      expect(array[2]).to eq(6)
      expect(array[0]).to eq(4)

      array2 = Resource.update_final_array([100], array)
      expect(array2.count).to eq(7)
      expect(array2[-1]).to eq(100)
    end

  end

  context ".build_template_uri" do

    it "returns uri with expect query params" do
      uri = Resource.build_template_uri(path: '/accounts.json', start: 100, batch_size: 5)
      expect(uri).to eq('/accounts.json?page=100&limit=5')
    end

  end

  context ".find_each" do

    it "returns an enum if no block is given" do
      allow(VivialConnect::Client.instance).to receive(:make_request).with("GET", anything)
      result = VivialConnect::Account.find_each
      expect(result.class).to be(Enumerator)
    end

    it "iterates through individual records in collection if block is given" do
      client = VivialConnect::Client.instance
      @stubs = Faraday::Adapter::Test::Stubs.new
      @conn = Faraday.new do |builder|
        builder.adapter :test, @stubs
      end
      url = Addressable::URI.parse('https://api.vivialconnect.net/api/v1.0/accounts.json')
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts.json') { [200, {'Content-Type' => 'application/json'}, account_all] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts.json')
      get_request_resp = client.process_api_response(resp, url, :get)
      allow(client).to receive(:make_request).with("GET", "accounts.json?page=1&limit=150").and_return(get_request_resp)
      new_array = []
      iteration_count = 0
      VivialConnect::Account.find_each {|record| new_array << record; iteration_count +=1 }
      expect(new_array.count).to eq(5)
      expect(iteration_count).to eq(5)
      new_array.each {|account| expect(account).to be_a(VivialConnect::Account)}
    end

  end

  context ".find_in_batches" do

    it "returns an enum if no block is given" do
      allow(VivialConnect::Client.instance).to receive(:make_request).with("GET", anything)
      result = VivialConnect::Account.find_in_batches
      expect(result.class).to be(Enumerator)
    end


    it "iterates through batches in collection if block is given" do
      client = VivialConnect::Client.instance
      @stubs = Faraday::Adapter::Test::Stubs.new
      @conn = Faraday.new do |builder|
        builder.adapter :test, @stubs
      end
      url = Addressable::URI.parse('https://api.vivialconnect.net/api/v1.0/accounts.json')
      @stubs.get('https://api.vivialconnect.net/api/v1.0/accounts.json') { [200, {'Content-Type' => 'application/json'}, account_all] }
      resp = @conn.get('https://api.vivialconnect.net/api/v1.0/accounts.json')
      get_request_resp = client.process_api_response(resp, url, :get)
      allow(client).to receive(:make_request).with("GET", "accounts.json?page=1&limit=1").and_return(get_request_resp)
      new_array = []
      iteration_count = 0
      VivialConnect::Account.find_in_batches(start: 1, finish: 1, batch_size: 1) {|record| new_array << record; iteration_count +=1 }
      expect(new_array.count).to eq(1)
      expect(iteration_count).to eq(1)
      new_array.each {|account| expect(account).to be_an(Array)}
    end

  end

end
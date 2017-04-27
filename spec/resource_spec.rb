require_relative "./spec_helper"
require_relative "./stubbed_response"

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
    it 'builds Configuration path correctly' do 
      expect(VivialConnect::Configuration.class_to_path).to eq('/configurations')
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
      # opening this up to insert the marshal dump and skip the make_request calls
      class Resource
        def save
        ensure_client_is_initialized
        if self.id.nil?
          data = self.class.build_hash_root_and_add_user_hash(self.to_h)
          data = data.to_json
          uri = self.class.path_builder(:create)
          #response_object = VivialConnect::Client.instance.make_request('POST', uri, data)
          new_object_hash = account_create_marshal_dump
          self.add_methods(new_object_hash)
          self
        else
          options = self.to_h 
          data = self.class.build_hash_root_and_add_user_hash(self.to_h)
          data = data.to_json
          uri = self.class.path_builder(:update, id)
          #response_object = VivialConnect::Client.instance.make_request('PUT', uri, data)
          new_object_hash = account_update_marshal_dump
          self.add_methods(new_object_hash)
          self
        end 
      end
    end

      a = VivialConnect::Account.new 
      a.company_name = "John's Hotdog Stand Austin, TX"
      expect(a.id).to be(nil)
      a.save 
      expect(a.class).to be(VivialConnect::Account)
      expect(a.company_name).to eq("John's Hotdog Stand Austin, TX")
      expect(a.id).to eq(10080)
      a.company_name = "Bob's Dumpling Inc."
      a.save
      expect(a.class).to be(VivialConnect::Account)
      expect(a.company_name).to eq("Bob's Dumpling Inc.")
      expect(a.id).to eq(10080)

    end 

    it "respond_to #delete" do 
      a = VivialConnect::Account.new
      expect(a).to respond_to(:delete)   
    end 

  end

  context "it responds to all the base methods the other resource classes are expecting" do 

    it "responds to .create" do 
      expect(Resource).to respond_to(:create) 
    end

    it "responds to .all" do
      expect(Resource).to respond_to(:all)  
    end

    it "responds to .find" do
      expect(Resource).to respond_to(:find) 
    end 

    it "responds to .count" do 
      expect(Resource).to respond_to(:count) 
    end

    it "responds to .update" do 
      expect(Resource).to respond_to(:update) 
    end

    it "responds to .delete" do 
      expect(Resource).to respond_to(:delete) 
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
    # opening this up to stub out api call
    class Resource 
      def self.find_each(start: 1, finish: nil, batch_size: 100)
        return to_enum(:find_each, start: start, finish: finish, batch_size: batch_size) unless block_given? 
        current_batch = []
        page = start

        while true
          path = path_builder(:all)
          uri = build_template_uri(path: path, start: page, batch_size: batch_size)
          #current_batch = VivialConnect::Client.instance.make_request('GET', uri)
          current_batch = [1,2,3,4,5]
          current_batch.each { |record| yield record }

          if current_batch.count < batch_size || page == finish 
            break 
          end
          page += 1
        end
      end
    end

    it "returns an enum if no block is given" do 
      result = VivialConnect::Message.find_each
      expect(result.class).to be(Enumerator)
    end 


    it "iterates through individual records in collection if block is given" do 
      new_array = []
      iteration_count = 0
      VivialConnect::Message.find_each {|record| new_array << record; iteration_count +=1 }
      expect(new_array.count).to eq(5)
      expect(new_array[0]).to eq(1)
      expect(new_array[4]).to eq(5)
      expect(iteration_count).to eq(5)
    end



  end 

  context ".find_in_batches" do 

    # opening this up to stub out api call
    
    class Resource
      def self.find_in_batches(start: 1, finish: nil, batch_size: 100)
        return to_enum(:find_in_batches, start: start, finish: finish, batch_size: batch_size) unless block_given? 
        current_batch = []
        page = start

        while true
          path = path_builder(:all)
          uri = build_template_uri(path: path, start: page, batch_size: batch_size)
          #current_batch = VivialConnect::Client.instance.make_request('GET', uri)
          current_batch = [1,2,3,4,5]
          yield current_batch
          
          if current_batch.count < batch_size || page == finish 
            break 
          end
          page += 1
        end
      end
    end

    it "returns an enum if no block is given" do 
      result = VivialConnect::Message.find_in_batches
      expect(result.class).to be(Enumerator)
    end

    it "iterates through batches in collection if block is given" do 
      result = VivialConnect::Message.find_in_batches {|batch| expect(batch.class).to be(Array)}
    end 

  end 


end
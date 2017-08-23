module VivialConnect
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Connector resources on your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Connector.all
  # => [#<VivialConnect::Connector account_id=10XXX, active=true, callbacks=[{"date_created"=>"2017-08-21T20:41:46+00:00", "date_modified"=>"2017-08-21T20:41:46+00:00", "event_type"=>"incoming", "message_type"=>"text", "method"=>"POST", "url"=>"path/for/callback"}, {"date_created"=>"2017-08-21T21:05:49+00:00", "date_modified"=>"2017-08-21T21:05:49+00:00", "event_type"=>"incoming_fallback", "message_type"=>"text", "method"=>"POST", "url"=>"path/for/backup/callback"}], date_created="2017-08-21T19:41:01+00:00", date_modified="2017-08-21T19:41:01+00:00", id=54, more_numbers=false, name="List Sender", phone_numbers=[{"phone_number"=>"+1646493XXXX", "phone_number_id"=>1XXX}, {"phone_number"=>"+1646494XXXX", "phone_number_id"=>1XXX}]> ...] 
  #
  #
  #===  .count
  #
  #Returns the amount of Connector resources you have set up on your account
  #
  # Example usage:
  #
  #
  # VivialConnect::Connectors.count
  # => 3
  #
  #
  #
  #=== .create(options={})
  #
  #Creates a record of the Connector and returns it as a Ruby object.
  #
  #
  # Required parameter:
  #
  # name | String | "Connector 1"
  #
  #
  # Example Usage
  #
  #
  # VivialConnect::Connector.create(name: "Connector 1") 
  # => #<VivialConnect::Connector account_id=10XXX, active=true, callbacks=[], date_created="2017-08-22T16:48:32+00:00", date_modified="2017-08-22T16:48:32+00:00", id=XXXX, more_numbers=false, name="Connector 1", phone_numbers=[]> 
  ##
  #=== .find(id)
  #
  #Returns the Connector resource referenced by the `id` value as a ruby object.
  #
  # Required parameter:
  #
  # id | Fixnum | the id of the message you would like to retrieve
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Connector.find(5555)
  # => #<VivialConnect::Connector account_id=10XXX, active=true, callbacks=[], date_created="2017-08-22T16:48:32+00:00", date_modified="2017-08-22T16:48:32+00:00", id=XXXX, more_numbers=false, name="Connector 1", phone_numbers=[]> 
  #
  #
  #=== .update(id, options={})
  #
  #Updates the Connector resource with the provided id and returns it
  #
  # Required parameters:
  #
  # id | Fixnum | 10000
  #
  # Example usage:
  #
  #
  # VivialConnect::Connector.update(5555, name: "New Connector Name")
  # => #<VivialConnect::Connector account_id=10XXX, active=true, callbacks=[], date_created="2017-08-22T16:48:32+00:00", date_modified="2017-08-22T16:48:32+00:00", id=XXXX, more_numbers=false, name="New Connector Name", phone_numbers=[]> 
  #
  ##
  #=== .delete(id)
  #
  #Deletes the Connector resource with the provided id from your account and returns true. WARNING: this cannot be undone.
  #
  # Required parameters:
  #
  # id | Fixnum | 10000
  #
  #
  # Example usage:
  #
  # VivialConnect::Connector.delete(5555)
  # => true
  #
  #
  #=== \#add_number(number)
  #
  #Adds a number resource to the Connector object and saves it. If the Connector object has not been saved prior, it will save for the first time during this process.
  #If you wish to add more than one number to your Connector at a time, pass the numbers in an Array i.e. [num_1, num_2, num_3]
  #
  # Required parameters:
  #
  # number | VivialConnect::Number  
  #
  #
  # Example usage:
  #
  #
  # connector = VivialConnect::Connector.new
  # number = VivialConnect::Number.all.first
  # connector.add_number(number)
  # => #<VivialConnect::Connector account_id=10###, active=true, callbacks=[], date_created="2017-08-24T20:04:18+00:00", date_modified="2017-08-24T20:04:18+00:00", id=7##, more_numbers=false, name=nil, phone_numbers=[{"phone_number"=>"+1646493####", "phone_number_id"=>1###}]> 
  #
  #=== \#delete_number(number)
  #
  #Dissassociates a number from the Connector. This does not release the number. You can still add it back or to another Connector.
  #If you wish to delete more than one number from your Connector at a time, pass the numbers in an Array i.e. [num_1, num_2, num_3]
  #
  # Required parameters:
  #
  # number | VivialConnect::Number
  #
  #
  # Example usage:
  #
  #
  # connector = VivialConnect::Connector.all.first
  # number = VivialConnect::Number.all.first
  # connector.delete_number(number)
  # => #<VivialConnect::Connector account_id=10###, active=true, callbacks=[], date_created="2017-08-24T20:04:18+00:00", date_modified="2017-08-24T20:04:18+00:00", id=7##, more_numbers=false, name=nil, phone_numbers=[{"phone_number"=>"+1646493####", "phone_number_id"=>1###}]> 
  #
  #=== \#add_callback(callback)
  #
  #Adds a callback resource to the Connector object and saves it. If the Connector object has not been saved prior, it will save for the first time during this process.
  #If you wish to add more than one callback to your Connector at a time, pass the callbacks in an Array i.e. [cb_1, cb_2, cb_3]
  #
  # Required parameters for callback Hash:
  #
  # message_type | String | Can either be "text" or "voice"
  # event_type   | String | Can be "incoming", "incoming_fallback", "status"
  # url          | String | The URL that will receive callback request
  # method       | String | Can be "GET", "POST", or "PUT"
  #
  #
  # Example usage:
  #
  #
  # connector = VivialConnect::Connector.new
  # callback = {event_type: "incoming", message_type: "text", url: "path/for/calback", method: "GET"}
  # connector.add_callback(callback)
  # => #<VivialConnect::Connector account_id=10144, active=true, callbacks=[{"date_created"=>"2017-08-28T13:41:01+00:00", "date_modified"=>"2017-08-28T13:41:01+00:00", "event_type"=>"incoming", "message_type"=>"text", "method"=>nil, "url"=>"path/for/calback"}], date_created="2017-08-23T16:22:20+00:00", date_modified="2017-08-23T16:22:20+00:00", id=XX, more_numbers=false, name="Hello Connector", phone_numbers=[]>
  #
  #=== \#delete_callback(callback)
  #
  #Deletes a callback resource on the Connector object.
  #If you wish to delete more than one callback from your Connector at a time, pass the callbacks in an Array i.e. [cb_1, cb_2, cb_3]
  #
  # Required parameters for callback Hash:
  #
  # message_type | String | Can either be "text" or "voice"
  # event_type   | String | Can be "incoming", "incoming_fallback", "status"
  #
  # Example usage:
  #
  #
  # connector = VivialConnect::Connector.all.first
  # number = VivialConnect::Connector.all.first
  # connector.delete_callback({event_type: "incoming", message_type: "text"})
  # => #<VivialConnect::Connector account_id=10XXX, active=true, callbacks=[], date_created="2017-08-25T14:51:04+00:00", date_modified="2017-08-25T14:51:04+00:00", id=XX, more_numbers=false, name=nil, phone_numbers=[]> 
  #
  class Connector < Resource

    def add_number(input) # :nodoc:
      if self.id == nil
        self.save
      end
      if input.class == Array
        input.each {|num| created = VivialConnect::Connector::Number.create_or_update(self, num); self.phone_numbers << created}
      else
        created = VivialConnect::Connector::Number.create_or_update(self, input)
        self.phone_numbers << created
      end
      self.phone_numbers = VivialConnect::Connector.find(self.id).phone_numbers
      self
    end

    def delete_number(input) # :nodoc:
      if input.class == Array
        input.each {|num| VivialConnect::Connector::Number.delete(self.id,[phone_number_id: num.id, phone_number: num.phone_number ])}
      else
        response = VivialConnect::Connector::Number.delete(self.id,[phone_number_id: input.id, phone_number: input.phone_number ])
      end
      self.phone_numbers = VivialConnect::Connector.find(self.id).phone_numbers
      self
    end

    def add_callback(input) # :nodoc:
      if self.id == nil
        self.save
      end
      if input.class == Array
        input.each {|cb| created = VivialConnect::Connector::Callback.create_or_update(self, cb); self.callbacks << created}
      else
        created = VivialConnect::Connector::Callback.create_or_update(self, input)
        self.callbacks << created
      end

      self.callbacks = VivialConnect::Connector.find(self.id).callbacks
      self
    end

    def delete_callback(input) # :nodoc:
      if input.class == Array
        input.each {|cb| VivialConnect::Connector::Callback.delete(self.id,[message_type: cb[:message_type], event_type: cb[:event_type]])}
      else
        response = VivialConnect::Connector::Callback.delete(self.id,[message_type: input[:message_type], event_type: input[:event_type]])
      end
      self.callbacks = VivialConnect::Connector.find(self.id).callbacks
      self
    end


    module Callback # :nodoc:
      # add callback for connector
      def self.create_by_connector_id(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['callbacks'] = options
        data = data.to_json
        uri = "/connectors/#{id}/callbacks.json"
        VivialConnect::Client.instance.make_request('POST', uri, data)
      end

      # Updates the list of callbacks for the connector id provided, editing existing ones and adding new ones
      def self.update_by_connector_id(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['callbacks'] = options
        data = data.to_json
        uri = "/connectors/#{id}/callbacks.json"
        VivialConnect::Client.instance.make_request('PUT', uri, data)
      end

      def self.create_or_update(connector, input) # :nodoc:
        if connector.callbacks.count > 0
          VivialConnect::Connector::Callback.update_by_connector_id(connector.id, [message_type: input[:message_type], event_type: input[:event_type], url: input[:url], method: input[:request_method]])
        else
          VivialConnect::Connector::Callback.create_by_connector_id(connector.id, [message_type: input[:message_type], event_type: input[:event_type], url: input[:url], method: input[:request_method]])
        end
      end

      # Deletes the callbacks provided in the body from the Connector with id of {connector_id} path parameter.
      def self.delete(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['callbacks'] = options
        data = data.to_json
        uri = "/connectors/#{id}/callbacks.json"
        VivialConnect::Client.instance.make_request('DELETE', uri, data)
      end

    end

    module Number # :nodoc:

      # add numbers to connector
      def self.create_by_connector_id(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['phone_numbers'] = options
        data = data.to_json
        uri = "/connectors/#{id}/phone_numbers.json"
        VivialConnect::Client.instance.make_request('POST', uri, data)
      end

      # update numbers for connector
      def self.update_by_connector_id(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['phone_numbers'] = options
        data = data.to_json
        uri = "/connectors/#{id}/phone_numbers.json"
        VivialConnect::Client.instance.make_request('PUT', uri, data)
      end

      def self.create_or_update(connector, input) # :nodoc:
        if connector.phone_numbers.count > 0
          VivialConnect::Connector::Number.update_by_connector_id(connector.id,[phone_number_id: input.id, phone_number: input.phone_number ])
        else
          VivialConnect::Connector::Number.create_by_connector_id(connector.id,[phone_number_id: input.id, phone_number: input.phone_number ])
        end
      end

      # delete numbers for connector
      def self.delete(id, options = {}) # :nodoc:
        data = {}
        data['connector'] = {}
        data['connector']['phone_numbers'] = options
        data = data.to_json
        uri = "/connectors/#{id}/phone_numbers.json"
        VivialConnect::Client.instance.make_request('DELETE', uri, data)
      end

      def self.count_by_connector_id(id) # :nodoc:
        uri = "/connectors/#{id}/phone_numbers/count.json"
        VivialConnect::Client.instance.make_request('GET', uri)
      end
    end

  end
end


module VivialConnect 
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Message resources on your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.all
  # => [#<VivialConnect::Message to_number="#", from_number="#", body="example message", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted">]
  #
  #
  #===  .count
  #
  #Returns the amount of Messages sent from your account
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.count
  # => 5072
  #
  #
  ##
  #=== .create(options={})
  #
  #Creates a record of the message and sends it to the `to_number`. This method is also aliased as VivialConnect::Message.send(options={})
  #
  #
  # Required parameters:                                                                  
  #
  #
  # to_number   | String | "+16125551212"  <--NOTE: "+1" in front of the number.                     
  # from_number | String | "+16125554444"                     
  # body        | String | "My test message"                  
  #
  #
  # Optional parameter: for MMS                               
  #
  # media_urls  | Array  | ["www.yourhost.com/path/to/image"] <--NOTE: Array datatype is required, even if only passing one piece of media
  #
  # 
  # Example Usage
  #
  #
  # SMS
  #
  # VivialConnect::Message.send(to_number: "+1##########", from_number: "+1##########", body: "example message") 
  # VivialConnect::Message.create(to_number: "+1##########", from_number: "+1##########", body: "example message") 
  # => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="example message", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted"> 
  #
  #
  # MMS
  #
  # VivialConnect::Message.send(to_number: "+1##########", from_number: "+1##########", body: "example mms", content_urls: ['www.yourhost/path/to/media']) 
  # VivialConnect::Message.create(to_number: "+1##########", from_number: "+1##########", body: "example mms", content_urls: ['www.yourhost/path/to/media']) 
  # => #<VivialConnect::Message account_id=1XXXXX, body="example mms", date_created="2017-04-19T11:18:11-04:00", date_modified="2017-04-19T11:18:34-04:00", direction="outbound-api", error_code=nil, error_message=nil, from_number="+1##########", id=6399, master_account_id=1XXXX, message_type="local_mms", num_media=1, num_segments=1, price=100, price_currency="USD", sent="2017-04-19T11:18:16-04:00", sms_configuration_id=nil, status="delivered", to_number="+1##########"> 
  #
  #
  # 
  #  
  #
  ##
  #=== .find(id)
  #
  #Returns the a Messsage object referenced by the `id` value.
  #
  # Required parameter:
  #
  # id | Fixnum | the id of the message you would like to retrieve
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.find(17219)
  # => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="example message", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted"> 
  #
  #
  ##
  #=== .find_each(start: 1, finish: nil, batch_size: 150) 
  #
  #Iterates through all of the messages on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`. 
  #
  #
  # When a block is given this method yields an individual Message object. 
  # Without a block, this method returns an Enumerator. 
  #
  #
  # By default, it will begin at the first message and end at the last message
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
  #
  # 
  # Returns an Array of objects corresponding to the `start` and `finish` values. Default is all objects.
  #
  # Optional parameters:
  #
  # start      | Fixnum | batch to start with
  # finish     | Fixnum | batch to end with
  # batch_size | Fixnum | between 1..150
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.find_each {|message| puts message.body}
  # example message
  # => [#<VivialConnect::Message to_number="#", from_number="#", body="example message", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted">, ...]
  #
  #
  #
  #
  ##
  #===  .find_in_batches(start: 1, finish: nil, batch_size: 150)  
  # 
  #Iterates through all of the messages on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`. 
  # 
  #
  # When a block is given this method yields an array of batch_size resource objects. 
  # Without a block, it returns an Enumerator.
  #
  #
  # By default, it will begin at the first message and end at the last message
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
  #
  # 
  # Returns an Array of objects corresponding to the `start` and `finish` values. Default is all objects.
  #
  # Optional parameters:
  #
  # start      | Fixnum | batch to start with
  # finish     | Fixnum | batch to end with
  # batch_size | Fixnum | between 1..150
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.find_in_batches {|batch| do_something_with_an_array(batch)}
  # => [#<VivialConnect::Message to_number="#", from_number="#", body="example message", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted">, ...]
  #
  #
  #
  #
  ##
  #=== .redact(id)
  #
  # Deletes the message body of the Message corresponding to the id provided.
  #
  # Example usage:
  #
  #
  # VivialConnect::Message.redact(1)
  # => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted"> 
  #
  #
  ##
  #===  \#save
  #
  #Creates a message and sends it.
  #
  #
  # Example usage:
  #
  # message = VivialConnect::Message.new
  # message.to_number = "+1##########"
  # message.from_number = "+1##########"
  # message.body = "Example message"
  # message.save 
  # => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="Example message", account_id=1XXXX, date_created="2017-04-19T16:18:12-04:00", date_modified="2017-04-19T16:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17220, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted"> 
  #
  #
  ##
  #===  \#redact
  #
  #Deletes the message body on a Message object.
  #
  #
  # Example usage:
  #
  #
  # message.redact
  # => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="", account_id=1XXXX, date_created="2017-04-19T15:18:12-04:00", date_modified="2017-04-19T15:18:12-04:00", direction="outbound-api", error_code=nil, error_message=nil, id=17219, master_account_id=1XXXX, message_type="local_sms", num_media=0, num_segments=1, price=75, price_currency="USD", sent=nil, sms_configuration_id=nil, status="accepted"> 
  #
  #

  class Message < Resource

    singleton_class.send(:alias_method, :send, :create)

    def self.redact(id) # :nodoc:
      data = {}
      data['message'] = {id: id, body: ""}
      data = data.to_json
      VivialConnect::Client.instance.make_request('PUT',"/messages/#{id}.json", data) 
    end


    def redact # :nodoc:
      raise VivialConnectClientError, "your message object has no id and therefore cannot be redacted" if self.id.nil?
      id = self.id
      data = {}
      data['message'] = {id: id, body: ""}
      data = data.to_json
      VivialConnect::Client.instance.make_request('PUT',"/messages/#{id}.json", data) 
    end
    
  end

end




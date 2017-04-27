module VivialConnect 
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Configuration resources on your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Configuration.all
  # => [#<VivialConnect::Configuration account_id=1XXXX, active=true, date_created="2017-02-06T16:00:52-05:00", date_modified="2017-04-10T11:15:33-04:00", id=12, message_status_callback=nil, name="Message App Config", sms_fallback_method=nil, sms_fallback_url=nil, sms_method="POST", sms_url="http://requestb.in/174w8nz1">] 
  # 
  #
  #
  #===  .count
  #
  #Returns the amount of Configurations set up on your account
  #
  # Example usage:
  #
  #
  # VivialConnect::Configuration.count
  # => 1
  #
  #
  ##
  #=== .create(options={})
  #
  #Creates and returns a new Configuration 
  #
  #
  # Required parameter:                                                                  
  #  
  # name  | String | "Taxi App Config"                   
  #
  #
  # Optional parameters: for MMS                               
  #
  # phone_number            | String | "+1XXXXXXXXXX"
  # message_status_callback | String | "https://myserver.example.com/status"
  # sms_url                 | String | "https://myserver.example.com/url-for-fielding-incoming-message"
  # sms_method              | String | "POST" or "GET" (default is POST)
  # sms_fallback_url        | String | "https://myserver.example.com/url-if-sms_url-fails"
  # sms_fallback_method     | String | "POST" or "GET" (default is POST)
  #
  # Example Usage
  #
  #
  # VivialConnect::Configuration.create(name: "Taxi Messaging", message_status_callback: "https://myserver.example.com/status")
  # => #<VivialConnect::Configuration account_id=1XXXXX, active=true, date_created="2017-04-21T15:44:28-04:00", date_modified="2017-04-21T15:44:28-04:00", id=55, message_status_callback="https://myserver.example.com/status", name="Taxi Messaging", sms_fallback_method=nil, sms_fallback_url=nil, sms_method=nil, sms_url=nil> 
  #  
  #
  ##
  #=== .find(id)
  #
  #Returns the a Configuration object referenced by the `id` value.
  #
  # Required parameter:
  #
  # id | Fixnum | the id of the configuration you would like to retrieve
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Configuration.find(55)
  # => #<VivialConnect::Configuration account_id=1XXXX, active=true, date_created="2017-04-21T15:44:28-04:00", date_modified="2017-04-21T15:44:28-04:00", id=55, message_status_callback="https://myserver.example.com/status", name="Taxi Messaging", sms_fallback_method=nil, sms_fallback_url=nil, sms_method=nil, sms_url=nil> 
  #
  #
  ##
  #=== .find_each(start: 1, finish: nil, batch_size: 150) 
  #
  #Iterates through all of the configurations on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`. 
  #
  #
  # When a block is given this method yields an individual Configuration object. 
  # Without a block, this method returns an Enumerator. 
  #
  #
  # By default, it will begin at the first configuration and end at the last configuration
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
  #
  #
  #Returns an Array of objects corresponding to the `start` and `finish` values. Default is all objects.
  #
  # Optional parameters:
  #
  # start      | Fixnum | batch to start with
  # finish     | Fixnum | batch to end with
  # batch_size | Fixnum | between 1..150
  #
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Configuration.find_each {|configuration| puts configuration.name}
  # Taxi Messaging
  # => [#<VivialConnect::Configuration account_id=1XXXX, active=true, date_created="2017-04-21T15:44:28-04:00", date_modified="2017-04-21T15:44:28-04:00", id=55, message_status_callback="https://myserver.example.com/status", name="Taxi Messaging", sms_fallback_method=nil, sms_fallback_url=nil, sms_method=nil, sms_url=nil>,  ...]
  #
  #
  #
  #
  ##
  #===  .find_in_batches(start: 1, finish: nil, batch_size: 150)  
  # 
  #Iterates through all of the configurations on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`. 
  # 
  #
  # When a block is given this method yields an array of batch_size resource objects. 
  # Without a block, it returns an Enumerator.
  #
  #
  # By default, it will begin at the first configuration and end at the last configuration
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
  #
  # 
  # Returns an Array of objects corresponding to the `start` and `finish` values. Default is all objects.
  #
  #  Optional parameters:
  #
  #  start      | Fixnum | batch to start with
  #  finish     | Fixnum | batch to end with
  #  batch_size | Fixnum | between 1..150
  #   
  #
  #  Example usage:
  #
  #
  #  VivialConnect::Configuration.find_in_batches {|batch| do_something_with_an_array(batch)}
  #  => [#<VivialConnect::Configuration account_id=1XXXX, active=true, date_created="2017-04-21T15:44:28-04:00", date_modified="2017-04-21T15:44:28-04:00", id=55, message_status_callback="https://myserver.example.com/status", name="Taxi Messaging", sms_fallback_method=nil, sms_fallback_url=nil, sms_method=nil, sms_url=nil>,  ...]
  #
  #
  #===  \#delete
  #
  # Deletes a Configuration object
  #
  #
  # Example usage:
  #
  #
  # configuration = VivialConnect::Configuration.find(55)
  # configuration.delete
  # => true
  #
  #   
  #===  \#save
  #
  # Creates a Configuration or updates an existing one
  #
  #
  # Example usage:
  #
  #
  # configuration = VivialConnect::Configuration.new
  # configuration.name = "Taxi Messaging"
  # configuration.message_status_callback = "https://myserver.example.com/status"
  # configuration.save 
  # => #<VivialConnect::Configuration account_id=1XXXX, active=true, date_created="2017-04-21T15:44:28-04:00", date_modified="2017-04-21T15:44:28-04:00", id=55, message_status_callback="https://myserver.example.com/status", name="Taxi Messaging", sms_fallback_method=nil, sms_fallback_url=nil, sms_method=nil, sms_url=nil>
  #
  #

  class Configuration < Resource
  end
end
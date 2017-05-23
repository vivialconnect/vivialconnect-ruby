module VivialConnect 
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Number resources on your account
  #
  #
  # Example usage:
  #
  # VivialConnect::Number.all
  # => [#<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="ALMELUND", date_created="2017-04-25T09:53:11-04:00", date_modified="2017-04-25T09:53:11-04:00", id=65, lata=nil, master_account_id=1XXXX, status_text_url=nil, name="(612) 299-1726", phone_number="+16122991726", phone_number_type="local", rate_center="TWINCITIES", region="MN", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil>]
  #
  #
  #
  ##
  #=== .available_numbers(options={})
  #
  #Returns an array of available numbers corresponding to your search parameters 
  # 
  #
  # You must specify exactly one of the following three parameters: in_region, area_code, in_postal_code                                                                 
  #  
  # in_region      | String | Filters the results include only phone numbers in a specified 2-letter region (US state).
  # area_code      | Fixnum | Filters the results to include only phone numbers by US area code.
  # in_postal_code | Fixnum | Filters the results to include only phone numbers in a specified 5-digit postal code.
  #
  # Optional parameters:
  #
  # limit          | Fixnum | Number of results to return per page. Default value: 50.
  # contains       | String | Filters the results to include only phone numbers that match a number pattern you specify. The pattern can include letters, digits, and the following wildcard characters:
  #                             -- ? : matches any single digit
  #                             -- * : matches zero or more digits
  # local_number   | Fixnum | Filters the results to include only phone numbers that match the first three or more digits you specify to immediately follow the area code. To use this parameter, you must also specify an area_code.
  # in_city        | String | Filters the results to include only phone numbers in a specified city.
  #
  # 
  # Example Usage:
  # VivialConnect::Number.available_numbers(in_region: "PA", in_city: "Chambersburg", limit: 10)
  # => [#<VivialConnect::Number city="CHAMBERSBG", lata=nil, name="(717) 496-4018", phone_number="+17174964018", phone_number_type="local", rate_center="CHAMBERSBG", region="PA">, #<VivialConnect::Number city="CHAMBERSBG", lata=nil, name="(717) 496-4019", phone_number="+17174964019", phone_number_type="local", rate_center="CHAMBERSBG", region="PA">, ... 9 more numbers ]
  #
  #
  ##
  #=== .count
  #
  #Returns the number of phone numbers associated with your account.
  #
  #
  # Example usage:
  #
  # VivialConnect::Number.count
  # => 5
  #
  #
  ##
  #=== .create(options={})
  #
  #Buys a number and attaches it to your account. This method is aliased as .buy(options={}) as well. Returns the number you just aquired as an object.
  #
  #
  # You must specify at least one of the following two parameters:                                                                  
  #
  #
  # phone_number   | String | "+16125551212"  <--NOTE: "+1" in front of the number.                     
  # area_code      | String | "612"                     
  #                 
  #
  # Optional parameters:
  #
  # name                          | String | New phone number as it is displayed to users. Default format: Friendly national format: (xxx) yyy-zzzz.
  # status_text_url               | String | URL to receive status requests for messages sent via the API using this associated phone number. Max. length: 256 characters.
  # sms_configuration_id          | String | Unique identifier of the status configuration to be used to handle SMS messages sent to the associated number.
  # incoming_text_url             | String | URL for receiving SMS messages to the associated phone number. Max. length: 256 characters.
  # incoming_text_method          | String | HTTP method used for the incoming_text_url requests. Max. length: 8 characters. Possible values: GET or POST. Default value: POST.
  # incoming_text_fallback_url    | String | URL for receiving SMS messages if incoming_text_url fails. Only valid if you provide a value for the incoming_text_url parameter. Max. length: 256 characters.
  # incoming_text_fallback_method | String | HTTP method used for sms_url_fallback requests. Max. length: 8 characters. Possible values: GET or POST. Default value: POST.
  #
  # Example usage:
  #
  # VivialConnect::Number.create(phone_number: "+14124330365")
  # VivialConnect::Number.buy(phone_number: "+14124330365")
  # => #<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="PITTSBURGH ", date_created="2017-04-25T09:56:04-04:00", date_modified="2017-04-25T09:56:04-04:00", id=66, lata=nil, master_account_id=10096, status_text_url=nil, name="(412) 433-0365", phone_number="+14124330365", phone_number_type="local", rate_center="PTTSBGZON1", region="PA", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil>
  #
  ##
  #=== .delete(id)
  #
  #Deletes a phone number with the provided id from your account and returns true. WARNING: this cannot be undone. Once the number is released from your account it can be aquired by other users.
  #
  # Example usage:
  #
  # VivialConnect::Number.delete(100230)
  # => true
  #
  #
  ##
  #=== .filter_all(options={})
  #
  #Returns an array of number objects the contents of which are determined by the search parameters
  #
  #
  # Parameters:
  #
  # limit          | Fixnum | Number of results to return per page. Default value: 50.
  # contains       | String | Filters the results to include only phone numbers that match a number pattern you specify. The pattern can include letters, digits, and the following wildcard characters:
  #                             -- ? : matches any single digit
  #                             -- * : matches zero or more digits
  # page           | Fixnum | Page number within the returned list of associated phone numbers. Default value: 1.
  # name           | String | Filters the results to include only phone numbers exactly matching the specified name.
  #
  # NOTE: If you do not pass any filtering parameters, you will get an array containing all of your phone_numbers i.e.
  # the same behavior as .all
  #
  #
  # Example usage:
  #
  # VivialConnect::Number.filter_all(contains: "612")
  # => [#<VivialConnect::Number phone_number="+1612XXXXXXX">, #<VivialConnect::Number phone_number="+1612XXXXXXX">, ...]
  #
  #
  ##
  #=== .find(id)
  #
  #Returns number object with the id provided
  #
  #
  # Required parameter:
  #
  # id | Fixnum | 726
  #
  #
  # Example usage:
  #
  # VivialConnect::Number.find(726)
  # => #<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="ALMELUND", date_created="2017-04-25T10:22:07-04:00", date_modified="2017-04-25T10:41:16-04:00", id=726, lata=nil, master_account_id=1XXXX, status_text_url=nil, name="Dr. Jones", phone_number="+16123151041", phone_number_type="local", rate_center="TWINCITIES", region="MN", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil> 
  #
  #
  ##
  #=== .find_each(start: 1, finish: nil, batch_size: 150)
  #
  #Iterates through all of the numbers on your account in N sized batches and returns an array containing all the numbers beginning at the `start: value` and ending at the `finish: value`. 
  #
  #
  # When a block is given this method yields an individual Number object. 
  # Without a block, this method returns an Enumerator. 
  #
  #
  # By default, it will begin at the first number and end at the last number
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
  # VivialConnect::Number.find_each {|number| puts number.name}
  # example number name
  # => [#<VivialConnect::Number account_id=1XXXX>, #<VivialConnect::Number account_id=1XXXX>, ... ]
  #
  #
  ##
  #===  .find_in_batches(start: 1, finish: nil, batch_size: 150)  
  # 
  #Iterates through all of the numbers on your account in N sized batches and returns an array containing all the numbers beginning at the `start: value` and ending at the `finish: value`. 
  # 
  #
  # When a block is given this method yields an array of batch_size resource objects. 
  # Without a block, it returns an Enumerator.
  #
  #
  # By default, it will begin at the first number and end at the last number
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
  # VivialConnect::Number.find_in_batches {|batch| do_something_with_an_array(batch)}
  # => [#<VivialConnect::Number account_id=1XXXX>, #<VivialConnect::Number account_id=1XXXX, ... ]
  #
  #
  ##
  #=== .local
  #
  #Returns an array of all US local numbers owned by your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Number.local
  # => [#<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="BELCHERTOWN", date_created="2017-02-06T15:51:27-05:00", date_modified="2017-04-10T17:43:17-04:00", id=27, lata=nil, master_account_id=1XXXX, status_text_url=nil, name="App Number 1", phone_number="+1XXXXXXXXXX", phone_number_type="local", rate_center="BELCHERTN", region="MA", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url="http://requestb.in/174w8nz1", voice_forwarding_number="+1XXXXXXXXXX">] 
  #
  #
  ##
  #=== .lookup(number)
  #
  #Returns lookup information for a phone number
  #
  # Required parameter:
  # number | String | "+1XXXXXXXXXX" <--NOTE: "+1" in front of the number.  
  #
  # Example Usage:
  #
  #
  # VivialConnect::Number.lookup("+1XXXXXXXXXX")
  # => #<VivialConnect::Number carrier={"capabilities"=>{"deactivation_files"=>true, "device_lookup_api"=>true, "location_data"=>true, "mms_connection_status"=>true, "mms_dr"=>true, "sms_connection_status"=>true, "sms_fteu"=>true, "sms_handset_dr"=>true, "uaprof_in_mms_dr"=>true}, "country"=>"US", "name"=>"T-Mobile"}, date_created="2017-04-06T11:39:48-04:00", date_modified="2017-04-06T11:39:48-04:00", device={"error"=>"15012- Device lookup is not supported by this carrier.", "model"=>nil}, phone_number="+1XXXXXXXXXX"> 
  #
  #
  ##
  #=== .update(id, options={})
  #
  #Updates the phone_number record and returns the record as an object.  
  #
  # Required parameter:
  #
  # id                      | Fixnum | 875                    
  #                 
  #
  # Optional parameters:
  #
  # name                          | String | New phone number as it is displayed to users. Default format: Friendly national format: (xxx) yyy-zzzz.
  # status_text_url               | String | URL to receive status requests for messages sent via the API using this associated phone number. Max. length: 256 characters.
  # sms_configuration_id          | String | Unique identifier of the status configuration to be used to handle SMS messages sent to the associated number.
  # incoming_text_url             | String | incoming_text_url URL for receiving SMS messages to the associated phone number. Max. length: 256 characters.
  # incoming_text_method          | String | HTTP method used for the incoming_text_url requests. Max. length: 8 characters. Possible values: GET or POST. Default value: POST.
  # incoming_text_fallback_url    | String | URL for receiving SMS messages if incoming_text_url fails. Only valid if you provide a value for the incoming_text_url parameter. Max. length: 256 characters.
  # incoming_text_fallback_method | String | HTTP method used for sms_url_fallback requests. Max. length: 8 characters. Possible values: GET or POST. Default value: POST.
  #
  # Example usage:
  # 
  #
  # VivialConnect::Number.update(875, name: "Dr. Jones")
  # => #<VivialConnect::Number account_id=10096, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="ALMELUND", date_created="2017-04-25T10:22:07-04:00", date_modified="2017-04-25T10:41:16-04:00", id=69, lata=nil, master_account_id=1XXXX, status_text_url=nil, name="Dr. Jones", phone_number="+16123151041", phone_number_type="local", rate_center="TWINCITIES", region="MN", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil> #<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="PITTSBURGH ", date_created="2017-04-25T09:56:04-04:00", date_modified="2017-04-25T09:56:04-04:00", id=66, lata=nil, master_account_id=10096, status_text_url=nil, name="(412) 433-0365", phone_number="+14124330365", phone_number_type="local", rate_center="PTTSBGZON1", region="PA", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil>
  #
  #
  #===  \#delete
  #
  # Deletes a Number object. WARNING: this cannot be undone. Once the number is released from your account it can be aquired by other users.
  #
  #
  # Example usage:
  #
  #
  # number = VivialConnect::Number.find(1)
  # number.delete
  # => true
  #
  #   
  #===  \#save
  #
  # Creates a number associated with your main account or updates an existing one
  #
  #
  # Example usage:
  #
  # number = VivialConnect::Number.find(2)
  # number.name = "new name for this number"
  # number.save
  # => #<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="PITTSBURGH ", date_created="2017-04-25T09:56:04-04:00", date_modified="2017-04-25T09:56:04-04:00", id=66, lata=nil, master_account_id=10096, status_text_url=nil, name="new name for this number", phone_number="+14124330365", phone_number_type="local", rate_center="PTTSBGZON1", region="PA", sms_configuration_id=nil, incoming_text_fallback_method=nil, incoming_text_fallback_url=nil, incoming_text_method=nil, incoming_text_url=nil, voice_forwarding_number=nil>
  #
  #
 
  class Number < Resource

    singleton_class.send(:alias_method, :buy, :create)

    def self.available_numbers(options={}) # :nodoc:
      country_code ='US'
      number_type='local'
      uri = "/numbers/available/#{country_code}/#{number_type}.json"
      numbers_template = Addressable::Template.new("#{uri}{?query*}")
      uri = numbers_template.expand(query: options).to_s
      VivialConnect::Client.instance.make_request('GET', uri)
    end

    def self.filter_all(options={}) # :nodoc:
      country_code ='US'
      number_type='local'
      uri = "/numbers.json"
      numbers_template = Addressable::Template.new("#{uri}{?query*}")
      uri = numbers_template.expand(query: options).to_s
      VivialConnect::Client.instance.make_request('GET', uri)
    end

    def self.lookup(number) # :nodoc:
      number = {phone_number: number}
      uri='/numbers/lookup.json'
      numbers_template = Addressable::Template.new("#{uri}{?query*}")
      uri = numbers_template.expand(query: number).to_s
      VivialConnect::Client.instance.make_request('GET', uri)
    end

    def self.local # :nodoc: 
      VivialConnect::Client.instance.make_request('GET', '/numbers/local.json')
    end 


  end

end


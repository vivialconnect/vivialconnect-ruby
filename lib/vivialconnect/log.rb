module VivialConnect 
  #=== .find_aggregate_by_time(options = {})
  #
  #Returns an array where index 0 is the last_key and index 1 is the array of log_items requested 
  #
  #
  # Required parameters:                                                                  
  #  
  # start_time        | String | "20170424T134023Z" <-- ISO 8601 strftime('%Y%m%dT%H%M%SZ') 
  # end_time          | String | "20170425T134023Z" <-- ISO 8601 strftime('%Y%m%dT%H%M%SZ') 
  #
  # 
  # Optional parameters:
  #
  # logtype           | String | The log type, as a string. log-types are typically of the form ITEM_TYPE.ACTION, where ITEM_TYPE is the type of item that was affected and ACTION is what happened to it. For example, message.queued.
  # aggregator_type   | String | If present with valid values ("minutes", "hours", "days", "months", "years"), then it will give aggregate map. Else it will give aggregate total counts. Valid values are: minutes, hours, days, months, years
  # operator_id       | Fixnum | Unique id of operator that caused this log.
  # limit             | Fixnum | Used for pagination, number of log records to return
  # start_key         | Fixnum | Used for pagination, value of last_key from previous response
  #
  # Example usage:
  #
  # last_key, log_items = VivialConnect::Log.find_aggregate_by_time(start_time: "20170220T204352Z", end_time: "20170421T204352Z", aggregator_type: "minutes")
  # => ['7b226163...', [ #<VivialConnect::Log>, #<VivialConnect::Log>, #<VivialConnect::Log> ]]
  #
  ##
  #=== .find_by_time(options = {})
  #
  #Returns an array where index 0 is the last_key and index 1 is the array of log_items requested 
  # 
  #
  # Required parameters:                                                                  
  #  
  # start_time  | String | "20170424T134023Z" <-- ISO 8601 strftime('%Y%m%dT%H%M%SZ')
  # end_time    | String | "20170425T134023Z" <-- ISO 8601 strftime('%Y%m%dT%H%M%SZ')
  #
  # 
  # Optional parameters:
  #
  # logtype     | String | The log type, as a string. log-types are typically of the form ITEM_TYPE.ACTION, where ITEM_TYPE is the type of item that was affected and ACTION is what happened to it. For example, message.queued.
  # item_id     | Fixnum | Unique id of item that was affected.
  # operator_id | Fixnum | Unique id of operator that caused this log.
  # limit       | Fixnum | Used for pagination, number of log records to return
  # start_key   | Fixnum | Used for pagination, value of last_key from previous response
  #
  # 
  # last_key, log_items = VivialConnect::Log.find_by_time(start_time: "20170220T204352Z", end_time: "20170421T204352Z")
  # => [ 7b226163...', [ #<VivialConnect::Log>, #<VivialConnect::Log>, #<VivialConnect::Log> ]]
  #
  #
  
  class Log < Resource

    def self.find_by_time(options = {}) #:nodoc:
      uri = '/logs.json'
      numbers_template = Addressable::Template.new("#{uri}{?query*}")
      uri = numbers_template.expand(query: options).to_s
      VivialConnect::Client.instance.make_request('GET', uri)
    end

    def self.find_aggregate_by_time(options = {}) #:nodoc:
      uri = '/logs/aggregate.json'
      numbers_template = Addressable::Template.new("#{uri}{?query*}")
      uri = numbers_template.expand(query: options).to_s
      VivialConnect::Client.instance.make_request('GET', uri)
    end 

  end

end


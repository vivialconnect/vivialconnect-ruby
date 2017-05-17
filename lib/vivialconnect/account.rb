module VivialConnect
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Account resources associated with your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Account.all
  # => [#<VivialConnect::Account>, #<VivialConnect::Account>, #<VivialConnect::Account>]
  #
  #
  #===  .count
  #
  #Returns the amount of Accounts associated with your account
  #
  # Example usage:
  #
  #
  # VivialConnect::Account.count
  # => 5
  #
  #
  ##
  #=== .find(id)
  #
  #Returns the a Account object referenced by the `id` value.
  #
  # Required parameter:
  #
  # id | Fixnum | the id of the account you would like to retrieve
  #   
  #
  # Example usage:
  #
  #
  # VivialConnect::Account.find(10086)
  # => #<VivialConnect::Account account_id=1XXXX, accounts=[], active=true, company_name="App Developer Inc.", contacts=[], date_created="2017-04-20T17:07:08-04:00", date_modified="2017-04-20T17:07:08-04:00", id=10086, services=[{"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"SMS service", "id"=>1, "name"=>"sms", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Account service", "id"=>2, "name"=>"accounts", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Public service", "id"=>3, "name"=>"public", "service_type"=>"client"}]> 
  #
  #
  ##
  #=== .find_each(start: 1, finish: nil, batch_size: 150) 
  #
  #Iterates through all Account objects on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`.
  # 
  #
  # When a block is given this method yields an individual Account object. 
  # Without a block, this method returns an Enumerator. 
  #
  #
  # By default, it will begin at the first Account and end at the last Account
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
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
  # VivialConnect::Account.find_each {|account| puts account.company_name }
  # App Developer Inc.
  # => [#<VivialConnect::Account>] 
  #
  #
  #
  #
  ##
  #===  .find_in_batches(start: 1, finish: nil, batch_size: 150)  
  # 
  #Iterates through all of the Account objects on your account in N sized batches beginning at the `start: value` and ending at the `finish: value`. 
  #
  # 
  # When a block is given this method yields an array of batch_size Account objects. 
  # Without a block, it returns an Enumerator.
  #
  #
  # By default, it will begin at the first Account and end at the last Account
  # 
  # 
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.
  #
  #
  #
  # Returns an Array of objects corresponding to the `start` and `finish` values. Default is all objects.
  #
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
  # VivialConnect::Account.find_in_batches {|batch| do_something_with_an_array(batch)}
  # => [#<VivialConnect::Account>] 
  #
  #
  ##
  #=== .update(id, options={})
  #
  #  Required parameters:
  #
  #  id           | Fixnum | 10000
  #  company_name | String | "New Name"
  #
  # Example usage:
  #
  #
  # VivialConnect::Account.update(1000, company_name: "New Name")
  # => #<VivialConnect::Account account_id=1XXXX, accounts=[], active=true, company_name="New Name", contacts=[], date_created="2017-04-20T17:07:08-04:00", date_modified="2017-04-20T17:07:08-04:00", id=10086, services=[{"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"SMS service", "id"=>1, "name"=>"sms", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Account service", "id"=>2, "name"=>"accounts", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Public service", "id"=>3, "name"=>"public", "service_type"=>"client"}]> 
  #
  #

  class Account < Resource

  end
end



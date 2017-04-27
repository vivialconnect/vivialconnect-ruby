module VivialConnect
  ##
  #=== .add_main_contact_to_subaccount(options={})
  #
  #Creates a new contact and adds it as the main contact to a subaccount.
  #
  # Required parameters:
  #
  # account_id   | Fixnum | 123456 (subaccount id)
  # company_name | String | "App Developer Inc." 
  # first_name   | String | "Bob"
  # last_name    | String | "Tester"
  # email        | String | "btester@vivialconnect"                   
  #
  # 
  # Optional parameters:
  #
  # address1     | String | "500 Office Building Ln"
  # address2     | String | "Suite 300"
  # address3     | String | "c/o Front Desk"
  # city         | String | "Columbia Heights"
  # country      | String | "United States"
  # state        | String | "Minnesota"
  # postal_code  | String | "55421"
  # title        | String | "CMO"
  # work_phone   | String | "+1XXXXXXXXXX"
  # mobile_phone | String | "+1XXXXXXXXXX"
  # fax          | String | "+1XXXXXXXXXX"
  #
  # Example Usage
  #
  #
  # VivialConnect::Account.add_main_contact_to_subaccount(email: "btester@vivialconnect", contact_type:"main", company_name: "Acme")
  # => #<VivialConnect::Contact account_id=1XXXX, active=true, address1=nil, address2=nil, address3=nil, city=nil, company_name="Acme", contact_type="main", country="United States", date_created="2017-04-21T10:51:50-04:00", date_modified="2017-04-21T10:51:50-04:00", email="btester@vivialconnect", fax=nil, first_name="Bob", id=89, last_name="Tester", mobile_phone=nil, postal_code="55421", state=nil, title=nil, work_phone="+1XXXXXXXXXX"> 
  #
  #
  ##
  #=== .add_user_to_subaccount(options={})
  #
  #Creates a new User and adds it to a subaccount.
  #
  #
  # Required parameters:                                                             
  #
  #
  # first_name   | String | "Bob"
  # last_name    | String | "Tester"
  # email        | String | "btester@vivialconnect"                     
  # username     | String | "btester"
  # password     | String | "dlrowolleh"
  # 
  #
  # Example Usage
  #
  #
  # VivialConnect::Account.add_user_to_subaccount(account_id: 1XXXX, email: "btester@vivialconnect.net", username: "btester", first_name: "Bob", last_name: "Tester", password: "XXXXXXX")
  # => #<VivialConnect::User account_id=1XXXX, active=true, api_key="XYZYXZYXYZXYXZYXZYXYZYXYZYXYZYXYZYX", date_created="2017-04-21T11:27:16-04:00", date_modified="2017-04-21T11:27:16-04:00", email="btester@vivialconnect.net", first_name="Bob", id=10093, last_name="Tester", roles=[{"active"=>true, "date_created"=>"2016-09-30T19:42:59-04:00", "date_modified"=>"2016-09-30T19:42:59-04:00", "description"=>"User role", "id"=>4, "name"=>"User", "role_type"=>"client"}], timezone="US/Eastern", username="btester", verified=false> 
  #
  # Note: This method triggers an email to the created user's account. They need to answer this confirmation email before they will be able to log in.
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all Account resources associated with your account i.e. main account and associated subaccounts
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
  #=== .create(options={})
  #
  #Creates a subaccount tied to your main account
  #
  #
  # Required parameters:                                                                  
  #
  #
  # company_name | String | "App Developer Inc."                    
  #
  # 
  # Example Usage
  #
  #
  # VivialConnect::Account.create(company_name: "App Developer Inc.")
  # => #<VivialConnect::Account account_id=1XXXX, accounts=[], active=true, company_name="App Developer Inc.", contacts=[], date_created="2017-04-20T17:07:08-04:00", date_modified="2017-04-20T17:07:08-04:00", id=10086, services=[{"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"SMS service", "id"=>1, "name"=>"sms", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Account service", "id"=>2, "name"=>"accounts", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Public service", "id"=>3, "name"=>"public", "service_type"=>"client"}]> 
  #
  #
  # Note: When creating subaccounts, the `id` refers to the subaccount id, whereas the `account_id` refers to the main account.
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
  #=== .subaccounts
  #
  #Returns an array containing ruby objects containing all associated subaccounts
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Account.subaccounts
  # => [#<VivialConnect::Account>, #<VivialConnect::Account>, #<VivialConnect::Account>]
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
  ##
  #===  \#save
  #
  # Creates a subaccount associated with your main account or updates an existing one
  #
  #
  # Example usage:
  #
  # account = VivialConnect::Account.new
  # account.company_name = "B Tester QA Inc."
  # account.save 
  # => #<VivialConnect::Account account_id=1XXXX, accounts=[], active=true, company_name="B Tester QA Inc.", contacts=[], date_created="2017-04-20T17:07:08-04:00", date_modified="2017-04-20T17:07:08-04:00", id=10086, services=[{"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"SMS service", "id"=>1, "name"=>"sms", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Account service", "id"=>2, "name"=>"accounts", "service_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:58-04:00", "date_modified"=>"2016-09-30T19:42:58-04:00", "description"=>"Public service", "id"=>3, "name"=>"public", "service_type"=>"client"}]> 
  #
  #
  class Account < Resource

    def self.subaccounts # :nodoc:
      uri = '/subaccounts.json'
      VivialConnect::Client.instance.make_request('GET', uri)
    end

    def self.add_main_contact_to_subaccount(options={}) # :nodoc:
      raise VivialConnectClientError, "you must include an account_id parameter" if !options.keys.include?(:account_id)

      # This call must be made from the subaccount, so the client's account_id has to be updated
      main_account_id = VivialConnect::Client.instance.account_id
  
      VivialConnect::Client.instance.account_id = options[:account_id]
      uri = '/contacts.json'
      options[:contact_type] = 'main'
      data = {}
      data[:contact] = options 
      data = data.to_json

      begin 
        response = VivialConnect::Client.instance.make_request('POST', uri, data)
      ensure
        # client's account_id must be set back for future calls to work 
        VivialConnect::Client.instance.account_id = main_account_id
      end

      response
    end

    def self.add_user_to_subaccount(options={}) # :nodoc:
      raise VivialConnectClientError, "you must include an account_id parameter" if !options.keys.include?(:account_id)
      uri = '/users/register.json'
      options[:role] = 'User'
      data = {}
      data[:user] = options 
      data = data.to_json
      response = VivialConnect::Client.instance.make_request('POST', uri, data)
    end

  end
end



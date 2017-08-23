module VivialConnect 
  ##
  #=== .all
  #
  #Returns an array containing ruby objects corresponding to all User resources on your account
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::User.all
  # => [#<VivialConnect::User account_id=1XXXX, active=true, api_key="User's Api Key", date_created="2017-04-25T09:37:47-04:00", date_modified="2017-04-25T09:38:09-04:00", email="btester@vivial.net", first_name="Bob", id=1XXXX, last_name="Test", roles=[{"active"=>true, "date_created"=>"2016-09-30T19:42:59-04:00", "date_modified"=>"2016-09-30T19:42:59-04:00", "description"=>"Account administrator role", "id"=>3, "name"=>"AccountAdministrator", "role_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:59-04:00", "date_modified"=>"2016-09-30T19:42:59-04:00", "description"=>"User role", "id"=>X, "name"=>"User", "role_type"=>"client"}], timezone="US/Eastern", username="btester", verified=true>] 
  #
  #
  ##
  #=== .count
  #Returns the number of users associated with your account.
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::User.count
  # => 7
  #
  #
  #=== .find(id)
  #
  #Returns User object with the id provided
  #
  #
  # Required parameter:
  #
  # id | Fixnum | 726
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::User.find(726)
  # => #<VivialConnect::User account_id=1XXXX, active=true, api_key="apikey", date_created="2016-12-28T11:14:58-05:00", date_modified="2017-04-25T11:59:04-04:00", email="btester@vivial.net", first_name="Bob", id=1XXXX, last_name="Tester", roles=[{"active"=>true, "date_created"=>"2016-09-30T19:42:59-04:00", "date_modified"=>"2016-09-30T19:42:59-04:00", "description"=>"Account administrator role", "id"=>3, "name"=>"AccountAdministrator", "role_type"=>"client"}, {"active"=>true, "date_created"=>"2016-09-30T19:42:59-04:00", "date_modified"=>"2016-09-30T19:42:59-04:00", "description"=>"User role", "id"=>4, "name"=>"User", "role_type"=>"client"}], timezone="US/Eastern", username="btester", verified=true> 
  #
  #
  ##
  #=== .find_each(start: 1, finish: nil, batch_size: 150)
  #
  #Iterates through all of the users on your account in N sized batches and returns an array containing all the users beginning at the `start: value` and ending at the `finish: value`. 
  #
  #
  # When a block is given this method yields an individual User object. 
  # Without a block, this method returns an Enumerator. 
  #
  #
  # By default, it will begin at the first userr and end at the last user
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
  # VivialConnect::User.find_each {|user| puts user.username}
  # janeuser
  # => [#<VivialConnect::User account_id=1XXXX>,  ... ]
  #
  #
  ##
  #===  .find_in_batches(start: 1, finish: nil, batch_size: 150)  
  # 
  #Iterates through all of the user on your account in N sized batches and returns an array containing all the users beginning at the `start: value` and ending at the `finish: value`. 
  # 
  #
  # When a block is given this method yields an array of batch_size resource objects. 
  # Without a block, it returns an Enumerator.
  #
  #
  # By default, it will begin at the first user and end at the last user
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
  # VivialConnect::User.find_in_batches {|batch| do_something_with_an_array(batch)}
  # => [#<VivialConnect::User account_id=1XXXX> , ... ]
  #
  #
  ##
  #===  .update_password(id, old_pw, new_pw)
  # 
  #updates the password for the user with the id passed.
  #
  # 
  # Example usage:
  #
  #
  # VivialConnect::User.update_password(928, "oldpassword", "newpassword")
  # => true
  #
  #
  ##
  #===  \#update_password(old_pw, new_pw)
  # 
  #updates the password for the user object referenced
  #
  # 
  # Example usage:
  #
  #
  # user = User.find(1)
  # user.update_password("oldpassword", "newpassword")
  # => true
  #
  # NOTE: there is no need to call .save here. This method updates the database.
  #
  #
  class User < Resource

    def self.update_password(id, old_pw, new_pw) # :nodoc:
      data = {}
      data[:user] = {_password: old_pw, password: new_pw}
      data = data.to_json
      response = VivialConnect::Client.instance.make_request('PUT', "/users/#{id}/profile/password.json", data) 
    end

    def update_password(old_pw, new_pw) # :nodoc:
      raise VivialConnectClientError, "your user object has no id and therefore cannot be updated" if self.id.nil?
      data = {}
      data[:user] = {_password: old_pw, password: new_pw}
      data = data.to_json
      response = VivialConnect::Client.instance.make_request('PUT', "/users/#{self.id}/profile/password.json", data) 
    end

  end
end
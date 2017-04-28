# Vivialconnect

This gem is a wrapper for the Vivial Connect API. 

VivialConnect is a simple SMS/MMS API. It's designed specifically for developers seeking a simple, affordable and scalable messaging solution.

For more information visit the [website.](https://www.vivialconnect.net/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vivialconnect'
```

And then execute:

    $ bundle 

Or install it yourself as:

    $ gem install vivialconnect

## Usage

Quickstart from zero to sending your first message:

1. [Set up an account](https://www.vivialconnect.net/register) and get your API_KEY, API_SECRET, and ACCOUNT_ID.

2. Grab a phone number to send messages from, either on the UI or like so:

  ```ruby

  require 'vivialconnect'

  API_KEY = 'your-api-key'
  API_SECRET = 'your-api-secret'
  ACCOUNT_ID = 1234567

  VivialConnect::Client.configure(API_KEY, API_SECRET, ACCOUNT_ID)
  => true

  number = VivialConnect::Number.available_numbers(area_code: "612", limit: 1).first
   => [#<VivialConnect::Number city="ALMELUND", lata=nil, name="(612) 601-7532", phone_number="+16126017532", phone_number_type="local", rate_center="TWINCITIES", region="MN">] 


  my_number = VivialConnect::Number.buy(phone_number: number.phone_number)
  => #<VivialConnect::Number account_id=1XXXX, active=true, address_requirements="none", capabilities={"mms"=>true, "sms"=>true, "voice"=>true}, city="ALMELUND", phone_number="+16126017532" ... >
  ```

3. Send your first message:

  ```ruby
  first_message = VivialConnect::Message.send(to_number: "+1612XXXXXXX", from_number: my_number.phone_number, body: "Hello World!")
  => #<VivialConnect::Message to_number="+1##########", from_number="+1##########", body="Hello World!" ... > 

  # NOTE: "+1" in front of the `to_number` and `from_number`.  
  ```

4. Alternatively, you can run the helloworld.rb file at the root of this project. Simply add values to the constants in the file and do:

  ```ruby
  ruby helloworld.rb 
  ```

  The script will buy your first number and send your first message.

5. Check out the [docs](https://vivialconnect.github.io/vivialconnect-ruby/) for example usage for every method.


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/vivialconnect/vivialconnect-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


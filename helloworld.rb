
require 'vivialconnect'

# String | from your Vivial Connect account
API_KEY=

# String | from your Vivial Connect account
API_SECRET=

# Fixnum | from your Vivial Connect account
ACCOUNT_ID=

# String | number you are sending to; format "+13212311234"
TO_NUMBER = 

# String | three digit area code of number you want to buy and send from ex. "612"
DESIRED_AREA_CODE =

VivialConnect::Client.configure(API_KEY, API_SECRET, ACCOUNT_ID)

number = VivialConnect::Number.available_numbers(area_code: DESIRED_AREA_CODE, limit: 1).first


my_number = VivialConnect::Number.buy(phone_number: number.phone_number)


first_message = VivialConnect::Message.send(to_number: TO_NUMBER, from_number: my_number.phone_number, body: "Hello World!")

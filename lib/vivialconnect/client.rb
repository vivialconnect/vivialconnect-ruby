require 'faraday'
require 'addressable'
require 'digest'
require 'openssl'
require 'singleton'

module VivialConnect 

  ##
  #=== .configure(api_key, api_secret, account_id, host="https://api.vivialconnect.net/api/", api_version="v1.0" )
  #
  #Configures the client with your `api_key`, `api_secret`, `account_id`, `host`, and `api_version`
  #
  # 
  # Required parameters:
  #
  # api_key     | String | "YOURAPIKEY"
  # api_secret  | String | "YOURAPISECRET"
  # account_id  | Fixnum | 100000
  #
  #
  # Optional parameters:
  #
  # host        | String | "baseapiurl" 
  # api_version | String | "v1.9"
  #
  # NOTE: default host is "https://api.vivialconnect.net/api/" and default version is "v1.0"
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Client.configure(API_KEY, API_SECRET, ACCOUNT_ID)
  # => true
  #
  # NOTE: .configure does not check if your credentials are good, it merely checks that you have entered values for them
  #===  .reset
  #
  #Resets all of the configuration values to nil. This gives you a blank slate client to call .configure on.
  #
  #
  # Example usage
  #
  #
  # VivialConnect::Client.reset
  # => true
  #
  #
  #===  \#reset_api_base_path(new_host, new_api_version)
  #
  #Resets the api base path (host + api_version) on an instantiated client instance
  #
  # Required paramters:
  #
  # new_host        | String | "https://api.vivialconnect.net/api/"
  # new_api_version | String | "v1.1"
  #
  #
  # Example usage
  #
  # VivialConnect::Client.instance.reset_api_base_path("https://api.vivialconnect.net/api/", "v1.1" )
  # => true

  class Client

  #:nodoc:

    include Singleton

    @@configured = false

    def initialize
      begin 
        @base_api_path = host + "#{api_version}/"
        connection
      rescue NameError => e
        raise VivialConnectClientError, "Please configure client before making requests. You can do this like so: .configure(api_key, api_secret, account_id) to "
      end
    end

    def self.configure(api_key, api_secret, account_id, host="https://api.vivialconnect.net/api/", api_version="v1.0" )
      @@api_key= api_key
      @@api_secret = api_secret
      @@account_id = account_id
      @@host = host
      @@api_version = api_version
      @@configured = true
      true
    end

    def self.reset
      @@api_key= nil
      @@api_secret = nil
      @@account_id = nil
      @@host = nil
      @@api_version = nil
      @@configured = false
      @base_api_path = nil
      true
    end

    def host
      @@host
    end

    def account_id 
      @@account_id
    end 

    def account_id=(id)
       @@account_id = id
    end 

    def reset_api_base_path(new_host, new_api_version)
       @base_api_path = new_host + "#{new_api_version}/"
       connection
       true
    end 


    def api_version
      @@api_version
    end

    def base_api_path
      @base_api_path
    end 


    def self.configured?
      @@configured == true
    end


    def set_request_timestamp 
      @request_timestamp = Time.now.utc.strftime('%Y%m%dT%H%M%SZ')
    end


    def request_timestamp
      @request_timestamp
    end 


    def set_date_for_date_header
      @date_for_date_header = Time.now.utc.strftime('%a, %d %b %Y %H:%M:%S GMT')
    end 


    def date_for_date_header
      @date_for_date_header 
    end 


    def api_key
      @@api_key
    end


    def api_secret
      @@api_secret
    end


    def set_hmac_sha256(canonical_request)
      @hmac_sha256 = OpenSSL::HMAC.hexdigest('SHA256', api_secret, canonical_request)
    end


    def hmac_sha256
      @hmac_sha256 
    end

    def build_canonical_request(http_verb, url, request_timestamp, canonicalized_headers, canonicalized_header_names, data={})
      canonical_request = http_verb + "\n" + request_timestamp + "\n" + Addressable::URI.encode(url.path) + 
                          "\n" + get_canonicalized_query_string(url) + "\n" + canonicalized_headers + "\n" +
                           canonicalized_header_names +  "\n" + Digest::SHA256.hexdigest(data.to_s)
    end 


    def sign_request(http_verb, url, data={})
      set_request_timestamp 
      set_date_for_date_header
      canonicalized_headers = "accept:application/json" + "\n" + "date:#{date_for_date_header}" + "\n" +"host:api.vivialconnect.net"
      canonicalized_header_names = "accept;date;host"
      canonical_request = build_canonical_request(http_verb, url, request_timestamp, canonicalized_headers, canonicalized_header_names, data)
      set_hmac_sha256(canonical_request)
    end 


    def get_canonicalized_query_string(url)
      return "" unless url.query_values
      sorted_params = url.query_values.sort
      # gsub because Addressable encodes an empty space as + in parameters
      # and vivial connect api requires spaces to be %20 encoded
      # http://stackoverflow.com/questions/2824126/whats-the-difference-between-uri-escape-and-cgi-escape
      encoded_sorted_params = Addressable::URI.form_encode(sorted_params).gsub('+', '%20') 
    end


    def connection
      @conn = Faraday.new(:url => base_api_path) 
    end

    def make_request(request_method, url, data={})
      raise VivialConnectClientError, "invalid request method" unless ['GET', 'POST', 'PUT', 'DELETE'].include?(request_method)
      raise VivialConnectClientError, "Please configure client before making requests. You can do this like so: .configure(api_key, api_secret, account_id) to " if !VivialConnect::Client.configured?

      url = get_request_path(url)
      sign_request(request_method, url, data)
      headers = create_request_headers
      request_method = request_method.downcase.to_sym                                                                                                                                                                                                                                                                                                                                               
      response = connection.run_request(request_method, url, data.to_s, headers)
      process_api_response(response, url)
    end


    def create_request_headers
      headers = {}
      headers['Content-Type'] = 'application/json'
      headers['Host'] = 'api.vivialconnect.net'
      headers['X-Auth-Date'] = request_timestamp
      headers['X-Auth-SignedHeaders'] = 'accept;date;host'
      headers['Authorization'] = "HMAC" + " " + api_key + ":" + hmac_sha256
      headers['Date'] = date_for_date_header
      headers['Accept'] = 'application/json'
      headers
    end 


    def no_account_number_endpoints
      ['accounts.json', '/accounts/count.json', 'registration/register.json'] 
    end


    def account_regex_match?(url)
      m =  /accounts\/[0-9]+.json/.match(url)
      return !m.nil? 
    end


    def account_query_match?(url)
      url.include?("accounts.json?")
    end


    def get_request_path(url)
      if no_account_number_endpoints.include?(url) || account_regex_match?(url) || account_query_match?(url)
        base_path = base_api_path
        Addressable::URI.parse(base_path + url)
      else
        base_path = base_api_path + "accounts/#{account_id}"
        Addressable::URI.parse(base_path + url)
      end
    end 

    def process_api_response(response, url)
      # make API response into appropriate object and return it
      api_response = {}
        raise VivialConnectClientError, JSON.parse(response.body)['message'] ? JSON.parse(response.body)['message'] : response.body if response.status >= 400
        response_class = choose_response_class(url.path)
        if response.body == "" || response.body.include?("{}")
          return true if response.status.between?(200, 299)
          false
        else
          api_response = JSON.parse(response.body)
          if api_response[api_response.keys.first].is_a?(Array) 
            #return an array of resource objects
            response_array = api_response[api_response.keys.first]
            api_response = process_array(response_array, response_class)
          elsif url.path.split("/")[-1] == "subaccounts.json"
            #handle subaccounts array
            response_array = api_response[api_response.keys.first]['accounts']
            api_response = process_array(response_array, response_class)
          elsif api_response[api_response.keys[1]].is_a?(Array)
            #handle Log resource, return last key and an array full of log objects
            last_key = api_response['last_key']
            response_array = api_response['log_items']
            processed_array = process_array(response_array, response_class)    
            [last_key, processed_array]
          elsif api_response[api_response.keys.first].is_a?(Fixnum)
            # json is only one level deep for .count response, so no need to delete the json root
            # return the number
            api_response['count']
          else 
            if response_class == VivialConnect::Log 
              # json is only one level deep for Log response, so no need to delete the json root
              response_class.new(api_response)
            else 
              # remove json root, these resources return nested info
              api_response = api_response[api_response.keys.first]
              response_class.new(api_response)
            end
          end 

      end
    end

    def process_array(array, response_class)
      final_array = []
      array.each {|index| final_array << response_class.new(index)}
      final_array
    end 

    def choose_response_class(url)
      url = url.gsub('.json', '').split('/')
      if (url.count <= 5 )|| (url.count == 6 && url[5] == 'count')  
        return Account 
      elsif url.include?('attachments')
        return Attachment
      elsif url.include?('subaccounts')
        return Account
      else 
        api_resource = url[5]
        #exceptions needed for resources requiring camelcase
        klass = api_resource.capitalize
        #takes off pluralization -- may have to be updated to match self.pluralize(string) in Resource, or use library if necessary
        klass = klass[0..-2]
        return VivialConnect.const_get(klass) 
      end 
    end


  end
end 


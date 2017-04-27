##
# This class implements the shared behavior of the other resource classes 
class Resource < OpenStruct # :nodoc:

  ##
  # Creates a Vivial Connect API resource, returns a ruby object containing the newly created resource. 
  # Options hash values are determined by the API for the resource in question.
 
  def self.create(options = {})
    #TODO: delete this when more phone_number_types are possible
    if self == VivialConnect::Number && !options.keys.include?('phone_number_type')
      options.merge!(phone_number_type: 'local')
    end
    data = build_hash_root_and_add_user_hash(options)
    data = data.to_json
    uri = path_builder(:create)
    VivialConnect::Client.instance.make_request('POST', uri, data)
  end

  ##
  # Returns an array containing all of the API resources
  
  def self.all
    final_array = []
    page = 1
    limit = 100
    while true
      path = path_builder(:all)
      uri = build_template_uri(path: path, start: page, batch_size: limit)
      current_iteration = VivialConnect::Client.instance.make_request('GET', uri)
      final_array = update_final_array(current_iteration, final_array)
      break final_array if current_iteration.count < limit
      page += 1
    end
  end

  ##
  # Iterates through each record of a resource in batches of N
  # beginning at the start: value and ending at the finish: value. 
  #
  # When a block is given this method yields an individual resource objects. 
  # Without a block, this method creates an Enumerator. 
  #
  # With default batch_size: 150, if you wanted to get your records from
  # 150 to 300 you would start at 2 and finish at 2.

  
  def self.find_each(start: 1, finish: nil, batch_size: 150)
    return to_enum(:find_each, start: start, finish: finish, batch_size: batch_size) unless block_given? 
    final_array = []
    page = start

    while true
      path = path_builder(:all)
      uri = build_template_uri(path: path, start: page, batch_size: batch_size)
      current_batch = VivialConnect::Client.instance.make_request('GET', uri)
      final_array = update_final_array(current_batch, final_array)

      current_batch.each { |record| yield record }

      if current_batch.count < batch_size || page == finish 
        break final_array
      end
      page += 1
    end
  end

  ##
  # Iterates through resources in batches of N
  # beginning at the start: value and ending at the finish: value, in batch_sized chunks.
  #
  # When a block is given this method yields an array of batch_size resource objects. 
  # Without a block, it returns an Enumerator.


  def self.find_in_batches(start: 1, finish: nil, batch_size: 150)
    return to_enum(:find_in_batches, start: start, finish: finish, batch_size: batch_size) unless block_given? 
    final_array = []
    page = start

    while true
      path = path_builder(:all)
      uri = build_template_uri(path: path, start: page, batch_size: batch_size)
      current_batch = VivialConnect::Client.instance.make_request('GET', uri)
      final_array = update_final_array(current_batch, final_array)

      yield current_batch
      
      if current_batch.count < batch_size || page == finish 
        break final_array
      end
      page += 1
    end

  end

  ##
  # Returns the resource defined by the provided id.
  
  def self.find(id)
    uri = path_builder(:find, id)
    VivialConnect::Client.instance.make_request('GET', uri)
  end

  ##
  # Returns the amount of resources.
  
  def self.count
    uri = path_builder(:count)
    VivialConnect::Client.instance.make_request('GET', uri)
  end

  ##
  # Updates the record defined by the provided id with data from the options hash. 
  # Options hash values are determined by the API for the resource in question

  def self.update(id, options={})
    options = options.merge(id: id)
    data = build_hash_root_and_add_user_hash(options)
    data = data.to_json
    uri = path_builder(:update, id)
    VivialConnect::Client.instance.make_request('PUT', uri, data)
  end 

  ##
  # Deletes the record defined by the provided id. 
  # NOTE: not possible for all resource types

  def self.delete(id)
    uri = path_builder(:delete, id)
    data = {}
    data['id'] = id 
    data = data.to_json
    VivialConnect::Client.instance.make_request('DELETE', uri, data)
  end 


  def self.redact(id)
    raise VivialConnectClientError, "You can only redact message objects" unless self == VivialConnect::Message
    data = {}
    data['message'] = {id: id, body: ""}
    data = data.to_json
    VivialConnect::Client.instance.make_request('PUT',"/messages/#{id}.json", data) 
  end

  def add_methods(options={}) # :nodoc:
    options.each do |k,v|
      new_ostruct_member(k)
      send "#{k}=" , v
    end
  end

  def self.path_builder(resource_method, id=nil) # :nodoc:
    json = '.json'
    base = class_to_path
    if resource_method == :create || resource_method == :all 
      url = base + json
    elsif resource_method == :find || resource_method == :delete || resource_method == :update
      url = base + '/' + id.to_s + json
    elsif resource_method == :count 
      if self == VivialConnect::Account
        url = '/' + base + '/' + 'count' + json
      else
        url = base + '/' + 'count' + json
      end
    end
    return url
  end 

  def self.pluralize(string) # :nodoc:
    # avoids importing a library but will need to be improved upon depending on future api resource names
    string + 's'
  end

  def self.build_hash_root_and_add_user_hash(options) # :nodoc:
    root = class_to_json_root
    data  = {}
    if root != "number"
      data[root] = options
      return data
    else 
      data['phone_number'] = options
      return data
    end
  end 

  def self.class_to_path # :nodoc:
    base = self.to_s.split('::')[-1].downcase
    base = pluralize(base)
    base = base.prepend('/') unless base == 'accounts'
    base
  end

  def self.class_to_json_root # :nodoc:
    base =  self.to_s.split('::')[-1]
    base = base.split("")
    final = []
    final << base[0]
    base[1..-1].each do |letter|
      if letter == letter.upcase
        final <<  "_" + letter
      else
        final << letter
      end
    end
    final.join("").downcase
  end 

  def self.build_template_uri(path: p, start: nil, batch_size: nil) # :nodoc:
    all_template = Addressable::Template.new("#{path}{?query*}")
    uri = all_template.expand(query: {page: start, limit: batch_size}).to_s
  end

  def self.update_final_array(current_iteration, final_array) # :nodoc:
    final_array << current_iteration
    final_array.flatten!
  end

  ##
  # This instance method saves the current object if it does not have an id
  # and updates the existing object if it does have an id. It is equivalent to calling .create or .update
  # on the instance level.
 
  def save
    if self.id.nil?
      data = self.class.build_hash_root_and_add_user_hash(self.to_h)
      data = data.to_json
      uri = self.class.path_builder(:create)
      response_object = VivialConnect::Client.instance.make_request('POST', uri, data)
      new_object_hash =response_object.marshal_dump
      self.add_methods(new_object_hash)
      self
    else
      options = self.to_h 
      data = self.class.build_hash_root_and_add_user_hash(self.to_h)
      data = data.to_json
      uri = self.class.path_builder(:update, id)
      response_object = VivialConnect::Client.instance.make_request('PUT', uri, data)
      new_object_hash =response_object.marshal_dump
      self.add_methods(new_object_hash)
      self
    end 
  end

  ##
  # This instance method deletes the current object. 
  # NOTE: not all resouce types can be deleted

  def delete
    options = self.to_h 
    uri = self.class.path_builder(:delete, self.id)
    data = {}
    data['id'] = self.id 
    data = data.to_json
    VivialConnect::Client.instance.make_request('DELETE', uri, data)
  end  




end
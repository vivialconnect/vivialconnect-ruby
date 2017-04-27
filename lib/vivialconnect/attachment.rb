module VivialConnect 
  ##
  #=== .count_by_message_id(message_id)
  #
  #Returns the number of attachments related to the message_id passed.
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Attachment.count_by_message_id(844)
  # => 1
  #
  #
  ##
  #=== .delete(message_id, attachment_id)
  #
  #Deletes Attachment related to the `message_id` passed
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Attachment.delete(844, 190)
  # => true
  #
  #
  ##
  #=== .find(message_id, attachment_id)
  #
  #Returns an Attachment corresponding to the `message_id` and `attachment_id` passed
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Attachment.find(844, 190)
  # => [#<VivialConnect::Attachment account_id=1XXXX, content_type="image/jpeg", date_created="2017-04-19T11:18:16-04:00", date_modified="2017-04-19T11:18:16-04:00", file_name="great-dane.jpg", id=190, key_name="mms/50/e9aa5a6970498352a399ebdf798b86bb801b5b/great-dane.jpg", message_id=844, size=110805>]
  #
  #
  ##
  #=== .find_all_by_message_id(message_id)
  #
  #Returns an array containing ruby objects corresponding to all attachment resources related to the `message_id` passed
  #
  #
  # Example usage:
  #
  #
  # VivialConnect::Attachment.find_all_by_message_id(844)
  # => [#<VivialConnect::Attachment account_id=1XXXX, content_type="image/jpeg", date_created="2017-04-19T11:18:16-04:00", date_modified="2017-04-19T11:18:16-04:00", file_name="great-dane.jpg", id=190, key_name="mms/50/e9aa5a6970498352a399ebdf798b86bb801b5b/great-dane.jpg", message_id=844, size=110805>]
  #
  #

  class Attachment < Resource

    def self.find_all_by_message_id(message_id) #:nodoc:
      VivialConnect::Client.instance.make_request('GET', "/messages/#{message_id}/attachments.json")
    end

    def self.find(message_id, attachment_id) #:nodoc:
      VivialConnect::Client.instance.make_request('GET', "/messages/#{message_id}/attachments/#{attachment_id}.json")
    end

    def self.count_by_message_id(message_id) #:nodoc:
      VivialConnect::Client.instance.make_request('GET', "/messages/#{message_id}/attachments/count.json")
    end

    def self.delete(message_id, attachment_id) #:nodoc:
      VivialConnect::Client.instance.make_request('DELETE', "/messages/#{message_id}/attachments/#{attachment_id}.json")
    end

  end
end
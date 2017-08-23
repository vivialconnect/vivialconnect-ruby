require_relative "./spec_helper"

RSpec.describe VivialConnect::Attachment do

  it "responds to .find" do
      expect(VivialConnect::Attachment).to respond_to(:find)
  end

  it "builds the correct .find path"

  it "responds to .count_by_message_id" do
      expect(VivialConnect::Attachment).to respond_to(:count_by_message_id)
  end

  it "builds the correct .count_by_message_id path"

  it "responds to .delete" do
      expect(VivialConnect::Attachment).to respond_to(:delete)
  end

  it "builds the correct .delete path"

  it "responds to .find_all_by_message_id" do
      expect(VivialConnect::Attachment).to respond_to(:delete)
  end

  it "builds the correct find_all_by_message_id path"

end

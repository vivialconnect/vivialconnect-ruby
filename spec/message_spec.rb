require_relative "./spec_helper"

RSpec.describe VivialConnect::Message do

  it "responds to .create" do
    expect(VivialConnect::Message).to respond_to(:create)
  end

  it "builds the correct create path"

  it "responds to .send" do
    expect(VivialConnect::Message).to respond_to(:send)
  end

  it "builds the correct .send path"

  it "responds to .all" do
    expect(VivialConnect::Message).to respond_to(:all)
  end

  it "builds the correct all 'path"

  it "responds to .find" do
    expect(VivialConnect::Message).to respond_to(:find)
  end

  it "builds the correct .find path"

  it "responds to .count" do
    expect(VivialConnect::Message).to respond_to(:count)
  end

  it "builds the correct .count path"

  it "responds to .update" do
    expect(VivialConnect::Message).to respond_to(:update)
  end

  it "responds to .delete" do
    expect(VivialConnect::Message).to respond_to(:delete)
  end

  it 'builds the correct .delete path' do

  end

  it "responds to .redact" do
    expect(VivialConnect::Message).to respond_to(:redact)
  end

  it "builds the proper redact path"

end

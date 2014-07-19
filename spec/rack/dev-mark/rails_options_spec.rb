require 'spec_helper'

if defined?(::Rails)
describe Rack::DevMark::RailsOptions do
  subject { Rack::DevMark::RailsOptions.new }
  it do
    is_expected.to respond_to(:enable)
    is_expected.to respond_to(:enable=)
    is_expected.to respond_to(:env)
    is_expected.to respond_to(:env=)
    is_expected.to respond_to(:theme)
    is_expected.to respond_to(:theme=)
    is_expected.to respond_to(:insert_type)
    is_expected.not_to respond_to(:insert_type=)
  end
  it "has aliases of theme methods" do
    expect(subject.method(:theme)).to eq(subject.method(:custom_theme))
    expect(subject.method(:theme=)).to eq(subject.method(:custom_theme=))
  end
  describe "#insert_before" do
    it "has the implicit setter of insert_type" do
      subject.insert_before 'something'
      expect(subject.insert_type).to eq(['insert_before', 'something'])
    end
  end
  describe "#insert_after" do
    it "has the implicit setter of insert_type" do
      subject.insert_after 'something'
      expect(subject.insert_type).to eq(['insert_after', 'something'])
    end
  end
end
end

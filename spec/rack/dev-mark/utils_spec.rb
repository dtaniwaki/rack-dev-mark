require 'spec_helper'

describe Rack::DevMark::Utils do
  subject { Class.new{ include Rack::DevMark::Utils }.new }

  describe "#camelize" do
    it "camelizes" do
      expect(subject.camelize("test_test_test")).to eq("TestTestTest")
    end
  end
end

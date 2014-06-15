require 'spec_helper'

describe Rack::DevMark::Theme::Base do
  it "has private initialize method" do
    expect {
      Rack::DevMark::Theme::Base.new
    }.to raise_error(Rack::DevMark::RuntimeError)
  end
  describe "subclass" do
    subject { Class.new(Rack::DevMark::Theme::Base).new }
    it "sets up" do
      subject.setup 'env', 'rev'
      expect(subject.env).to eq('env')
      expect(subject.revision).to eq('rev')
    end
  end
end

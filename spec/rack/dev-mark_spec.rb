require 'spec_helper'

describe Rack::DevMark do
  subject { Rack::DevMark }
  before do
    @rack_env = ENV['RACK_ENV']
    @rails_env = ENV['RAILS_ENV']
  end
  after do
    ENV['RACK_ENV'] = @rack_env
    ENV['RAILS_ENV'] = @rails_env
  end
  it "returns nil" do
    ENV['RAILS_ENV'] = nil
    ENV['RACK_ENV'] = nil
    expect(subject.env).to eq(nil)
  end
  it "returns rack_env" do
    ENV['RAILS_ENV'] = nil
    ENV['RACK_ENV'] = 'abc'
    expect(subject.env).to eq('abc')
  end
  it "returns rails_env instead of rack_env" do
    ENV['RACK_ENV'] = 'abc'
    ENV['RAILS_ENV'] = 'def'
    expect(subject.env).to eq('def')
  end
end

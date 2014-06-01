require 'spec_helper'

describe Rack::DevMark do
  subject { Rack::DevMark }
  before do
    @rack_env = ENV['RACK_ENV']
    @rails_env = ENV['RAILS_ENV']
    Rack::DevMark.production_env = 'production'
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
  it 'has default production_env' do
    expect(subject.production_env).to eq(['production'])
  end
  it 'sets production_env' do
    Rack::DevMark.production_env = 'abc'
    expect(subject.production_env).to eq(['abc'])
  end
  it 'sets production_env by array' do
    Rack::DevMark.production_env = ['abc', 'def']
    expect(subject.production_env).to eq(['abc', 'def'])
  end
  it 'has default theme' do
    expect(subject.theme).to eq(:github_fork_ribbon)
  end
  it 'sets production_env' do
    Rack::DevMark.theme = :abc
    expect(subject.theme).to eq(:abc)
  end
end

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
    subject.instance_variable_set("@env", nil)
  end
  describe "::env" do
    it "returns development as default" do
      ENV['RAILS_ENV'] = nil
      ENV['RACK_ENV'] = nil
      expect(subject.env).to eq('development')
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
  describe "::env=" do
    it "sets custom env" do
      subject.env = 'custom'
      expect(subject.env).to eq('custom')
    end
  end
  describe "::revision" do
    after do
      ::File.delete('REVISION') if ::File.exists?('REVISION')
      subject.instance_variable_set("@revision", nil)
    end
    it "returns revision" do
      ::File.open('REVISION', 'w') do |f|
        f.write('abcde')
      end
      expect(subject.revision).to eq('abcde')
    end
    it "returns nil if REVISION does not exist" do
      expect(subject.revision).to eq(nil)
    end
  end
  describe "::revision=" do
    it "sets custom revision" do
      subject.revision = 'custom'
      expect(subject.revision).to eq('custom')
    end
  end
end

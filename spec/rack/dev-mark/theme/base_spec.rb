require 'spec_helper'

describe Rack::DevMark::Theme::Base do
  it "has private initialize method" do
    expect {
      Rack::DevMark::Theme::Base.new
    }.to raise_error(Rack::DevMark::RuntimeError)
  end
end

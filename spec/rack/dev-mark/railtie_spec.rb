require 'spec_helper'
require 'rails'
require 'rack/dev-mark/railtie'

describe Rack::DevMark::Railtie do
  let(:env) { nil }
  let(:app) { Class.new(Rails::Application) }
  before do
    @env = ENV['RAILS_ENV']
    ENV['RAILS_ENV'] = env
    app.initialize!
  end
  after do
    ENV['RAILS_ENV'] = @env
    Rails.application = nil
  end

  context "development env" do
    it "adds rack middleware" do
      expect(app.middleware.middlewares).to include(Rack::DevMark::Middleware)
    end
  end
  context "production env" do
    let(:env) { 'production' }

    it "does not add rack middleware" do
      expect(app.middleware.middlewares).not_to include(Rack::DevMark::Middleware)
    end
  end
end

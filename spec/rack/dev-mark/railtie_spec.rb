require 'spec_helper'

if !!Gem.loaded_specs["rails"]

require 'rails'
require 'rack/dev-mark/railtie'

describe Rack::DevMark::Railtie do
  let(:env) { 'test' }
  let(:production_env) { :production }
  let(:app) { Class.new(Rails::Application) }
  before do
    @env = ENV['RAILS_ENV']
    ENV['RAILS_ENV'] = env
    Rack::DevMark.production_env = production_env
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
    context "production_env has test" do
      let(:production_env) { 'test' }
      it "does not add rack middleware" do
        expect(app.middleware.middlewares).not_to include(Rack::DevMark::Middleware)
      end
    end
  end
  context "production env" do
    let(:env) { 'production' }
    it "does not add rack middleware" do
      expect(app.middleware.middlewares).not_to include(Rack::DevMark::Middleware)
    end
    context "production_env has abc" do
      let(:production_env) { :abc }
      it "does not add rack middleware" do
        expect(app.middleware.middlewares).to include(Rack::DevMark::Middleware)
      end
    end
  end
end

end

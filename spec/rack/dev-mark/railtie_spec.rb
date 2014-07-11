require 'spec_helper'

if defined?(::Rails)
describe Rack::DevMark::Railtie do
  include_context 'forked spec'

  before do
    @app = Class.new(::Rails::Application)
    @app.config.active_support.deprecation = :stderr
    @app.config.eager_load = false
  end
  context "rack_dev_mark enable" do
    before do
      @app.config.rack_dev_mark.enable = true
    end
    it 'inserts the middleware' do
      @app.initialize!
      expect(@app.middleware.middlewares).to include(Rack::DevMark::Middleware)
    end
  end
  context "rack_dev_mark disable" do
    before do
      @app.config.rack_dev_mark.enable = false
    end
    it 'does not insert the middleware' do
      @app.initialize!
      expect(@app.middleware.middlewares).not_to include(Rack::DevMark::Middleware)
    end
    context "with rack_dev_mark_env" do
      before do
        ENV['RACK_DEV_MARK_ENV'] = 'test'
      end
      it 'inserts the middleware' do
        @app.initialize!
        expect(@app.middleware.middlewares).to include(Rack::DevMark::Middleware)
      end
    end
  end
  context "rack_dev_mark theme" do
    let(:theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b| "#{b} dev-mark" }; d }
    before do
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.theme = [theme]
    end
    it 'inserts the middleware' do
      @app.initialize!
      expect(theme).to receive(:setup)
    end
  end
  context "rack_dev_mark custom_theme alias" do
    let(:theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b| "#{b} dev-mark" }; d }
    before do
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.custom_theme = [theme]
    end
    it 'inserts the middleware' do
      @app.initialize!
      expect(theme).to receive(:setup)
    end
  end
end
end

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
      middlewares = @app.middleware.middlewares
      expect(middlewares).to include(Rack::DevMark::Middleware)
      expect(middlewares.index(Rack::DevMark::Middleware)).to eq(middlewares.index(ActionDispatch::ShowExceptions) - 1)
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
    let(:theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b, _, _| "#{b} dev-mark" }; d }
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
    let(:theme) { d = double setup: nil; allow(d).to receive(:insert_into){ |b, _, _| "#{b} dev-mark" }; d }
    before do
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.custom_theme = [theme]
    end
    it 'inserts the middleware' do
      @app.initialize!
      expect(theme).to receive(:setup)
    end
  end
  context "rack_dev_mark insert_before" do
    let(:dummy_middleware) { Class.new{ define_method(:initialize) { |_| }; define_method(:to_s) { 'Dummy' } } }
    before do
      @app.config.middleware.use dummy_middleware
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.insert_before dummy_middleware
    end
    it 'inserts the middleware before the other middleware' do
      @app.initialize!
      middlewares = @app.middleware.middlewares
      expect(middlewares).to include(Rack::DevMark::Middleware)
      expect(middlewares).to include(dummy_middleware)
      expect(middlewares.index(Rack::DevMark::Middleware)).to eq(middlewares.index(dummy_middleware) - 1)
    end
  end
  context "rack_dev_mark insert_after" do
    let(:dummy_middleware) { Class.new{ define_method(:initialize) { |_| }; define_method(:to_s) { 'Dummy' } } }
    before do
      @app.config.middleware.use dummy_middleware
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.insert_after dummy_middleware
    end
    it 'inserts the middleware before the other middleware' do
      @app.initialize!
      middlewares = @app.middleware.middlewares
      expect(middlewares).to include(Rack::DevMark::Middleware)
      expect(middlewares).to include(dummy_middleware)
      expect(middlewares.index(Rack::DevMark::Middleware)).to eq(middlewares.index(dummy_middleware) + 1)
    end
  end
  context "rack_dev_mark env" do
    before do
      @app.config.rack_dev_mark.enable = true
      @app.config.rack_dev_mark.env = 'something'
    end
    it 'sets the env string' do
      @app.initialize!
      expect(Rack::DevMark.env).to eq('something')
    end
  end
end
end

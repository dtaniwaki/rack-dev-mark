require 'spec_helper'

if defined?(::Rails)
require 'action_controller'
describe Rack::DevMark::ActionControllerHelpers do
  let(:controller_klass) do
    Class.new(ActionController::Base) do
      skip_rack_dev_mark

      def disabled_action
        puts 'test'
        render inline: '<html><head></head><body></body></html>'
      end

      def enabled_action
        render inline: '<html><head></head><body></body></html>'
      end
    end
  end
  let(:controller) { controller_klass.new }

  include_context 'forked spec'

  before do
    @app = Class.new(::Rails::Application)
    @app.config.active_support.deprecation = :stderr
    @app.config.eager_load = false
    @app.config.rack_dev_mark.enable = true
    @app.initialize!
  end

  describe "#disable_rack_dev_mark" do
    it "sets Rack::DevMark.tmp_disabled true" do
      expect(Rack::DevMark).to receive(:tmp_disabled=).with(true)
      controller.disable_rack_dev_mark
    end
  end
  describe "#enable_rack_dev_mark" do
    it "sets Rack::DevMark.tmp_disabled false" do
      expect(Rack::DevMark).to receive(:tmp_disabled=).with(false)
      controller.enable_rack_dev_mark
    end
  end

  describe "::skip_rack_dev_mark" do
    it "does not add dev mark" do
      skip "need a spec test"
    end
  end
end
end

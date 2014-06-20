require 'rails'

module Rack
  module DevMark
    class Railtie < Rails::Railtie
      config.rack_dev_mark = ActiveSupport::OrderedOptions.new

      initializer "rack-dev-mark.configure_rails_initialization" do |app|
        if app.config.rack_dev_mark.enable
          racks = [ActionDispatch::ShowExceptions, Rack::DevMark::Middleware]
          racks << app.config.rack_dev_mark.custom_theme if app.config.rack_dev_mark.custom_theme
          app.config.app_middleware.insert_before *racks
        end
      end
    end
  end
end

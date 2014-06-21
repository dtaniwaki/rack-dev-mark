require 'rails'

module Rack
  module DevMark
    class Railtie < Rails::Railtie
      config.rack_dev_mark = ActiveSupport::OrderedOptions.new

      initializer "rack-dev-mark.configure_rails_initialization" do |app|
        if app.config.rack_dev_mark.enable
          racks = [ActionDispatch::ShowExceptions, Rack::DevMark::Middleware]
          if theme = app.config.rack_dev_mark.theme || app.config.rack_dev_mark.custom_theme
            racks << theme
          end
          app.config.app_middleware.insert_before *racks
        end
      end
    end
  end
end

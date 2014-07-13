require 'rails'

module Rack
  module DevMark
    class Railtie < Rails::Railtie
      config.rack_dev_mark = ActiveSupport::OrderedOptions.new

      initializer "rack-dev-mark.configure_rails_initialization" do |app|
        if app.config.rack_dev_mark.enable || Rack::DevMark.rack_dev_mark_env
          racks = []

          insert_method = :insert_before
          if rack = app.config.rack_dev_mark.insert_before
            racks << rack
          elsif rack = app.config.rack_dev_mark.insert_after
            insert_method = :insert_after
            racks << rack
          else
            racks << ActionDispatch::ShowExceptions
          end

          racks << Rack::DevMark::Middleware
          if theme = app.config.rack_dev_mark.theme || app.config.rack_dev_mark.custom_theme
            racks << theme
          end

          app.config.app_middleware.send(insert_method, *racks)
        end
      end
    end
  end
end

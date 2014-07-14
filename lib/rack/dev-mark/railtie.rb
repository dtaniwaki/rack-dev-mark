require 'rails'
require_relative 'rails_options'

module Rack
  module DevMark
    class Railtie < Rails::Railtie
      config.rack_dev_mark = RailsOptions.new

      initializer "rack-dev-mark.configure_rails_initialization" do |app|
        if app.config.rack_dev_mark.enable || Rack::DevMark.rack_dev_mark_env
          racks = []

          insert_type = app.config.rack_dev_mark.insert_type
          insert_method = insert_type[0] || 'insert_before'
          racks << (insert_type[1] || ActionDispatch::ShowExceptions)

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

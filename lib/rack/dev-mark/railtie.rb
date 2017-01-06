require 'rails'
require_relative 'rails_options'
require_relative 'action_controller_helpers'

module Rack
  module DevMark
    class Railtie < Rails::Railtie
      config.rack_dev_mark = RailsOptions.new

      initializer "rack-dev-mark.insert_middleware" do |app|
        if app.config.rack_dev_mark.enable || Rack::DevMark.rack_dev_mark_env
          racks = []

          insert_type = app.config.rack_dev_mark.insert_type
          insert_method = insert_type[0] || 'insert_before'
          racks << (insert_type[1] || ActionDispatch::ShowExceptions)

          racks << Rack::DevMark::Middleware
          if theme = app.config.rack_dev_mark.theme || app.config.rack_dev_mark.custom_theme
            racks << theme
          end

          app.config.middleware.send(insert_method, *racks)
        end
      end

      initializer "rack-dev-mark.set_env", after: "rack-dev-mark.insert_middleware" do |app|
        if app.config.rack_dev_mark.enable || Rack::DevMark.rack_dev_mark_env
          Rack::DevMark.env = app.config.rack_dev_mark.env
        end
      end

      initializer "rack-dev-mark.load_controller_helpers", after: "rack-dev-mark.insert_middleware" do |app|
        ActiveSupport.on_load :action_controller do
          include Rack::DevMark::ActionControllerHelpers
        end
      end
    end
  end
end

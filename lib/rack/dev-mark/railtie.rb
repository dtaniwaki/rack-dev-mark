require 'rack/dev-mark/middleware'

module Rack
  module DevMark
    class Railtie < ::Rails::Railtie
      config.before_configuration do |app|
        app.middleware.delete Rack::DevMark::Middleware
        if Rack::DevMark.env != 'production'
          app.middleware.use Rack::DevMark::Middleware
        end
      end
    end
  end
end

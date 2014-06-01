require 'rack/dev-mark/middleware'

module Rack
  module DevMark
    class Railtie < ::Rails::Railtie
      initializer 'rack-dev-mark' do |app|
        app.middleware.delete Rack::DevMark::Middleware
        unless Rack::DevMark.production_env.include? Rack::DevMark.env.to_s
          app.middleware.use Rack::DevMark::Middleware, Rack::DevMark.theme
        end
      end
    end
  end
end

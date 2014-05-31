require 'rack'
require 'rack/dev-mark/error'
require 'rack/dev-mark/utils'
require 'rack/dev-mark/title'
require 'rack/dev-mark/theme'
require 'rack/dev-mark/middleware'
require 'rack/dev-mark/railtie' if defined?(Rails)
require 'rack/dev-mark/version'

module Rack
  module DevMark
    def self.env
      ENV['RAILS_ENV'] || ENV['RACK_ENV']
    end
  end
end

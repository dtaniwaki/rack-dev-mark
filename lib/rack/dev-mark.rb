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

    def self.production_env
      @production_env ||= ['production']
    end

    def self.production_env=(*production_env)
      @production_env = production_env.flatten.map(&:to_s)
    end

    def self.theme
      @theme ||= :github_fork_ribbon
    end

    def self.theme=(theme)
      @theme = theme
    end
  end
end

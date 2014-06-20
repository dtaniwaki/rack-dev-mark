require 'rack'
require 'rack/dev-mark/error'
require 'rack/dev-mark/utils'
require 'rack/dev-mark/theme'
require 'rack/dev-mark/middleware'
require 'rack/dev-mark/version'

module Rack
  module DevMark
    def self.env
      @env ||= ENV['RAILS_ENV'] || ENV['RACK_ENV']
    end

    def self.revision
      @revision ||= (::File.open('REVISION') { |f| f.read.strip } rescue nil)
    end
  end
end

require 'rack/dev-mark/railties' if defined?(Rails)

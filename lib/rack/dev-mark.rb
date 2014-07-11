require 'rack'
require 'rack/dev-mark/error'
require 'rack/dev-mark/utils'
require 'rack/dev-mark/theme'
require 'rack/dev-mark/middleware'
require 'rack/dev-mark/version'

module Rack
  module DevMark
    class << self
      def env
        @env ||= rack_dev_mark_env || ENV['RAILS_ENV'] || ENV['RACK_ENV'] || 'development'
      end

      def env=(env)
        @env = env
      end

      def revision
        @revision ||= (::File.open('REVISION') { |f| f.read.strip } rescue nil)
      end

      def revision=(revision)
        @revision = revision
      end

      def timestamp
        @timestamp ||= (::File.open('REVISION') { |f| f.mtime } rescue nil)
      end

      def timestamp=(timestamp)
        @timestamp = timestamp.is_a?(Time) ? timestamp : Time.parse(timestamp)
      end

      def rack_dev_mark_env
        s = ENV['RACK_DEV_MARK_ENV']
        s.to_s == '' ? nil : s
      end
    end
  end
end

require 'rack/dev-mark/railtie' if defined?(Rails)

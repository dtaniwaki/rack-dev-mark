module Rack
  module DevMark
    class Middleware
      include Rack::Utils
      include Rack::DevMark::Utils

      def initialize(app, themes = [:title, :github_fork_ribbon])
        @app = app
        @themes = [themes].flatten.map do |theme|
          theme.is_a?(Symbol) ? Rack::DevMark::Theme.const_get(camelize(theme.to_s)).new : theme
        end
        @revision = Rack::DevMark.revision
        @timestamp = Rack::DevMark.timestamp
      end

      def call(env)
        Rack::DevMark.tmp_disabled = false

        status, headers, response = @app.call(env)

        headers = HeaderHash.new(headers)

        headers['X-Rack-Dev-Mark-Env'] = CGI.escape Rack::DevMark.env

        redirect = 300 <= status.to_i && status.to_i < 400
        if !redirect && !Rack::DevMark.tmp_disabled && headers['Content-Type'].to_s =~ %r{\btext/html\b}i
          new_body = ''
          response.each do |b|
            begin
              new_body << insert_dev_marks(b)
            rescue => e
              $stderr.write %Q|Failed to insert dev marks: #{e.message}\n  #{e.backtrace.join("  \n")}|
            end
          end
          response.close if response.respond_to?(:close)
          headers['Content-Length'] &&= new_body.bytesize.to_s
          response = [new_body]
        end

        [status, headers, response]
      end

      private

      def insert_dev_marks(body)
        @themes.each do |theme|
          body = theme.insert_into(body, Rack::DevMark.env, revision: @revision, timestamp: @timestamp)
        end
        body
      end
    end
  end
end

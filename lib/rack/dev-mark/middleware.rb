module Rack
  module DevMark
    class Middleware
      include Rack::Utils
      include Rack::DevMark::Utils

      def initialize(app, theme = :github_fork_ribbon)
        @app = app
        @title = Rack::DevMark::Title.new
        @theme = theme.is_a?(Symbol) ? Rack::DevMark::Theme.const_get(camelize(theme.to_s)).new : theme
      end
      
      def call(env)
        status, headers, response = @app.call(env)

        headers = HeaderHash.new(headers)

        headers['X-Rack-Dev-Mark-Env'] = Rack::DevMark.env

        if headers['Content-Type'].to_s =~ %r{^text/html;}i
          new_body = ''
          response.each do |b|
            begin
              new_body << insert_dev_marks(b)
            rescue Rack::DevMark::Exception => e
              $stderr.write "Failed to insert dev marks: #{e.message}\n"
            end
          end
          response.close if response.respond_to?(:close)
          headers['Content-Length'] &&= bytesize(new_body).to_s
          response = [new_body]
        end

        [status, headers, response]
      end

      private

      def insert_dev_marks(body)
        body = @title.insert_into(body, Rack::DevMark.env, Rack::DevMark.revision)
        body = @theme.insert_into(body, Rack::DevMark.env, Rack::DevMark.revision)
        body
      end
    end
  end
end

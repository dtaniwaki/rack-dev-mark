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

        if headers['Content-Type'].to_s =~ %r{^text/html;}i
          begin
            response = insert_dev_marks(response)
          rescue Rack::DevMark::Exception => e
            $stderr.write "Failed to insert dev marks: #{e.message}\n"
          end
        end

        [status, headers, response]
      end

      private

      def insert_dev_marks(response)
        body = ""
        response.each do |r|
          body.concat r.to_s
        end
        body = @title.insert_into(body, Rack::DevMark.env, Rack::DevMark.revision)
        body = @theme.insert_into(body, Rack::DevMark.env, Rack::DevMark.revision)
        [body]
      end
    end
  end
end

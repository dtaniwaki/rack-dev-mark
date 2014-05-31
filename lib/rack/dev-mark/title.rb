module Rack
  module DevMark
    class Title
      def insert_into(html, env)
        html.sub %r{(<title[^>]*>)}i, "\\1(#{env}) "
      end
    end
  end
end

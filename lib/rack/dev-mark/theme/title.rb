module Rack
  module DevMark
    module Theme
      class Title
        def insert_into(html, env, revision)
          html.sub %r{(<title[^>]*>)}i, "\\1(#{env}) "
        end
      end
    end
  end
end

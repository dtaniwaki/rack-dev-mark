module Rack
  module DevMark
    module Theme
      class Title
        def initialize(options = {})
          @options = options
        end

        def insert_into(html, env, revision)
          s = env
          s = s.upcase if @options[:upcase]
          if @options[:type].to_s == 'postfix'
            html.sub %r{(</title[^>]*>)}i, " (#{s})\\1"
          else
            html.sub %r{(<title[^>]*>)}i, "\\1(#{s}) "
          end
        end
      end
    end
  end
end

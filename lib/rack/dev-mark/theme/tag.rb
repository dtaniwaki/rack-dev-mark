require 'rack/dev-mark/theme/base'

module Rack
  module DevMark
    module Theme
      class Tag < Base
        def insert_into(html, env, params = {})
          name = @options[:name]

          if name
            html = gsub_tag_content html, name do |value|
              env_with_value(env, value)
            end
          end

          if attribute = @options[:attribute]
            Array(attribute).each do |attr|
              html = gsub_tag_attribute html, name, attr do |value|
                env_with_value(env, value)
              end
            end
          end

          html
        end

        private

        def env_with_value(env, org)
          s = env.to_s
          s = s.upcase if @options[:upcase]

          if @options[:type].to_s == 'postfix'
            "#{org} (#{s})"
          else
            "(#{s}) #{org}"
          end
        end
      end
    end
  end
end

require 'nokogiri'
require 'rack/dev-mark/theme/base'

module Rack
  module DevMark
    module Theme
      class Tag < Base
        def initialize(options = {})
          @options = options
        end

        def insert_into(html)
          h = Nokogiri::XML.fragment(html)

          name = @options[:name]

          if name
            h.css(name).each do |elem|
              s = elem.content.to_s
              elem.content = replace_string(s) if s != ''
            end
          end

          if attribute = @options[:attribute]
            Array(attribute).each do |attr|
              h.css("#{name}[#{attr}]").each do |elem|
                s = elem[attr]
                elem[attr] = replace_string(s) if s != ''
              end
            end
          end

          html = h.to_xml(:save_with => Nokogiri::XML::Node::SaveOptions::AS_HTML)
        end

        private

        def replace_string(org)
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

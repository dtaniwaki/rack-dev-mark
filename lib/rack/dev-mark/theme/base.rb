module Rack
  module DevMark
    module Theme
      class Base
        def initialize(*args)
          raise RuntimeError, 'Abstract class can not be instantiated' if self.class == Rack::DevMark::Theme::Base
        end

        def insert_into(html, env)

        end

        private

        def stylesheet_link_tag(path)
          %Q~<style>#{::File.open(::File.join(::File.dirname(__FILE__), '../../../../vendor/assets/stylesheets', path)).read}</style>~
        end
      end
    end
  end
end

module Rack
  module DevMark
    class RailsOptions
      attr_accessor :env, :enable, :theme

      alias_method :custom_theme, :theme
      alias_method :custom_theme=, :theme=

      %w(before after).each do |type|
        method_name = "insert_#{type}"
        define_method method_name do |middleware|
          @insert_type = [method_name, middleware]
        end
      end

      def insert_type
        @insert_type ||= []
      end
    end
  end
end

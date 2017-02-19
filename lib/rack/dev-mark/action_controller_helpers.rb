module Rack
  module DevMark
    module ActionControllerHelpers
      module ClassMethods
        def skip_rack_dev_mark(options = {})
          before_action_method_name = respond_to?(:before_action) ? :before_action : :before_filter
          public_send(before_action_method_name, options) do
            disable_rack_dev_mark
          end
        end
      end

      def self.included(base)
        base.extend ClassMethods
      end

      def disable_rack_dev_mark
        Rack::DevMark.tmp_disabled = true
      end

      def enable_rack_dev_mark
        Rack::DevMark.tmp_disabled = false
      end
    end
  end
end

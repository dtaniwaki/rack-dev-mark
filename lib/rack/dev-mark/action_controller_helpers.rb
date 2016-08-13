module Rack
  module DevMark
    module ActionControllerHelpers
      module ClassMethods
        def skip_rack_dev_mark(options = {})
          before_action options do
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

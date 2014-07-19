require 'i18n'

module Rack
  module DevMark
    module I18nHelper
      def self.included(base)
        class << base
          def env_with_i18n
            s = env_without_i18n
            ::I18n.translate(s, scope: 'rack_dev_mark', default: s)
          end
          alias_method :env_without_i18n, :env
          alias_method :env, :env_with_i18n
        end
      end
    end
  end
end

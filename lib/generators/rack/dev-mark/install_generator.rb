require 'rails/generators/base'

module Rack
  module DevMark
    class InstallGenerator < ::Rails::Generators::Base
      namespace 'rack:dev-mark:install'

      desc "Install rack-dev-mark."
      def insert_enable
        insert_into_file 'config/application.rb', after: "< Rails::Application\n" do <<-EOS
    config.rack_dev_mark.enable = !Rails.env.production?

        EOS
        end
      end
    end
  end
end

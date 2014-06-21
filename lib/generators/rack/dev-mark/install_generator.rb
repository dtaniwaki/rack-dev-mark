require 'rails/generators/base'

module Rack
  module DevMark
    class InstallGenerator < ::Rails::Generators::Base
      namespace 'rack:dev-mark:install'

      desc "Install rack-dev-mark."
      def insert_enable
        insert_into_file 'config/application.rb', after: "< Rails::Application\n" do <<-EOS
    # Enable rack-dev-mark
    config.rack_dev_mark.enable = !Rails.env.production?
    # Customize themes if you want to do so
    # config.rack_dev_mark.theme = [:title, :github_fork_ribbon]

        EOS
        end
      end
    end
  end
end

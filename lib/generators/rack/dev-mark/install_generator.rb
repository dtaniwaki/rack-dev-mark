require 'rails/generators'
require 'rails/generators/base'

module Rack
  module DevMark
    class InstallGenerator < ::Rails::Generators::Base
      namespace 'rack:dev-mark:install'

      desc "Install rack-dev-mark."
      def insert_enable
        insert_into_file target_path, after: "< Rails::Application\n" do <<-EOS
    # Enable rack-dev-mark
    config.rack_dev_mark.enable = !Rails.env.production?
    #
    # Customize the env string (default Rails.env)
    # config.rack_dev_mark.env = 'foo'
    #
    # Customize themes if you want to do so
    # config.rack_dev_mark.theme = [:title, :github_fork_ribbon]
    #
    # Customize inserted place of the middleware if necessary.
    # You can use either `insert_before` or `insert_after`
    # config.rack_dev_mark.insert_before SomeOtherMiddleware
    # config.rack_dev_mark.insert_after SomeOtherMiddleware

        EOS
        end
      end

      private

      def target_path
        'config/application.rb'
      end
    end
  end
end

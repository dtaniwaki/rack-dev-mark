require 'spec_helper'

if defined?(::Rails)
require 'tmpdir'
require 'generators/rack/dev-mark/initialize_generator'
describe Rack::DevMark::InitializeGenerator do
  include_context 'forked spec'

  context "config/application.rb" do
    it 'creates rack-dev-mark initializer' do
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          Rails::Generators.invoke("rack:dev-mark:initialize")
          expect(File.read("config/initializers/rack-dev-mark.rb")).to eq <<-EOS
config = Rails.application.config
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
    end
  end
end
end

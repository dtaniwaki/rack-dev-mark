require 'spec_helper'

if defined?(::Rails)
require 'tempfile'
require 'generators/rack/dev-mark/install_generator'
describe Rack::DevMark::InstallGenerator do
  include_context 'forked spec'

  context "config/application.rb" do
    let(:application_rb) { Tempfile.new('config_application.rb') }
    before do
      application_rb.write <<-EOS
module MyApp
  class Application < Rails::Application
    # ...
  end
end
      EOS
      application_rb.rewind
      allow_any_instance_of(Rack::DevMark::InstallGenerator).to receive(:target_path).and_return(application_rb.path)
    end
    after do
      application_rb.close
      application_rb.unlink
    end

    it 'inserts rack-dev-mark settings' do
      Rails::Generators.invoke("rack:dev-mark:install")
      application_rb.rewind
      expect(application_rb.read).to eq <<-EOS
module MyApp
  class Application < Rails::Application
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

    # ...
  end
end
      EOS
    end
  end

  describe "#target_path (private)" do
    subject { Rack::DevMark::InstallGenerator.new }
    it "returns 'config/application.rb'" do
      expect(subject.__send__(:target_path)).to eq('config/application.rb')
    end
  end
end
end

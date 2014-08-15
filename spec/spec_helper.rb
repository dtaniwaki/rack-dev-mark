require 'rubygems'
require 'simplecov'
require 'coveralls'
Coveralls.wear!

resultset_path = SimpleCov::ResultMerger.resultset_path
FileUtils.rm resultset_path if File.exists? resultset_path
SimpleCov.use_merging true
SimpleCov.at_exit do
  SimpleCov.command_name "fork-#{$$}"
  SimpleCov.result.format!
end
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start do
  add_filter 'spec/'
end

ENV['RACK_ENV'] = 'test'

require 'rack'
begin
  require 'rails'
  $stdout.write "* Rails has been loaded.\n"
rescue LoadError
end
begin
  require 'i18n'
  $stdout.write "* I18n has been loaded.\n"
  I18n.enforce_available_locales = true
  I18n.available_locales = [:ja, :en]
rescue LoadError
end
require 'rack-dev-mark'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].each {|f| require f }

RSpec.configure do |config|
  config.before :each do
    @rack_env = ENV['RACK_ENV']
    @rails_env = ENV['RAILS_ENV']
  end
  config.after :each do
    ENV['RACK_ENV'] = @rack_env
    ENV['RAILS_ENV'] = @rails_env
    Rack::DevMark.env = nil
    Rack::DevMark.tmp_disabled = nil
  end
end


module Rack
  module DevMark
    module Theme
    end
  end
end

Dir[::File.join(::File.dirname(__FILE__), 'theme', '*.rb')].each do |f|
  require f
end

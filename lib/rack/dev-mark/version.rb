module Rack
  module DevMark
    VERSION = ::File.read(::File.expand_path('../../../../VERSION', __FILE__)).to_s.strip
  end
end

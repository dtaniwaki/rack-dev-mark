module Rack
  module DevMark
    module Utils
      def camelize(s)
        s.split('_').map{ |_s| "#{_s[0].upcase}#{_s[1..-1]}" }.join
      end
    end
  end
end

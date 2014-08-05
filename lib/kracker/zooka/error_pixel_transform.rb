module Kracker
  module Zooka
    class ErrorPixelTransform
      attr_accessor :red, :green, :blue, :alpha

      def initialize
        @red   = 255
        @green = 0
        @blue  = 255
        @alpha = 255
      end

      def flat(d1, d2)
        {
          r: @red,
          g: @green,
          b: @blue,
          a: @alpha
        }
      end

      def movement(d1, d2)
        {
          r: ((d2.red   * (@red/255))   + @red)   / 2,
          g: ((d2.green * (@green/255)) + @green) / 2,
          b: ((d2.blue  * (@blue/255))  + @blue)  / 2,
          a: d2.alpha
        }
      end
    end
  end
end

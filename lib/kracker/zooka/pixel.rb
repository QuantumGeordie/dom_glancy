module Kracker
  module Zooka
    class Pixel
      attr_accessor :red, :green, :blue, :alpha

      def initialize(color_value)
        @alpha = ChunkyPNG::Color.a(color_value)
        @red   = ChunkyPNG::Color.r(color_value)
        @green = ChunkyPNG::Color.g(color_value)
        @blue  = ChunkyPNG::Color.b(color_value)
      end

      def brightness
        0.3 * @red + 0.59 * @green + 0.11 * @blue
      end

      def hue
        red   = @red   / 255.0
        green = @green / 255.0
        blue  = @blue  / 255.0

        min = [red, green , blue].sort.first
        max = [red, green , blue].sort.last

        h = 0
        d = 0

        if max == min
          h = 0
        else
          d = max - min
          h = case max
          when red
            (green  - blue) / d + (green  < blue ? 6 : 0)
          when green
            (blue - red) / d + 2
          when blue
            (red - green ) / d + 4
          else
            0
          end

          h = h / 6.0
        end
        h
      end

    end
  end
end

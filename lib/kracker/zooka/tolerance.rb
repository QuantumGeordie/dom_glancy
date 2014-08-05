module Kracker
  module Zooka
    class Tolerance
      attr_accessor :red, :green, :blue, :alpha, :min_brightness, :max_brightness, :hue

      def initialize
        @red = 16
        @green = 16
        @blue = 16
        @alpha = 16
        @min_brightness = 16
        @max_brightness = 240
        @hue = 0.3
      end

      def color(c)
        case c.downcase.to_sym
        when :alpha
          @alpha
        when :red
          @red
        when :blue
          @blue
        when :green
          @green
        when :min_brightness
          @min_brightness
        when :hue
          @hue
        else
          0
        end
      end
    end
  end
end

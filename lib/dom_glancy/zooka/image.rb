module DomGlancy
  module Zooka
    class Image
      attr_accessor :data, :pixels
      attr_accessor :red, :green, :blue, :alpha, :brightness
      attr_accessor :red_total, :green_total, :blue_total, :brightness_total

      def initialize(data)
        @data = data
        compute_image_summary
      end

      def display_image_info
        puts '-'*22
        puts "  Width:  #{@data.width}"
        puts "  Height: #{@data.height}"
        puts "  Avg. Red:    #{@red}"
        puts "  Avg. Green:  #{@green}"
        puts "  Avg. Blue:   #{@blue}"
        puts "  Total Red:   #{@red_total}"
        puts "  Total Green: #{@green_total}"
        puts "  Total Blue:  #{@blue_total}"
        puts '-'*22
      end

      private

      def on_all_pixels(image, &block)
        image.width.times do |x|
          image.height.times do |y|
            block.call(image[x, y])
          end
        end
      end

      def compute_image_summary
        @red    = 0
        @green  = 0
        @blue   = 0
        @pixels = 0

        @red_total        = 0
        @green_total      = 0
        @blue_total       = 0
        @brightness_total = 0

        on_all_pixels(@data) do |pixel_value|
          p = Pixel.new(pixel_value)
          @pixels = @pixels + 1
          @red   = @red   + p.red
          @green = @green + p.green
          @blue  = @blue  + p.blue

          @red_total        = @red_total   + p.red   / 255 * 100
          @green_total      = @green_total + p.green / 255 * 100
          @blue_total       = @blue_total  = p.blue  / 255 * 100
          # @brightness_total = @brightness_total
        end

        @red   = @red   / @pixels
        @green = @green / @pixels
        @blue  = @blue  / @pixels

        @red_total   = @red_total   / @pixels
        @green_total = @green_total / @pixels
        @blue_total  = @blue_total  / @pixels
      end
    end
  end
end

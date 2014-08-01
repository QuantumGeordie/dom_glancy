module Kracker
  module Zooka
    class Analyzer
      attr_accessor :tolerance, :ignore_antialiasing, :ignore_colors
      attr_accessor :data_1, :data_2
      attr_reader :result
      attr_reader :noncompliant_pixels

      def initialize(data_1, data_2)
        @tolerance = Tolerance.new
        @ignore_antialiasing = false
        @ignore_colors = false
        @data_1 = data_1
        @data_2 = data_2
        @noncompliant_pixels = []
      end

      def analyze
        @noncompliant_pixels = []
        @result = ChunkyPNG::Image.new(@data_1.width, @data_1.height, ChunkyPNG::Color::TRANSPARENT)

        @data_1.width.times do |x|
          @data_1.height.times do |y|
            pix_1 = Pixel.new(@data_1[x, y])
            pix_2 = Pixel.new(@data_2[x, y])

             if @ignore_colors
              if brightness_similar?(pix_1, pix_2)
                @result[x, y] = ChunkyPNG::Color::rgba(pix_1.red, pix_1.green, pix_1.blue, pix_1.alpha / 10)
              else
                @result[x, y] = ChunkyPNG::Color::rgba(255, 0, 0, 100)
                @noncompliant_pixels << { x: x, y: y }
              end
            else
              if rgb_similar?(pix_1, pix_2)
                @result[x, y] = ChunkyPNG::Color::rgba(pix_1.red, pix_1.green, pix_1.blue, pix_1.alpha / 10)
              elsif @ignore_antialiasing && (antialiased?(@data_1, x, y)  || antialiased?(@data_2, x, y))
                if brightness_similar?(pix_1, pix_2)
                  @result[x, y] = ChunkyPNG::Color::rgba(pix_1.red, pix_1.green, pix_1.blue, pix_1.alpha / 10)
                else
                  @result[x, y] = ChunkyPNG::Color::rgba(255, 0, 0, 100)
                  @noncompliant_pixels << { x: x, y: y }
                end
              else
                @result[x, y] = ChunkyPNG::Color::rgba(255, 0, 0, 100)
                @noncompliant_pixels << { x: x, y: y }
              end
            end
          end
        end
      end

      private

      def antialiased?(data, src_x, src_y)
        high_contrast_siblings = 0
        different_hue_siblings = 0
        equivalent_siblings    = 0

        pixel = Pixel.new(data[src_x, src_y])

        result = false

        other_pixels = []

        (-1..1).each do |x|
          (-1..1).each do |y|
            unless x == 0 && y == 0
              other_x = src_x + x
              other_y = src_y + y

              next if other_x >= data.width
              next if other_x < 0
              next if other_y >= data.height
              next if other_y < 0

              other_pixels << Pixel.new(data[other_x, other_y])
            end
          end
        end

        if other_pixels.length == 8
          other_pixels.each do |other_pixel|
            high_contrast_siblings = high_contrast_siblings + 1 if     contrasting?(pixel, other_pixel)
            equivalent_siblings    = equivalent_siblings    + 1 if     rgb_same?(pixel, other_pixel)
            different_hue_siblings = different_hue_siblings + 1 unless hue_same?(pixel, other_pixel)

            if different_hue_siblings > 1 || high_contrast_siblings > 1
              return true
            end
          end

          result = equivalent_siblings < 2
        else
          result = false
        end

        result
      end

      def contrasting?(pix1, pix2)
        (pix1.brightness - pix2.brightness).abs > @tolerance.max_brightness
      end

      def rgb_same?(pix1, pix2)
        red_same   = pix1.red   == pix2.red
        green_same = pix1.green == pix2.green
        blue_same  = pix1.blue  == pix2.blue

        red_same && green_same && blue_same
      end

      def hue_same?(pix1, pix2)
        (pix1.hue - pix2.hue).abs <= @tolerance.hue
      end

      def rgb_similar?(pix1, pix2)
        red_similar   = color_similar?(pix1.red, pix2.red, 'red')
        green_similar = color_similar?(pix1.green, pix2.green, 'green')
        blue_similar  = color_similar?(pix1.blue, pix2.blue, 'blue')
        alpha_similar = color_similar?(pix1.alpha, pix2.alpha, 'alpha')

        red_similar && green_similar && blue_similar && alpha_similar
      end

      def color_similar?(a, b, color)
        return true if a == b
        (a - b).abs < @tolerance.color(color)
      end

      def brightness_similar?(pix1, pix2)
        alpha      = color_similar?(pix1.alpha, pix2.alpha, 'alpha')
        brightness = color_similar?(pix1.brightness, pix2.brightness, 'min_brightness')
        brightness && alpha
      end

    end
  end
end

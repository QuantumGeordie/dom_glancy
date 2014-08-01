require_relative '../test_helper'

class AnalyzerTest < Kracker::KrackerTestCase
  require 'chunky_png'

  def test_similar_color
    image = ChunkyPNG::Image.new(10, 10)

    analyzer = Kracker::Zooka::Analyzer.new(image, image)

    assert analyzer.send(:color_similar?, 1, 1, 'red')
    assert analyzer.send(:color_similar?, 1, 16, 'red')
    refute analyzer.send(:color_similar?, 1, 17, 'red')

    refute analyzer.send(:color_similar?, 1, 2, 'no_color')

    analyzer.tolerance.red = 2
    assert analyzer.send(:color_similar?, 1, 1, 'red')
    assert analyzer.send(:color_similar?, 1, 2, 'red')
    refute analyzer.send(:color_similar?, 1, 3, 'red')
  end

  def test_similar_brightness
    image = ChunkyPNG::Image.new(10, 10)

    analyzer = Kracker::Zooka::Analyzer.new(image, image)
    analyzer.tolerance.red = 2

    pixel1 = Kracker::Zooka::Pixel.new(0)
    pixel2 = Kracker::Zooka::Pixel.new(0)

    assert analyzer.send(:brightness_similar?, pixel1, pixel2)

    pixel1.alpha = 1
    pixel1.red = 1

    pixel2.alpha = 10
    pixel2.red = 3

    assert analyzer.send(:brightness_similar?, pixel1, pixel2)
    refute analyzer.send(:color_similar?, pixel1.red, pixel2.red, 'red')

    pixel2.red = 100
    refute analyzer.send(:brightness_similar?, pixel1, pixel2)
  end

  def test_hue
    hue_data = [
              [   9, 135, 209, 0.5616 ],  #r:9   g:135 b:209 h:0.5616666666666666  - blue is greatest
              [ 106, 186, 221, 0.5507 ],  #r:106 g:186 b:221 h:0.5507246376811594  - blue is greatest
              [ 225, 254, 250, 0.4770 ],  #r:225 g:254 b:250 h:0.47701149425287354 - green is greatest
              [ 225, 254, 250, 0.4770 ]   #r:225 g:254 b:250 h:0.47701149425287354 - green is greatest
          ]

    hue_data.each do |hue_data_set|
      pixel1 = Kracker::Zooka::Pixel.new(ChunkyPNG::Color.rgba(hue_data_set[0], hue_data_set[1], hue_data_set[2], 128))
      assert_in_delta hue_data_set[3], pixel1.hue, 0.0001, "hue calcuation for r: #{hue_data_set[0]}, g: #{hue_data_set[1]}, b: #{hue_data_set[2]}"
    end

  end

  def test_analyze
    prep_locations_for_test

    filename_1 = make_zooka_filename('zooka_1')
    filename_2 = make_zooka_filename('zooka_2')
    result_filename_standard = make_zooka_filename('results_standard')
    result_file_ignore_colors = make_zooka_filename('result_ignore_colors')
    result_file_ignore_anitaliasing = make_zooka_filename('result_ignore_antialiasing')

    img1 = ChunkyPNG::Image.new(10, 10, ChunkyPNG::Color::rgb(0, 0, 255))
    img2 = img1.dup
    img2.width.times { |w| img2[w, w] = ChunkyPNG::Color::rgb(255 / (w+ 1), 0, 0) }
    img2.width.times { |w| img2[w, img2.width - w - 1] = ChunkyPNG::Color::rgb(0, 255 / (w+ 1), 0) }
    img1.save(filename_1)
    img2.save(filename_2)

    analyzer = Kracker::Zooka::Analyzer.new(img1, img2)
    analyzer.analyze
    result_image = analyzer.result
    pixels = analyzer.noncompliant_pixels

    result_image.save(result_filename_standard)

    assert_equal 20, pixels.length

    analyzer.ignore_colors = true
    analyzer.analyze
    pixels = analyzer.noncompliant_pixels
    result_image = analyzer.result
    result_image.save(result_file_ignore_colors)

    assert_equal 8, pixels.length

    analyzer.ignore_colors = false
    analyzer.ignore_antialiasing = true
    analyzer.analyze
    pixels = analyzer.noncompliant_pixels
    assert_equal 9, pixels.length
    result_image = analyzer.result
    result_image.save(result_file_ignore_anitaliasing)
    assert result_image.is_a?(ChunkyPNG::Image)

    remove_old_zooka_files
  end

  private

  def make_zooka_filename(base_name)
    Kracker.current_filename(base_name).gsub('yaml', 'png')
  end

  def remove_old_zooka_files
    Dir[File.join(Kracker::current_file_location, '*.png')].each { |f| FileUtils.rm_rf f }
    Dir[File.join(Kracker::master_file_location, '*.png')].each { |f| FileUtils.rm_rf f }
    Dir[File.join(Kracker::diff_file_location, '*.png')].each { |f| FileUtils.rm_rf f }
  end

end

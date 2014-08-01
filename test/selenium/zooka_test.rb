require 'selenium_test_helper'

class ZookaTest < Kracker::SeleniumTestCase

  def setup
    @filename_1 = Kracker::current_filename('zooka_1').gsub('yaml', 'png')
    @filename_2 = Kracker::current_filename('zooka_2').gsub('yaml', 'png')

    FileUtils.rm_rf @filename_1
    FileUtils.rm_rf @filename_2
  end

  def teardown
    FileUtils.rm_rf @filename_1
    FileUtils.rm_rf @filename_2
  end

  def test_zooka
    index_page = visit_index

    index_page.navigation.config!

    page.driver.save_screenshot(@filename_1)

    add_centered_element('the zooka will rock you!')
    page.driver.save_screenshot(@filename_2)

    image_1 = ChunkyPNG::Image.from_file(@filename_1)
    image_2 = ChunkyPNG::Image.from_file(@filename_2)

    analyzer = Kracker::Zooka::Analyzer.new(image_1, image_2)
    analyzer.analyze
    # diff_image = analyzer.result
    # diff_image.save('results.png')
    not_compliant = analyzer.noncompliant_pixels
    assert_equal 34400, not_compliant.count
  end

end

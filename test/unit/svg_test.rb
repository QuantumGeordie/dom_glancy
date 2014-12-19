require 'test_helper'

class SVGTest < DomGlancyTestCase
  def test_same_elements
    set_current_not_master = array_of_elements[0..3].to_set
    set_master_not_current = array_of_elements[8..9].to_set
    set_changed_master     = Set.new

    assert_equal 4, set_current_not_master.length
    assert_equal 2, set_master_not_current.length

    svg = DomGlancy::SVG.new(set_current_not_master, set_master_not_current, set_changed_master)
    rectangles = svg.send(:make_rectangles)

    assert_equal 6, rectangles.length
  end
end

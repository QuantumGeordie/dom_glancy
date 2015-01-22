require 'test_helper'

class ChangeAnalyzerTest < DomGlancyTestCase

  def test_change_calculator__initialization
    change_analyzer = DomGlancy::ChangeAnalyzer.new
    assert_equal 0,   change_analyzer.change_factors[0]
    assert_equal 1,   change_analyzer.change_factors[1]
    assert_equal 1.2, change_analyzer.change_factors[2]
    assert_equal 2,   change_analyzer.change_factors[3]
    assert_equal 5,   change_analyzer.change_factors[4]

    change_analyzer = DomGlancy::ChangeAnalyzer.new([50, 60])
    assert_equal 50,  change_analyzer.change_factors[0]
    assert_equal 60,  change_analyzer.change_factors[1]
    assert_equal 1.2, change_analyzer.change_factors[2]
    assert_equal 2,   change_analyzer.change_factors[3]
    assert_equal 5,   change_analyzer.change_factors[4]

    change_analyzer = DomGlancy::ChangeAnalyzer.new([55, 66, 7, 8, 9, 10, 12345, -10])
    assert_equal 55, change_analyzer.change_factors[0]
    assert_equal 66, change_analyzer.change_factors[1]
    assert_equal 7,  change_analyzer.change_factors[2]
    assert_equal 8,  change_analyzer.change_factors[3]
    assert_equal 9,  change_analyzer.change_factors[4]
    assert_nil change_analyzer.change_factors[5]

    change_analyzer.change_factors[3] = 23
    assert_equal 55, change_analyzer.change_factors[0]
    assert_equal 66, change_analyzer.change_factors[1]
    assert_equal 7,  change_analyzer.change_factors[2]
    assert_equal 23, change_analyzer.change_factors[3]
    assert_equal 9,  change_analyzer.change_factors[4]
    assert_nil change_analyzer.change_factors[5]
  end

  def test_change_calculator__calc
    change_analyzer = DomGlancy::ChangeAnalyzer.new

    element1 = DomGlancy::DOMElement.new(single_element_hash)

    element2 = element1.dup
    element2.top += 100

    element3 = element1.dup
    element3.width  += 25
    element3.height += 25

    element4 = element1.dup
    element4.width  += 10
    element4.height += 10
    element4.top    += 10

    element5 = element1.dup
    element5.width  += 3
    element5.height += 3
    element5.top    += 3
    element5.left   += 3

    change_value = change_analyzer.compare(element1, element2)
    assert_equal 100, change_value

    change_value = change_analyzer.compare(element1, element3)
    assert_equal 85.0, change_value

    change_value = change_analyzer.compare(element1, element4)
    assert_equal 70.0, change_value

    change_value = change_analyzer.compare(element1, element5)
    assert_equal 63, change_value
  end
end

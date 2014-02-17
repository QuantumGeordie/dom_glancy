require 'test_helper'

class ElementTest < Kracker::KrackerTestCase

  def test_sameness
    element1 = DOMElement.new(single_element_hash)
    element2 = DOMElement.new(single_element_hash.merge({"left" => 72}))

    assert element1.same_element?(element2), 'should be the same element'
    refute element1.all_same?(element2),     'should not be all same'
    assert element1.close_enough?(element2), 'should be the same element, but with slight differences'

    element1.left = 72
    assert element1.all_same?(element2), 'should be the same now'

    element2.id = 'stupid_id'
    refute element1.all_same?(element2)
    refute element1.same_element?(element2)
  end

  def test_similarity
    element1 = DOMElement.new(single_element_hash.merge({"similarity" => 2}))
    element2 = DOMElement.new(single_element_hash.merge({"left" => 72}))
    element3 = DOMElement.new(single_element_hash.merge({"left" => 74}))

    assert element1.same_element?(element2), 'should be the same element'
    assert element1.same_element?(element3), 'should be the same element'

    refute element1.all_same?(element2), 'should not be exactly the same'
    refute element1.all_same?(element3), 'should not be exactly the same'

    assert element1.close_enough?(element2), 'should be close enough'
    refute element1.close_enough?(element3), 'should not be close enough'

    element1.similarity = 4
    assert element1.close_enough?(element3), 'should not be close enough'
  end

  def test_changed_element__width
    element1 = DOMElement.new(array_of_elements.last)
    element2 = DOMElement.new(array_of_elements.last.merge("width" => 20))

    assert element1.same_element?(element2), 'should be same element'
    refute element1.close_enough?(element2), 'elements not close enough'
  end

end
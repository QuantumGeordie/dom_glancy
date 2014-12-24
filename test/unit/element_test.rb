require 'test_helper'

class ElementTest < DomGlancyTestCase

  def test_sameness
    element1 = DomGlancy::DOMElement.new(single_element_hash)
    element2 = DomGlancy::DOMElement.new(single_element_hash.merge({'left' => 72}))

    assert element1.same_element?(element2), 'should be the same element'
    refute element1.all_same?(element2),     'should not be all same'
    refute element1.close_enough?(element2), 'default similarity is 0 so not similar yet.'

    element1.similarity = 15
    assert element1.close_enough?(element2), 'default similarity is 15 now, so it is similar.'

    element1.left = 72
    assert element1.all_same?(element2), 'should be the same now'

    element2.id = 'stupid_id'
    refute element1.all_same?(element2)
    refute element1.same_element?(element2)
  end

  def test_sameness_and_similarity__no_id
    element_1 = DomGlancy::DOMElement.new({"id"=>"", "height"=>10, "visible"=>true, "tag"=>"SPAN", "width"=>50, "class"=>"", "left"=>71, "top"=>86, 'similarity' => DomGlancy.configuration.similarity})
    element_2 = DomGlancy::DOMElement.new({"id"=>"", "height"=>12, "visible"=>true, "tag"=>"SPAN", "width"=>52, "class"=>"", "left"=>72, "top"=>82, 'similarity' => DomGlancy.configuration.similarity})
    element_3 = DomGlancy::DOMElement.new({"id"=>"", "height"=>13, "visible"=>true, "tag"=>"SPAN", "width"=>54, "class"=>"", "left"=>72, "top"=>82, 'similarity' => DomGlancy.configuration.similarity})
    element_4 = DomGlancy::DOMElement.new({"id"=>"", "height"=>14, "visible"=>true, "tag"=>"SPAN", "width"=>56, "class"=>"", "left"=>72, "top"=>82, 'similarity' => DomGlancy.configuration.similarity})
    element_5 = DomGlancy::DOMElement.new({"id"=>"", "height"=>115, "visible"=>true, "tag"=>"SPAN", "width"=>58, "class"=>"", "left"=>72, "top"=>82, 'similarity' => DomGlancy.configuration.similarity})
    element_6 = DomGlancy::DOMElement.new({"id"=>"", "height"=>16, "visible"=>true, "tag"=>"SPAN", "width"=>142, "class"=>"", "left"=>72, "top"=>82, 'similarity' => DomGlancy.configuration.similarity})

    assert element_1.same_element?(element_2)
    assert element_1.same_element?(element_3)
    assert element_1.same_element?(element_4)
    assert element_1.same_element?(element_5)
    assert element_1.same_element?(element_6)

    assert element_1.close_enough?(element_2)
    assert element_1.close_enough?(element_3)
    assert element_1.close_enough?(element_4)
    refute element_1.close_enough?(element_5)
    refute element_1.close_enough?(element_6)
  end

  def test_similarity
    element1 = DomGlancy::DOMElement.new(single_element_hash.merge({'similarity' => 2}))
    element2 = DomGlancy::DOMElement.new(single_element_hash.merge({'left' => 72}))
    element3 = DomGlancy::DOMElement.new(single_element_hash.merge({'left' => 74}))

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
    element1 = DomGlancy::DOMElement.new(array_of_elements.last)
    element2 = DomGlancy::DOMElement.new(array_of_elements.last.merge("width" => 20))

    assert element1.same_element?(element2), 'should be same element'
    refute element1.close_enough?(element2), 'elements not close enough'
  end

end

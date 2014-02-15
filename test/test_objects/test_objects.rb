module Kracker
  module TestObjects
    def array_of_elements
      [
        {"id"=>"", "height"=>238, "visible"=>true, "tag"=>"DIV", "width"=>720, "class"=>"grid", "left"=>43, "top"=>14},
        {"id"=>"", "height"=>132, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>14},
        {"id"=>"", "height"=>132, "visible"=>true, "tag"=>"DIV", "width"=>340, "class"=>"slot-0-1-2 mm--title_text_main", "left"=>53, "top"=>14},
        {"id"=>"", "height"=>132, "visible"=>true, "tag"=>"H1", "width"=>340, "class"=>"", "left"=>53, "top"=>14},
        {"id"=>"mm--gem_rev", "height"=>0, "visible"=>true, "tag"=>"SPAN", "width"=>0, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86},
        {"id"=>"", "height"=>55, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>160},
        {"id"=>"", "height"=>55, "visible"=>true, "tag"=>"DIV", "width"=>340, "class"=>"slot-0-1-2", "left"=>53, "top"=>160},
        {"id"=>"", "height"=>55, "visible"=>true, "tag"=>"H2", "width"=>340, "class"=>"", "left"=>53, "top"=>160},
        {"id"=>"js-mm--nav", "height"=>23, "visible"=>true, "tag"=>"DIV", "width"=>700, "class"=>"row", "left"=>53, "top"=>229},
        {"id"=>"", "height"=>0, "visible"=>true, "tag"=>"A", "width"=>0, "class"=>"", "left"=>753, "top"=>216},
        {"id"=>"", "height"=>21, "visible"=>true, "tag"=>"DIV", "width"=>100, "class"=>"slot-0 mm--nav", "left"=>53, "top"=>231},
        {"id"=>"", "height"=>0, "visible"=>true, "tag"=>"A", "width"=>0, "class"=>"", "left"=>753, "top"=>216},
        {"id"=>"", "height"=>21, "visible"=>true, "tag"=>"DIV", "width"=>100, "class"=>"slot-1 mm--nav", "left"=>173, "top"=>231},
        {"id"=>"", "height"=>0, "visible"=>true, "tag"=>"A", "width"=>0, "class"=>"", "left"=>753, "top"=>216}
      ]
    end

    def array_of_elements_small
      [
          {"id"=>"", "height"=>238, "visible"=>true, "tag"=>"DIV", "width"=>720, "class"=>"grid", "left"=>43, "top"=>14},
          {"id"=>"mm--gem_rev", "height"=>0, "visible"=>true, "tag"=>"SPAN", "width"=>0, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86}
      ]
    end

    def single_element_hash
      {"id"=>"mm--gem_rev", "height"=>0, "visible"=>true, "tag"=>"SPAN", "width"=>0, "class"=>"mm--title_text_sub", "left"=>71, "top"=>86}
    end
  end
end
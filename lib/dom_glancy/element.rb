module DomGlancy

  class DOMElement
    ## element looks like this in archive.
    # {"id"=>"", "height"=>238, "visible"=>true, "tag"=>"DIV", "width"=>720, "class"=>"grid", "left"=>43, "top"=>14}

    attr_accessor :id
    attr_accessor :tag
    attr_accessor :left
    attr_accessor :top
    attr_accessor :height
    attr_accessor :width
    attr_accessor :klass
    attr_accessor :visible
    attr_accessor :style
    attr_accessor :similarity

    def initialize(h = {})
      @tag        = h[:tag]        || h['tag']
      @left       = h[:left]       || h['left']
      @top        = h[:top]        || h['top']
      @height     = h[:height]     || h['height']
      @width      = h[:width]      || h['width']
      @klass      = h[:class]      || h['class']
      @id         = h[:id]         || h['id']
      @style      = h[:style]      || h['style']
      @visible    = h[:visible]    || h['visible']
      @similarity = h[:similarity] || h['similarity'] || 15
    end

    def same_element?(anOther)
      same = same_tag?(anOther)   &&
             same_id?(anOther)    &&
             same_class?(anOther)
    end

    def all_same?(anOther)
      same = same_element?(anOther)     &&
          similar_size?(anOther, 0)     &&
          similar_location?(anOther, 0) &&
          same_size?(anOther) &&
          same_visibility?(anOther)
    end

    def close_enough?(anOther)
      r = same_element?(anOther)                  &&
          similar_location?(anOther, @similarity) &&
          similar_size?(anOther, @similarity)     &&
          same_style?(anOther)                    &&
          same_visibility?(anOther)
    end

    def similar_size?(anOther, similarity = 0)
      similar = (@height - anOther.height).abs <= similarity
      similar && (@width - anOther.width).abs <= similarity
    end

    def similar_location?(anOther, similarity = 0)
      similar = (@top - anOther.top).abs <= similarity
      similar && (@left - anOther.left).abs <= similarity
    end

    def same_tag?(anOther)
      @tag == anOther.tag
    end

    def same_location?(anOther)
      (@left == anOther.left) && (@top == anOther.top)
    end

    def same_size?(anOther)
      (@height == anOther.height) && (@width == anOther.width)
    end

    def same_class?(anOther)
      @klass == anOther.klass
    end

    def same_id?(anOther)
      @id == anOther.id
    end

    def same_visibility?(anOther)
      @visible == anOther.visible
    end

    def same_style?(anOther)
      @style == anOther.style
    end

  end
end

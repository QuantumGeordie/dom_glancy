module DomGlancy
  class SVG
    @set_current_not_master
    @set_master_not_current
    @set_changed_master

    def initialize(set_current_not_master, set_master_not_current, set_changed_master)
      @set_current_not_master = set_current_not_master
      @set_master_not_current = set_master_not_current
      @set_changed_master     = set_changed_master
    end

    def generate_svg
      add_ids

      rectangles = make_rectangles

      width, height = get_window_size_from_rectangles(rectangles)
      s = svg_start(width, height)

      rectangles.each do |rectangle|
        rectangle_string = "      <rect id='#{rectangle[:js_id]}' x = '#{rectangle['left']}' y = '#{rectangle['top']}' width = '#{rectangle['width']}' height = '#{rectangle['height']}' fill = '#{rectangle[:fill]}' stroke = '#{rectangle[:stroke]}' stroke-width = '#{rectangle[:stroke_width]}' fill-opacity = '#{rectangle[:opacity]}' />\n"
        s += rectangle_string
      end

      s += svg_end
      s += "\n"
    end

    private

    def add_ids
      js_id = 0
      @set_master_not_current.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end
      @set_current_not_master.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end
      @set_changed_master.each do |item|
        item[:js_id] = js_id
        js_id += 1
      end
    end

    def make_rectangles
      rectangles = @set_current_not_master.map  { |item| item.merge(format__not_in_master) }
      rectangles << @set_master_not_current.map { |item| item.merge(format__not_in_current) }
      rectangles << @set_changed_master.map     { |item| item.merge(format__same_but_different) }
      rectangles.flatten!
    end

    def get_window_size_from_rectangles(rectangles)
      width = 0
      height = 0

      rectangles.each do |rectangle|
        rectangle_right  = rectangle['left'].to_i + rectangle['width'].to_i
        rectangle_bottom = rectangle['top'].to_i + rectangle['height'].to_i
        width  = rectangle_right if rectangle_right > width
        height = rectangle_bottom if rectangle_bottom > height
      end

      [width, height]
    end

    def svg_start(width, height)
      s = ["<?xml version='1.0' standalone='no'?>"]
      s << "  <!DOCTYPE svg PUBLIC '-//W3C//DTD SVG 1.1//EN' 'http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd'>"
      s << "  <svg version = '1.1' width='#{width}px' height='#{height}px' border='2px' style='background-color:#FFFFFF;border:1px solid black;'>"
      s << ''

      s.join("\n")
    end

    def svg_end
      s = ['  </svg>']
      s << ''

      s.join("\n")
    end

    def format__not_in_master
      {
        :stroke       => 'blue',
        :fill         => 'white',
        :stroke_width => '1',
        :opacity      => '0.5'
      }
    end

    def format__not_in_current
      {
        :stroke       => 'red',
        :fill         => 'white',
        :stroke_width => '1',
        :opacity      => '0.5'
      }
    end

    def format__same_but_different
      {
        :stroke       => 'orange',
        :fill         => 'white',
        :stroke_width => '1',
        :opacity      => '0.5'
      }
    end
  end
end

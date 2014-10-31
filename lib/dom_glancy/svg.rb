module DomGlancy

  def generate_svg(rectangles)
    width, height = get_window_size_from_rectangles(rectangles)
    s = svg_start(width, height)

    rectangles.each do |rectangle|
      rectangle_string = "      <rect id='#{rectangle[:js_id]}' x = '#{rectangle['left']}' y = '#{rectangle['top']}' width = '#{rectangle['width']}' height = '#{rectangle['height']}' fill = '#{rectangle[:fill]}' stroke = '#{rectangle[:stroke]}' stroke-width = '#{rectangle[:stroke_width]}' fill-opacity = '#{rectangle[:opacity]}' />\n"
      s += rectangle_string
    end

    s += svg_end
    s += "\n"
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

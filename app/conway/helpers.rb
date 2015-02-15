module ConwayWindow
  Height = `$(window).height()`
  Width = `$(window).width()`
end

class Context
  attr_reader :context

  def initialize(canvas: "", type: "")
    @context = `#{canvas.canvas}.getContext(#{type})`
  end

  def move_to(x: 0, y: 0, rect: nil)
    unless rect.nil?
      x, y, width, height = rect.to_args
    end

    `#{@context}.moveTo(#{x}, #{y})`
  end

  def stroke_style(color: "")
    `#{@context}.strokeStyle = #{color}`
  end

  def stroke
    `#{@context}.stroke()`
  end

  def line_to(x: 0, y: 0, rect: nil)
    unless rect.nil?
      x, y, width, height = rect.to_args
    end

    `#{@context}.lineTo(#{x}, #{y})`
  end

  def fill_style(color: "")
    `#{@context}.fillStyle = #{color}`
  end

  def fill_rect(x: 0, y: 0, width: 0, height: 0, rect: nil)
    unless rect.nil?
      x, y, width, height = rect.to_args
    end

    `#{@context}.fillRect(#{x}, #{y}, #{width}, #{height})`
  end

  def clear_rect(x: 0, y: 0, width: 0, height: 0, rect: nil)
    unless rect.nil?
      x, y, width, height = rect.to_args
    end

    `#{@context}.clearRect(#{x}, #{y}, #{width}, #{height})`
  end
end

class Canvas
  attr_reader :canvas

  def initialize(id: "", height: 0, width: 0)
    @id = id
    @canvas = `document.getElementById(#{id})`
    set_height(height)
    set_width(width)
  end

  def set_width(w)
    `#{@canvas}.width  = #{w}`
  end

  def set_height(h)
    `#{@canvas}.height  = #{h}`
  end

  def on(event, &block)
    Element.find("##{@id}").on(event, &block)
  end
end

class Context2D < Context
  def initialize(canvas: "")
    super(canvas: canvas, type: "2d")
  end
end

class Mouse
  def self.cursor(event)
    if (event.page_x && event.page_y)
      x = event.page_x;
      y = event.page_y;
    else
      doc = Opal.Document[0]
      x = event[:clientX] + doc.scrollLeft +
        doc.documentElement.scrollLeft;
      y = event[:clientY] + doc.body.scrollTop +
        doc.documentElement.scrollTop;
    end

    [x, y]
  end
end

class Rect < OpenStruct
end

Rect.class_eval do
  def to_args
    [x, y, width, height]
  end
end

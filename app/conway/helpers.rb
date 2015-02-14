# require 'opal'

module Window
  Height = `$(window).height()`
  Width = `$(window).width()`
end

class Context
  attr_reader :context

  def initialize(canvas: "", type: "")
    @context = `#{canvas.canvas}.getContext(#{type})`
  end

  def move_to(x: 0, y: 0)
    `#{@context}.moveTo(#{x}, #{y})`
  end

  def stroke_style(color: "")
    `#{@context}.strokeStyle = #{color}`
  end

  def stroke
    `#{@context}.stroke()`
  end

  def line_to(x: 0, y: 0)
    `#{@context}.lineTo(#{x}, #{y})`
  end

  def fill_style(color: "")
    `#{@context}.fillStyle = #{color}`
  end

  def fill_rect(x: 0, y: 0, width: 0, height: 0)
    `#{@context}.fillRect(#{x}, #{y}, #{width}, #{height})`
  end

  def clear_rect(x: 0, y: 0, width: 0, height: 0)
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

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
end

class Context2D < Context
  def initialize(canvas: "")
    super(canvas: canvas, type: "2d")
  end
end

class Canvas
  attr_reader :canvas

  def initialize(id: "", height: 0, width: 0)
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
end


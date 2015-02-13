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

module Cell
  Height = 25
  Width = 50
  StrokeColor = "#23eeee"
end

class Grid
  def initialize
    canvas = Canvas.new(
      id: 'conwayCanvas',
      height: Window::Height,
      width: Window::Width
    )
    @context = Context2D.new(canvas: canvas)
  end

  def draw
    columns.times do |x|
      @context.move_to(x: Cell::Width * x, y: 0)
      @context.line_to(x: Cell::Width * x, y: Window::Height)
    end

    rows.times do |y|
      @context.move_to(x: 0, y: Cell::Width * y)
      @context.line_to(x: Window::Width, y: Cell::Width * y)
    end

    @context.stroke_style(color: Cell::StrokeColor)
    @context.stroke
  end

  private

  def columns
    (Window::Width / Cell::Width).floor
  end

  def rows
    (Window::Height / Cell::Height).floor
  end
end

Grid.new.draw

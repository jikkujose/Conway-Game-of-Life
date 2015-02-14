require 'conway/helpers.rb'

module Cell
  Height = 25
  Width = 50
  StrokeColor = "#23eeee"
end

class Grid
  def initialize(canvas_id: "")
    canvas = Canvas.new(
      id: canvas_id,
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

Grid.new(canvas_id: 'conwayCanvas').draw
puts "Jiks"

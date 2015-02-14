require 'conway/helpers.rb'

module Cell
  Height = 30
  Width = Height
  StrokeColor = "#23eeee"
  FillColor = StrokeColor
end

class Grid
  def initialize(canvas_id: "")
    @canvas = Canvas.new(
      id: canvas_id,
      height: Window::Height,
      width: Window::Width
    )

    @context = Context2D.new(canvas: @canvas)
    @context.stroke_style(color: Cell::StrokeColor)
    @context.fill_style(color: Cell::FillColor)
  end

  def draw
    columns.times do |x|
      @context.move_to(x: Cell::Width * x, y: 0)
      @context.line_to(x: Cell::Width * x, y: Window::Height)
    end

    rows.times do |y|
      @context.move_to(x: 0, y: Cell::Height * y)
      @context.line_to(x: Window::Width, y: Cell::Height * y)
    end

    @context.stroke

    self
  end

  def fill_cell(x, y)
    @context.fill_rect(
      x: Cell::Width * x,
      y: Cell::Height * y,
      width: Cell::Width,
      height: Cell::Height
    )
  end

  def clear_cell(x, y)
    @context.clear_rect(
      x: Cell::Width * x,
      y: Cell::Height * y,
      width: Cell::Width,
      height: Cell::Height
    )
  end

  # private

  def columns
    (Window::Width / Cell::Width).ceil
  end

  def rows
    (Window::Height / Cell::Height).floor
  end

  def add_event_listeners
    Element.find("#conwayCanvas").on :click do |event|
      puts "Jikku Jso"
      fill_cell 5, 11
    end
  end
end

grid = Grid.new(canvas_id: 'conwayCanvas')
grid.draw
grid.add_event_listeners

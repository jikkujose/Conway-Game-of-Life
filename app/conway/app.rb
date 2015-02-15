require 'conway/helpers.rb'

module Cell
  Height = 80
  Width = Height
  StrokeColor = "#256ba6"
  FillColor = StrokeColor

  def self.x(x_coordinate)
    (x_coordinate / Width).floor
  end

  def self.y(y_coordinate)
    (y_coordinate / Height).floor
  end

  def self.rect(x: x, y: y)
    Rect.new(x: x, y: y, width: Width, height: Height)
  end

  class Rect < ::Rect
    def initialize(x: 0, y: 0)
      super(
      x: Width * x,
      y: Height * y,
      width: Width,
      height: Height
      )
    end
  end
end

class Grid
  def initialize(canvas_id: "")
    @canvas = Canvas.new(
      id: canvas_id,
      height: ConwayWindow::Height,
      width: ConwayWindow::Width
    )

    @context = Context2D.new(canvas: @canvas)
    @context.stroke_style(color: Cell::StrokeColor)
    @context.fill_style(color: Cell::FillColor)
  end

  def run
    draw
    add_event_listeners
  end

  private

  def draw
    columns.times do |x|
      @context.move_to(x: Cell::Width * x, y: 0)
      @context.line_to(x: Cell::Width * x, y: ConwayWindow::Height)
    end

    rows.times do |y|
      @context.move_to(x: 0, y: Cell::Height * y)
      @context.line_to(x: ConwayWindow::Width, y: Cell::Height * y)
    end

    @context.stroke

    self
  end

  def fill_cell(x, y)
    @context.fill_rect rect: Cell::Rect.new(x: x, y: y)
  end

  def clear_cell(x, y)
    @context.clear_rect rect: Cell::Rect.new(x: x, y: y)
  end

  def columns
    Cell.x ConwayWindow::Width
  end

  def rows
    Cell.y ConwayWindow::Height
  end

  def add_event_listeners
    @canvas.on :click do |event|
      x, y = Mouse.cursor event

      fill_cell Cell.x(x), Cell.y(y)
    end

    @canvas.on :dblclick do |event|
      x, y = Mouse.cursor event

      clear_cell Cell.x(x), Cell.y(y)
    end
  end
end

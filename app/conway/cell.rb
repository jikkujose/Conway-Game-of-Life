module Cell
  Height = Config::Cell::Height
  Width = Height
  StrokeColor = Config::Cell::StrokeColor
  FillColor = Config::Cell::FillColor

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

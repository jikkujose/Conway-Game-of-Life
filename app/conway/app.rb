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

    initialize_state
  end

  def run
    redraw
    add_event_listeners
  end

  private

  def initialize_state
    @state = {}

    columns.times do |x|
      rows.times do |y|
        @state[[x, y]] = false
      end
    end
  end

  def redraw
    draw_state
    draw_grid
  end

  def draw_grid
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
    1 + Cell.y(ConwayWindow::Height)
  end

  def draw_state
    @state.each do |coordinate, state|
      state == true ? fill_cell(*coordinate) : clear_cell(*coordinate)
    end
  end

  def enter_key?(key)
    key.which == 13
  end

  def add_event_listeners
    @canvas.on :click do |event|
      x, y = Mouse.cursor event
      cell_coordinate = [Cell.x(x), Cell.y(y)]
      @state[cell_coordinate] = true

      fill_cell(*cell_coordinate)
    end

    @canvas.on :dblclick do |event|
      x, y = Mouse.cursor event
      cell_coordinate = [Cell.x(x), Cell.y(y)]
      @state[cell_coordinate] = false

      clear_cell(*cell_coordinate)
    end

    Document.on :keypress do |event|
      puts "hey"
      if enter_key?(event)
        @state = Conway.next_state(@state)
        redraw
      end
    end
  end
end

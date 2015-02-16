module CoordinateShift
  def shift_to(address)
    [self[0] + address[0], self[1] + address[1]]
  end
end

class Conway
  def self.new_state(old_state)
    Conway.new(old_state).evolve.state
  end

  def initialize(state)
    @state = state
  end

  def evolve
    @state.each_with_object({}) do |(coordinate, state), new_state|
    end

    self
  end

  def alive?(coordinate)
    @state[[x, y]] == true
  end

  def number_of_neighbours(coordinate)
    coordinate.extend CoordinateShift

    surrounding_squares.count do |address|
      @state[coordinate.shift_to(address)]
    end
  end

  private

  def surrounding_squares
    template = [1, 0, 1]
    template.product(template) - [[0, 0]]
  end
end

__END__
Rule 1

Any live cell with fewer than two live neighbors dies, as if caused by under-population.
Rule 2

Any live cell with two or three live neighbors lives on to the next generation.
Rule 3

Any live cell with more than three live neighbors dies, as if by overcrowding.
Rule 4

Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

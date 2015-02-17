module CellGrid
  def surrounding_cells
    template = [-1, 0, 1]
    cells = template.extend(CellGrid).product(template) - [[0, 0]]
    cells.map { |cell| cell.extend CellGrid }

    cells.map { |cell| cell.shift_to(self) }
  end

  def shift_to(address)
    [self[0] + address[0], self[1] + address[1]]
  end

  def product(array)
    self.flat_map do |element|
      array.map do |inner_element|
        [element, inner_element]
      end
    end
  end
end

class Conway
  attr_reader :state

  def self.next_state(old_state)
    Conway.new(old_state).next_state.state
  end

  def initialize(state)
    @state = state
  end

  def next_state
    @state = @state.each_with_object({}) do |(coordinate, state), new_state|
      new_state[coordinate] = case neighbours(coordinate)
                               when 2
                                 state
                               when 3
                                 true
                               else
                                 false
                               end
    end

    self
  end

  private

  def neighbours(coordinate)
    coordinate.extend CellGrid

    coordinate.surrounding_cells.count do |cell|
      @state[cell]
    end
  end
end

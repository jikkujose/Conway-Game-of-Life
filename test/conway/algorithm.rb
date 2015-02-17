require 'minitest'
require 'minitest/reporters'
require_relative '../../app/conway/algorithm'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({detailed_skip: false})]

class ConwayTest < Minitest::Test
  def test_one_cell_state
    dead_state = {[1, 1] => false}
    alive_state = {[1, 1] => true}

    assert_equal dead_state, Conway.next_state(dead_state)
    assert_equal dead_state, Conway.next_state(alive_state)
  end

  def test_two_cell_state
    all_dead = {
      [1,1] => false,
      [1,2] => false,
    }

    one_alive = {
      [1,1] => true,
      [1,2] => false,
    }

    assert_equal all_dead, Conway.next_state(one_alive)
  end

  def test_nine_by_nine
    template = [-1, 0, 1]
    nine_by_nine = template.product(template)

    too_crowded_world = nine_by_nine.each_with_object({}) do |coordinate, state|
      state[coordinate] = true
    end

    result = nine_by_nine.each_with_object({}) do |coordinate, state|
      state[coordinate] = false
    end

    [
      [-1, -1],
      [-1, 1],
      [1, -1],
      [1, 1],
    ].each do |live_address|
      result[live_address] = true
    end

    assert_equal result, Conway.next_state(too_crowded_world)
  end

  def test_recurring_triplet
    template = [-1, 0, 1]
    nine_by_nine = template.product(template)

    all_blank = nine_by_nine.each_with_object({}) do |coordinate, state|
      state[coordinate] = false
    end

    north = all_blank.dup

    [
      [-1, 0],
      [0, 0],
      [1, 0]
    ].each do |live_address|
      north[live_address] = true
    end

    south = all_blank.dup


    [
      [0, -1],
      [0, 0],
      [0, 1],
    ].each do |live_address|
      south[live_address] = true
    end

    assert_equal north, Conway.next_state(south)
    assert_equal south, Conway.next_state(north)
  end
end

Minitest.autorun

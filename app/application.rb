require 'conway/helpers.rb'
require 'conway/app.rb'

grid = Grid.new(canvas_id: 'conwayCanvas')
grid.draw
grid.add_event_listeners

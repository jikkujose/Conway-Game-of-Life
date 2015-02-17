require 'config'
require 'conway/helpers.rb'
require 'conway/algorithm.rb'
require 'conway/cell.rb'
require 'conway/app.rb'

Grid.new(canvas_id: Config::CanvasId).run

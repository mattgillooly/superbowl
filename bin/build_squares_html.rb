#!/usr/bin/env ruby

require 'erb'
require 'optparse'
require 'superbowl'

squares_file = nil
box_scores_file = nil

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: build_squares_html.rb [options]'

  opts.on('-sFILE', '--squares=FILE', 'File containing square owners') do |f|
    squares_file = f
  end

  opts.on('-bFILE', '--box-scores=FILE', 'File with historic box scores') do |f|
    box_scores_file = f
  end
end

opt_parser.parse!

fail 'missing squares file' unless squares_file
fail 'missing box-scores file' unless box_scores_file

b = binding

b.local_variable_set(
  :grid,
  Superbowl::Grid.parse(squares_file)
)

b.local_variable_set(
  :box_score_history,
  Superbowl::BoxScoreHistory.parse(box_scores_file)
)

renderer = ERB.new(File.read('squares.html.erb'))
puts renderer.result(b)

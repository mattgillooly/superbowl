#!/usr/bin/env ruby

require 'erb'
require 'optparse'
require 'superbowl'

grid = nil
box_score_history = nil

opt_parser = OptionParser.new do |opts|
  opts.banner = 'Usage: build_squares_html.rb [options]'

  opts.on('-sFILE', '--squares=FILE', 'File containing square owners') do |f|
    grid = Superbowl::Grid.parse(f)
  end

  opts.on('-bFILE', '--box-scores=FILE', 'File with historic box scores') do |f|
    box_score_history = Superbowl::BoxScoreHistory.parse(f)
  end
end

opt_parser.parse!

fail 'missing squares file' unless grid
fail 'missing box-scores file' unless box_score_history

renderer = ERB.new(File.read('squares.html.erb'))
puts renderer.result

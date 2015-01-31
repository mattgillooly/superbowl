#!/usr/bin/env ruby

require 'csv'
require 'erb'
require 'optparse'

squares_file = nil
box_scores_file = nil

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: build_squares_html.rb [options]"

  opts.on("-sFILE", "--squares=FILE", "File containing square owners") do |f|
    squares_file = f
  end

  opts.on("-bFILE", "--box-scores=FILE", "File containing historic box scores") do |f|
    box_scores_file = f
  end
end

opt_parser.parse!

fail "missing squares file" unless squares_file
fail "missing box-scores file" unless box_scores_file

squares = CSV.open(squares_file, col_sep: "\t")

BOX_SCORES = CSV.open(box_scores_file, headers: %w(quarter x y)).to_a
BOX_SCORE_COUNTS = Array.new(10) { Array.new(10) { 0 } }

BOX_SCORES.each do |box_score|
  x, y = box_score.values_at('x', 'y').map(&:to_i)
  BOX_SCORE_COUNTS[x][y] += 1
end

def ratio(row_index, col_index)
  # TODO: force symmetry?
  BOX_SCORE_COUNTS[row_index][col_index] / BOX_SCORES.count.to_f
end

def probability(row_index, col_index)
  "%.2f%" % (ratio(row_index, col_index) * 100)
end

def grid_color(row_index, col_index)
  hex_val = 15 - (ratio(row_index, col_index) * 100).to_i
  hex_val.to_s(16) * 6
end

renderer = ERB.new(File.read('squares.html.erb'))
puts renderer.result()

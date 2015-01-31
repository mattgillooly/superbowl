require 'csv'

module Superbowl
  # Stores historic score information for the end of each quarter for every
  # Superbowl in history.
  class BoxScoreHistory
    def self.parse(filename)
      new(CSV.open(filename, headers: %w(quarter x y)).to_a)
    end

    def initialize(box_scores)
      @counts = Array.new(10) { Array.new(10) { 0 } }

      box_scores.each do |box_score|
        x, y = box_score.values_at('x', 'y').map(&:to_i)
        @counts[x][y] += 1
      end

      @num_box_scores = box_scores.count
    end

    def ratio(row_index, col_index)
      # TODO: force symmetry?
      @counts[row_index][col_index].to_f / @num_box_scores
    end

    def probability(row_index, col_index)
      format('%.df%', ratio(row_index, col_index) * 100)
    end

    def grid_color(row_index, col_index)
      hex_val = 15 - (ratio(row_index, col_index) * 100).to_i
      hex_val.to_s(16) * 6
    end
  end
end

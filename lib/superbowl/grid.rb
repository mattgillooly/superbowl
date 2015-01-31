require 'csv'

module Superbowl

  class Grid
    attr_reader :squares

    def self.parse(filename)
      new(CSV.open(filename, col_sep: "\t").to_a)
    end

    def initialize(squares)
      @squares = squares
    end

    def contestants(box_score_history)
      contestants_by_name = {}

      @squares.each_with_index do |row, row_index|
        row.each_with_index do |owner, col_index|
          c = contestants_by_name[owner] ||= Contestant.new(owner, 0, 0)
          c.expected_payout += box_score_history.ratio(row_index, col_index) * 1000
          c.num_squares += 1
        end
      end

      contestants_by_name.values.sort_by(&:expected_payout).reverse
    end
  end

end

module Superbowl
  # Represent a contestant in the pool
  class Contestant < Struct.new(:name, :expected_payout, :num_squares)
    def total_investment
      10.0 * num_squares
    end

    def expected_roi
      100 * (expected_payout - total_investment) / total_investment
    end
  end
end

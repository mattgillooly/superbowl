#!/usr/bin/env ruby

require 'nokogiri'

doc = Nokogiri::HTML(ARGF.read)

tables = doc.xpath('//*[@id="content"]/div/div/table/tbody/tr/td/table')
winning_squares_tables = tables.select { |t| t.to_s.include? 'Winner' }

winning_squares_tables.each do |table|
  labels, digit_pairs = table.xpath('.//td').map(&:text).each_slice(4).to_a

  labels.zip(digit_pairs).each do |label, digit_pair|
    fail "unexpected label: #{label}" unless label.match(/Quarter Winner/)

    puts "Q#{label[0]},#{digit_pair}"
  end
end

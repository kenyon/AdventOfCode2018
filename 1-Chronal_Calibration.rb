#!/usr/bin/env ruby

sum = 0

ARGF.each do |line|
  sum += line.to_i
end

puts sum

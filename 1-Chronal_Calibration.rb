#!/usr/bin/env ruby

# Sum of the numbers in the input file.
sum = 0

# Array representation of the input file.
freq_changes = []

ARGF.each do |line|
  freq_changes << line.to_i
  sum += line.to_i
end

# Part 1 answer: 437
puts "resulting frequency: #{sum}"

sum = 0

# Hash, with frequencies mapping to the number of times they've been
# seen. Zero is the default value.
freqs = Hash.new(0)

# Process frequency changes until a frequency value is reached twice.
enumerator = freq_changes.cycle
until freqs.value?(2) do
  sum += enumerator.next
  freqs[sum] += 1
end

# Part 2 answer: 655 (took 10.5 minutes to calculate this!)
puts "first frequency reached twice: " + freqs.key(2).to_s

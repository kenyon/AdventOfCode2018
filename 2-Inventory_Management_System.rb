#!/usr/bin/env ruby

# IDs that contain exactly two occurrences of any letter.
count_twos = 0

# IDs that contain exactly three occurrences of any letter.
count_threes = 0

# Hash representation of the input file (each line is a "box ID"):
# Keys are the box IDs. Values are hashes where each character in the
# ID is a key, with its value being the count of times that character
# appears in the box ID.

ids = {}

ARGF.each do |line|
  ids[line.chomp] = {}

  line.chomp.each_char do |c|
    ids[line.chomp][c] = line.chomp.count(c)
  end
end

ids.each_value do |id_count_hash|
  count_twos += 1 if id_count_hash.has_value?(2)
  count_threes += 1 if id_count_hash.has_value?(3)
end

# The "checksum" is the product of the counts.

puts "checksum: #{count_twos * count_threes}"

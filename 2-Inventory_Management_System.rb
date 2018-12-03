#!/usr/bin/env ruby

# Part 1: checksum

# IDs that contain exactly two occurrences of any letter.
count_twos = 0

# IDs that contain exactly three occurrences of any letter.
count_threes = 0

# Array representation of the input file.

input = []

ARGF.each do |line|
  input << line
end

# Hash representation of the input file (each line is a "box ID"):
# Keys are the box IDs. Values are hashes where each character in the
# ID is a key, with its value being the count of times that character
# appears in the box ID.

ids = {}

input.each do |line|
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

# Part 2: find IDs which which differ by exactly one character at the
# same position in both strings

# Remove each column and look for the duplicates.

common_letters = String.new
dup_1_index = -1
dup_2_index = -1
differing_letter_index = -1

(0..input[0].chomp.length - 1).each do |col|
  test_array = []

  input.each do |id|
    id_a = id.chars
    id_a.delete_at(col)
    test_array << id_a.join
  end

  counts = Hash.new(0)
  search_result = test_array.find { |id| (counts[id] += 1) == 2 }
  if not search_result.nil? then
    common_letters = search_result
    dup_1_index = test_array.index(search_result)
    dup_2_index = test_array.rindex(search_result)
    differing_letter_index = col
    break
  end
end

puts "the box IDs:
#{input[dup_1_index].chomp}
#{input[dup_2_index].chomp}"

puts "the common letters: #{common_letters}"

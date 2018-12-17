#!/usr/bin/env ruby

# Day 3, Part 1

# Determine how many square inches of fabric are within two or more
# claims.

# Data structure for input file:
# Array of hashes:
#  { 'x' => x, 'y' => y, 'width' => w, 'height' => h }

require 'matrix'

# Matrices from the matrix module are immutable, so define a function
# to be able to change elements.
# https://stackoverflow.com/a/12683864/124703
class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

input = []

ARGF.each do |line|
  claim = {
    'id'     => line.split()[0].split('#')[1].to_i,
    'x'      => line.split()[2].split(',')[0].to_i,
    'y'      => line.split()[2].split(',')[1].to_i,
    'width'  => line.split()[3].split('x')[0].to_i,
    'height' => line.split()[3].split('x')[1].to_i,
  }

  input << claim
end

# Matrix mapping out the square inches of fabric. Values are counts of
# claims to that square inch.

# Would be better to determine the dimensions of the fabric, but ain't
# got time to figure that out right now. Just created a matrix that is
# obviously large enough and then experimentally found its minimum
# size.

fabric = Matrix.zero(1009)

input.each do |claim|
  (0 .. claim['height'] - 1).each do |row|
    (0 .. claim['width'] - 1).each do |col|
      fabric[claim['y'] + row, claim['x'] + col] += 1
    end
  end
end

# The count of square inches within two or more claims.
count = 0

fabric.each do |square_inch|
  count += 1 if square_inch > 1
end

puts count

# Day 3, Part 2: Identify the claim which has no overlaps.

non_overlapping_claim_id = 0

input.each do |claim|
  overlapping = false

  (0 .. claim['height'] - 1).each do |row|
    (0 .. claim['width'] - 1).each do |col|
      overlapping = true if fabric[claim['y'] + row, claim['x'] + col] > 1
    end
  end

  non_overlapping_claim_id = claim['id']
  break if overlapping == false
end

puts non_overlapping_claim_id

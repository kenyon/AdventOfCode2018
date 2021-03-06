#!/usr/bin/env ruby

# Day 4, Part 1

# Determine the guard that has the most minutes of sleep. Determine
# the minute of the midnight hour the guard spends asleep the most.
# Output the product of the guard ID and the minute.

require 'date'

class Guard
  include Comparable

  attr_reader(:sleeping_minutes, :slept_minutes)

  def <=>(other)
    @sleeping_minutes <=> other.sleeping_minutes
  end

  def initialize()
    @sleeping_minutes = 0

    @slept_minutes = Array.new()
    (0..59).each do |i|
      @slept_minutes[i] = 0
    end

    @fell_asleep = DateTime.new()
    @woke_up = DateTime.new()
  end

  def falls_asleep(timestamp)
    @fell_asleep = timestamp
  end

  def wakes_up(timestamp)
    @woke_up = timestamp

    @sleeping_minutes += ((@woke_up - @fell_asleep) * 60 * 24).to_i

    (@fell_asleep.strftime('%M').to_i .. @woke_up.strftime('%M').to_i - 1).each do |i|
      @slept_minutes[i] += 1
    end
  end
end

guards = Hash.new()
guard_id = nil

ARGF.each do |line|
  case line
  when /begins shift/
    guard_id = line.split('#')[1].to_i
    guards[guard_id] = Guard.new() if guards[guard_id].nil?
  when /falls asleep/
    guards[guard_id].falls_asleep(DateTime.parse(line))
  when /wakes up/
    guards[guard_id].wakes_up(DateTime.parse(line))
  else
    abort("unknown line: #{line}")
  end
end

puts guards.key(guards.values.max) \
     * guards.values.max.slept_minutes.index(guards.values.max.slept_minutes.max)

# Day 4, Part 2: which guard is most frequently asleep on the same minute?
# Output the product of the guard ID and the minute.

# Hash of guard IDs to the minute of the hour that guard slept the
# most, and how many times they slept on that minute.
most_slept_minutes = Hash.new()

guards.each do |id, guard|
  most_slept_minutes[id] = { 'minute' => guard.slept_minutes.index(guard.slept_minutes.max),
                             'count' => guard.slept_minutes.max,
                           }
end

max = { 'id' => 0, 'minute' => 0, 'count' => 0 }

most_slept_minutes.each do |id, v|
  max = v['count'] > max['count'] \
        ? {'id' => id, 'minute' => v['minute'], 'count' => v['count'] }
        : max
end

puts max['id'] * max['minute']

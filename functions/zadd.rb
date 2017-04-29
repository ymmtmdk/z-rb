#! /usr/bin/ruby

require 'optparse'

opts = ARGV.getopts("", "pwd:", "now:")
pwd = opts["pwd"]
now = opts["now"].to_i

result = {}

ARGF.each_line do |line|
  path, rank, time = line.chomp.split(/\|/)
  rank = rank.to_f
  time = time.to_i

  result[path] = {rank: rank, time: time} if rank >= 1
end

if result[pwd]
  result[pwd][:rank] += 1
  result[pwd][:time] = now
else
  result[pwd] = {rank: 1, time: now}
end

rank_total = result.inject(0){|r, a| r+a[1][:rank]}
result.each do |path, h|
  rank = h[:rank]
  rank *= 0.9 if rank_total > 1000
  puts "#{path}|#{rank}|#{h[:time]}"
end

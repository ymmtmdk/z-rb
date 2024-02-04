#! /usr/bin/env crystal

pwd = ARGV[0]
now = ARGV[1].to_i

result = {} of String => {rank: Float64, time: Int32}

File.each_line(ARGV[2]) do |line|
  path, rank, time = line.chomp.split('|')
  rank = rank.to_f
  time = time.to_i

  result[path] = {rank: rank, time: time} if rank >= 1
end

if result[pwd]?
  result[pwd] = {rank: result[pwd][:rank] + 1.0, time: now}
else
  result[pwd] = {rank: 1.0, time: now}
end

rank_total = result.reduce(0) { |r, a| r + a[1][:rank] }
result.each do |path, h|
  rank = h[:rank]
  rank *= 0.9 if rank_total > 1000
  puts "#{path}|#{rank}|#{h[:time]}"
end


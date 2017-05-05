require "option_parser"

pwd = ""
now = 0

OptionParser.parse! do |parser|
  parser.on("-p PWD", "--pwd=PWD", "pwd") { |p| pwd = p }
  parser.on("-n NOW", "--now=NOW", "now") { |n| now = n.to_i }
end

result = {} of String => Hash(Symbol, Int32|Float64)

ARGF.each_line do |line|
  path, rank, time = line.chomp.split(/\|/)
  rank = rank.to_f
  time = time.to_i

  result[path] = {:rank => rank, :time => time} if rank >= 1
end

if result[pwd]?
  result[pwd][:rank] += 1
  result[pwd][:time] = now
else
  result[pwd] = {:rank => 1.0, :time => now}
end

rank_total = result.reduce(0){|r, a| r+a[1][:rank]}
result.each do |path, h|
  rank = h[:rank]
  rank *= 0.9 if rank_total > 1000
  puts "#{path}|#{rank}|#{h[:time]}"
end

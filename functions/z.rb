#! /usr/bin/ruby

def frecent(rank, time, now)
  dx = now - time
  return rank*4 if dx < 3600
  return rank*2 if dx < 86400
  return rank/2 if dx < 604800
  rank/4
end

STDERR.puts(3)
keyword = ARGV[0]
now = ARGV[1].to_i

candidates  = {}

IO.readlines(ARGV[2]).each do |line|
  path, rank, time = *line.chomp.split(/\|/)
  rank = rank.to_f
  time = time.to_i
  next unless File.directory?(path)

  if path.downcase =~ /#{keyword.downcase}/
    candidates[path] = frecent(rank, time, now)
  end
end

exit if candidates.empty?

puts candidates.max_by{|path, scr| scr}[0]


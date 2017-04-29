#! /usr/bin/ruby

require 'optparse'

def frecent(rank, time, now)
  dx = now - time
  return rank*4 if dx < 3600
  return rank*2 if dx < 86400
  return rank/2 if dx < 604800
  rank/4
end

def score(type, rank, time, now)
  case type
  when "rank"
    rank
  when "recent"
    time
  else
    frecent(rank, time, now)
  end
end

opts = ARGV.getopts("", "query:", "option:", "type:", "now:")
keywords = opts["query"].split(/\s+/)
option = opts["option"]
type = opts["type"]
now = opts["now"].to_i

candidates  = {}

ARGF.each_line do |line|
  path, rank, time = *line.chomp.split(/\|/)
  rank = rank.to_f
  time = time.to_i
  next unless File.directory?(path)

  if keywords.all?{|word| path.downcase =~ /#{word.downcase}/}
    candidates[path] = score(type, rank, time, now)
  end
end

exit if candidates.empty?

if option == "list"
  candidates.each do |path, scr|
    printf "%-10s %s;\n", scr, path
  end
else
  puts candidates.max_by{|path, scr| scr}[0]
end


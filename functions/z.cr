#! /usr/bin/ruby

# require "optparse"

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
    time.to_f
  else
    frecent(rank, time, now)
  end
end

require "option_parser"

now = 0
keyword = ""
option = ""
type = ""

OptionParser.parse! do |parser|
  parser.on("-n NOW", "--now", "now") { |n| now = n.to_i }
  parser.on("-q QURRY", "--query", "query") { |q| keyword = q }
  parser.on("-t TYPE", "--type", "type") { |t| type = t }
  parser.on("-o OPTION", "--option", "option") { |o| option = o }
end

candidates  = {} of String => Float64

ARGF.each_line do |line|
  path, rank, time = line.chomp.split(/\|/)
  rank = rank.to_f
  time = time.to_i
  next unless File.directory?(path)

  if [keyword].all?{|word| path.downcase =~ /#{word.downcase}/}
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


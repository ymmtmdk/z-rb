def frecent(rank : Float64, time : Int64, now : Int64) : Float64
  dx = now - time
  if dx < 3600
    return rank * 4.0
  elsif dx < 86400
    return rank * 2.0
  elsif dx < 604800
    return rank / 2.0
  end
  rank / 4.0
end

keyword = ARGV[0]
now = ARGV[1].to_i

candidates = Hash(String, Float64).new

File.each_line(ARGV[2]) do |line|
  path, rank, time = line.chomp.split("|")
  rank = rank.to_f
  time = time.to_i
  next unless Dir.exists?(path)

  if path.downcase =~ /#{keyword.downcase}/
    candidates[path] = frecent(rank, time, now)
  end
end

exit if candidates.empty?

puts candidates.max_by { |path, scr| scr }[0]


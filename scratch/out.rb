require 'pry'
# print "This is a test"
# STDOUT.flush
# sleep 1
# print "\r"
# STDOUT.flush
# print "this is another test\n"
# STDOUT.flush
# puts "Done!"


def terminal_width
  @terminal_width ||= (ENV["COLUMNS"] || 80).to_i
end

def terminal_height
  @terminal_height ||= (ENV["COLUMNS"] || 20).to_i
end

def print_line(line, opts={})
  padding = opts.fetch(:padding, terminal_width)
  out = opts.fetch(:out, STDOUT)
  print "\r" unless opts[:skip_r]
  print line.strip.ljust(padding)
  out.flush
end

def lines
  @lines ||= {}
end

def sorted_lines
  output = Hash.new("")
  lines.sort {|(key_a, value_a), (key_b, value_b)| key_a <=> key_b}.each do |(key, value)|
    output[key] = value
  end
  output
end

def print_on_line(n, line, opts={})
  hash = sorted_lines
  last, value = sorted_lines.max
  count = last - n
  out = opts.fetch(:out, STDOUT)

  count.times {out.print "\r"; out.flush} if count > 0
  
  (n..last).each do |i|
    lines[i] = line if n == i
    print_line(hash[i], opts.merge(:skip_r => true))
    out.print("\n")
  end
  
end

lines[2] = "two"
lines[1] = "one"
lines[3] = "three"
lines[4] = "four"

print_on_line(1, "1")
print_on_line(2, "2")

# if __FILE__ == $0
#   puts "sdfasdfasdf", ENV["COLUMNS"].nil?, $stdout.methods.sort - Object.methods
# end


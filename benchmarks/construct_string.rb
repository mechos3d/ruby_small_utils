require 'benchmark/ips'

def first
  arr = []
  1000.times.each do |x|
    arr << 'a'
  end
  arr.join('')
end

def second
  s = ''
  1000.times.each do |x|
    s += 'a'
  end
  s
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# Warming up --------------------------------------
#                first   698.000  i/100ms
#               second   295.000  i/100ms
# Calculating -------------------------------------
#                first      7.012k (± 3.3%) i/s -     35.598k in   5.082354s
#               second      3.050k (± 3.5%) i/s -     15.340k in   5.036435s
#
# Comparison:
#                first:     7012.1 i/s
#               second:     3049.5 i/s - 2.30x  slower

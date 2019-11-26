require 'benchmark/ips'

A = 5

def first
  A == 1 || A == 2 || A == 3 || A == 4
end

def second
  [1,2,3,4].include?(A)
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# with 2 element array:
# Warming up --------------------------------------
#                first   265.168k i/100ms
#               second   237.927k i/100ms
# Calculating -------------------------------------
#                first      7.774M (± 5.2%) i/s -     38.980M in   5.028811s
#               second      6.019M (± 5.1%) i/s -     30.217M in   5.033675s
#
# Comparison:
#                first:  7774356.0 i/s
#               second:  6019406.6 i/s - 1.29x  slower

## -----------------------------------------------------------------
## -----------------------------------------------------------------

# with 4 element array:
# Warming up --------------------------------------
#                first   237.390k i/100ms
#               second   163.828k i/100ms
# Calculating -------------------------------------
#                first      5.757M (± 4.3%) i/s -     28.962M in   5.040294s
#               second      2.778M (± 5.0%) i/s -     13.925M in   5.026352s
#
# Comparison:
#                first:  5757109.2 i/s
#               second:  2777855.1 i/s - 2.07x  slower

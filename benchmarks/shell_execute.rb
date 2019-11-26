require 'benchmark/ips'

def first
 `true`
end

def second
  a = true
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# Warming up --------------------------------------
#                first    46.000  i/100ms
#               second   271.068k i/100ms
# Calculating -------------------------------------
#                first    444.063  (± 4.3%) i/s -      2.254k in   5.085390s
#               second      9.404M (± 5.8%) i/s -     46.895M in   5.005498s
#
# Comparison:
#               second:  9404438.6 i/s
#                first:      444.1 i/s - 21178.17x  slower

require 'benchmark/ips'

A = 13047304320430

def first
  A * 32
end

def second
  A << 5
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# Calculating -------------------------------------
#                first      8.982M (± 1.7%) i/s -     45.160M in   5.029396s
#               second      7.847M (± 3.0%) i/s -     39.364M in   5.021095s
#
# Comparison:
#                first:  8981826.4 i/s
#               second:  7847245.6 i/s - 1.14x  slower

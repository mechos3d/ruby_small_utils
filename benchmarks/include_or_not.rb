require 'benchmark/ips'

A = 5
ARRAY = [1,2,3,4]

def first
  A == 1 || A == 2 || A == 3 || A == 4
end

def second
  [1,2,3,4].include?(A)
end

def third
  ARRAY.include?(A)
end

Benchmark.ips do |x|
  x.report('first')  { first }
  x.report('second') { second }
  x.report('third')  { third }
  x.compare!
end

# Calculating -------------------------------------
#                first      5.858M (± 5.1%) i/s -     29.291M in   5.015105s
#               second      2.806M (± 4.5%) i/s -     14.056M in   5.019919s
#                third      6.635M (± 5.1%) i/s -     33.277M in   5.029327s
#
# Comparison:
#                third:  6635269.9 i/s
#                first:  5857962.5 i/s - 1.13x  slower
#               second:  2806417.5 i/s - 2.36x  slower
#

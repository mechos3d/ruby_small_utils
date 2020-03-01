require 'benchmark/ips'
require 'time'

def first
  a = 'fef3r3r3r3reflsdmodjnphefojfpojwemf;wnfojeojfeojefoejf3r34--0rojds;fojflsdnfohr0urjofdl'
end

def second
  a = eval('"fef3r3r3r3reflsdmodjnphefojfpojwemf;wnfojeojfeojefoejf3r34--0rojds;fojflsdnfohr0urjofdl"')
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# Calculating -------------------------------------
#                first      7.695M (± 4.1%) i/s -     38.642M in   5.032719s
#               second    150.501k (± 2.7%) i/s -    758.006k in   5.040212s
#
# Comparison:
#                first:  7694871.5 i/s
#               second:   150500.7 i/s - 51.13x  slower

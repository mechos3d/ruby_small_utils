require 'benchmark/ips'
require 'time'

def first
  Time.parse('2018-05-15 22:00 +3')
end

def second
  Time.new(2018, 5, 15, 22, 0, 0 , '+03:00')
end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

# Calculating -------------------------------------
#                first     31.846k (± 3.4%) i/s -    159.222k in   5.005662s
#               second    800.269k (± 4.5%) i/s -      4.013M in   5.025897s
#
# Comparison:
#               second:   800269.3 i/s
#                first:    31846.4 i/s - 25.13x  slower

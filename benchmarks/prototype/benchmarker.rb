require 'benchmark/ips'

def first

end

def second

end

Benchmark.ips do |x|
  x.report('first') { first }
  x.report('second') { second }
  x.compare!
end

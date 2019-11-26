require 'benchmark/ips'
require 'erb'
require 'erubis'

ARR = ['fgfgaergar', nil, 'affejfejef;ejmfo3j3i-r02fmdnfajdf', nil, 'feff3=23r=23r-gvjeovvavnfv']
TEMPLATE = ERB.new("fgfgaergar<%=a%>affejfejef;ejmfo3j3i-r02fmdnfajdf<%=b%>feff3=23r=23r-gvjeovvavnfv")
ERUBIS_TEMPLATE = Erubis::Eruby.new("fgfgaergar<%=a%>affejfejef;ejmfo3j3i-r02fmdnfajdf<%=b%>feff3=23r=23r-gvjeovvavnfv")

def array_join
  a = '0u403u4034'
  b = 'fe23r23r20u403u4034'

  ARR[1] = a
  ARR[3] = b
  ARR.join('')
end

def with_erb
  a = '0u403u4034'
  b = 'fe23r23r20u403u4034'

  TEMPLATE.result(binding)
end

def with_erubis
  a = '0u403u4034'
  b = 'fe23r23r20u403u4034'

  ERUBIS_TEMPLATE.result(binding)
end

def interpolation
  a = '0u403u4034'
  b = 'fe23r23r20u403u4034'

  str = "fgfgaergar#{a}affejfejef;ejmfo3j3i-r02fmdnfajdf#{b}feff3=23r=23r-gvjeovvavnfv"
end

def with_gsub
  a = '0u403u4034'
  b = 'fe23r23r20u403u4034'

  str = "fgfgaergar#{a}affejfejef;ejmfo3j3i-r02fmdnfajdf#{b}feff3=23r=23r-gvjeovvavnfv"
    .gsub(/#\{a\}/, a)
    .gsub(/#\{b\}/, b)
end

Benchmark.ips do |x|
  x.report('array_join')    { array_join }
  x.report('with_erb')      { with_erb }
  x.report('with_erubis')   { with_erubis }
  x.report('interpolation') { interpolation }
  x.report('with_gsub')     { with_gsub }
  x.compare!
end

# Warming up --------------------------------------
#           array_join    91.715k i/100ms
#             with_erb     4.845k i/100ms
#          with_erubis     5.188k i/100ms
#        interpolation   118.873k i/100ms
#            with_gsub    55.455k i/100ms
# Calculating -------------------------------------
#           array_join      1.212M (± 5.9%) i/s -      6.053M in   5.020028s
#             with_erb     49.615k (± 3.2%) i/s -    251.940k in   5.083494s
#          with_erubis     53.373k (± 3.1%) i/s -    269.776k in   5.059645s
#        interpolation      1.767M (± 3.3%) i/s -      8.915M in   5.050706s
#            with_gsub    650.663k (± 3.4%) i/s -      3.272M in   5.034406s
#
# Comparison:
#        interpolation:  1767272.1 i/s
#           array_join:  1212041.4 i/s - 1.46x  slower
#            with_gsub:   650663.3 i/s - 2.72x  slower
#          with_erubis:    53372.7 i/s - 33.11x  slower
#             with_erb:    49615.1 i/s - 35.62x  slower

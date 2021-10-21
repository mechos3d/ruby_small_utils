# frozen_string_literal: true

require 'benchmark/ips'
require 'time'

REGEXP = /\s/
DELETE_CHARS = " \t\r\n"

STRING = "Lorem ipsum dolor sit amet, \tconsectetur\n adipiscing elit, sed do eiusmod\n\n "\
         "tempor incididunt ut labore et dolore \nmagna aliqua."

def delete
  STRING.delete(DELETE_CHARS)
end

def gsub
  STRING.gsub(REGEXP)
end

Benchmark.ips do |x|
  x.report('delete') { delete }
  x.report('gsub') { gsub }
  x.compare!
end

## -----------------------------------------------------------------
# Calculating -------------------------------------
#               delete      1.271M (± 4.5%) i/s -      6.432M in   5.069712s
#                 gsub      2.556M (± 5.3%) i/s -     12.758M in   5.006377s
#
# Comparison:
#                 gsub:  2555841.3 i/s
#               delete:  1271282.3 i/s - 2.01x  slower

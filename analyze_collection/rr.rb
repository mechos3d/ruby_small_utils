require 'collection_analyzer'

arr = [
  { a: 1, b: '2', c: 33, d: { d1: 'd1', d2: 'd2' } },
  { a: 2, b: '1', c: nil, d: { d1: nil, d2: 'd2' } },
  { a: 3, b: '', c: 33, d: { d1: 'd1', d2: '' } }
]

# arr = [
# { a: 1, b: '2' , c: 33 },
# { a: 2, b: '1' , c: nil },
# { a: 3, b: '' , c: 33 },
# ]

pp CollectionAnalyzer.new.call(arr, traverse_hashes: true)
# pp CollectionAnalyzer.new.call(arr)

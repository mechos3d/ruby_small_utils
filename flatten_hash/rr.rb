class FlattenHash
  def call(hash)
    traverse(hash, [], {})
  end

  # NOTE: returns array
  def traverse(hash, parent_keys, result)
    hash.each do |key, val|
      if val.is_a?(Hash)
        result.merge!( traverse(val, parent_keys + [key], {}))
      else
        result.merge!({ parent_keys + [key] => val })
      end
    end
    result
  end
end

hash = { a1: 1, a2: { b1: 2, b2: 3 } }
pp FlattenHash.new.call(hash)
## => [[:a1], [:a2, :b1], [:a2, :b2]]

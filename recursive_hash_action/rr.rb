class A
  def traverse(hash, &block)
    hash.each do |k, v|
      if v.is_a?(Hash)
        traverse(v, &block)
      elsif v.is_a?(Enumerable)
        v.each { |el| traverse(el, &block)  }
      else
        hash[k] = yield k, v
      end
    end
  end
end

hh = {
  a: { a1: 'a1', a2: nil},
  b: nil,
  c: 'c',
  d: [ { d1: nil, d2: 'd2' } ]
}

pp A.new.traverse(hh) { |_k, v| v.nil? ? '' : v }

class ArrayValueSubstract
  def call(arr, sum)
    return [] if arr.empty?
    head = arr[0]
    tail = arr[1..-1]
    new_sum = non_negative(sum - head)
    new_head = non_negative(head - sum)
    [new_head] + call(tail, new_sum)
  end

  def non_negative(x)
    x > 0 ? x : 0
  end
end

# pp ArrayValueSubstract.new.call([3,2,2], 6)
# => [0, 0, 1]

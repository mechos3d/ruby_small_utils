# TODO:  count of elements, for which given block returns true.
# TODO:  also return the anomalaous elements, not just counts. ( maybe in other method call)
# TODO:  hashes can have other hashes as values (need to flatten the hash first)

class A
  def call(arr)

    keys = arr.first.keys
    result = {}

    keys.each do |key|
      values = arr.map { |x| x[key] }
      result[key] = {
        classes: values.map { |x| x.class.to_s }.uniq,
        min: values.reject(&:nil?).min,
        max: values.reject(&:nil?).max,
        avg: average(values),
        median: median(values),
        null_count: values.count(&:nil?),
        empty_or_zero_count: values.count { |x| !x.nil? && (x == 0 || ( x.is_a?(String) && x.strip.empty?)) },
        duplicates: values.group_by { |x| x }.select { |k, v| v.count > 1 }.map { |k, v| [k, v.count] }.to_h
        }
    end
    result
  end

  private

  def average(values)
    arr = values.reject(&:nil?)
    if arr.all? { |x| x.is_a?(Numeric) }
      (arr.sum).to_f / arr.count
    else
      'N/A'
    end
  end

  def median(values)
    arr = values.reject(&:nil?)
    if arr.all? { |x| x.is_a?(Numeric) }
      arr.sort[arr.size / 2]
    else
      'N/A'
    end
  end

end

arr = [
  { a: 1, b: '2' , c: 33 },
  { a: 2, b: '1' , c: nil },
  { a: 3, b: '' , c: 33 },
]

pp A.new.call(arr)

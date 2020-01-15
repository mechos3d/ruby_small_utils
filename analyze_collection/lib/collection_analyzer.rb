# frozen_string_literal: true

# TODO: для "проблемных" событий - хорошо бы иметь возможность возвращать id этих элементов.
#      ( что может являться таким id - задает юзер )
#
# TODO: придумать, что делать с кейсами, когда одно из значений - это массив хэшей, о которых мы тоже что-то хотим узрнать..
# [
#   { foo: [ { bar: 1 },{ bar: 2 } ] },
#   { foo: [ { bar: 3 },{ bar: 5 } ] },
# ]
#
# TODO: count of elements, for which given block returns true.

# TODO: also return the anomalaous elements, not just counts.
#       ( maybe in other method call)

# TODO: ipnut validations with good error-messaages
class CollectionAnalyzer
  def call(arr, traverse_hashes: false)
    validate_input(arr)
    @traverse_hashes = traverse_hashes

    element = arr.first
    # NOTE: element MUST be a Hash
    result = {}

    element.each do |key, value|
      result[key] = process_element([key], value, arr)
    end
    result
  end

  private

  attr_reader :traverse_hashes

  def validate_input(arr)
    return if arr.all? { |x| x.is_a?(Hash) }
    classes = arr.map { |x| x.class.to_s }.uniq
    raise(
      'All elements of the collection must be Hashes, '\
      "but given collection includes: #{classes}"
    )
  end

  def process_element(keys_arr, value, arr)
    if value.is_a?(Hash) && traverse_hashes
      value.each_with_object({}) do |(inner_key, inner_value), acc|
        acc[inner_key] =
          process_element(keys_arr + [inner_key], inner_value, arr)
      end
    else
      perform_calculation(arr, keys_arr)
    end
  end

  def perform_calculation(arr, keys)
    values = arr.map { |x| x.dig(*keys) }

    {
      classes: values.map { |x| x.class.to_s }.uniq,
      min: values.reject(&:nil?).select { |x| x.is_a?(Numeric) }.min,
      max: values.reject(&:nil?).select { |x| x.is_a?(Numeric) }.max,
      avg: average(values),
      median: median(values),
      null_count: values.count(&:nil?),
      empty_or_zero_count: empty_or_zero_count(values),
      duplicates: duplicates(values)
    }
  end

  def duplicates(values)
    values.group_by { |x| x }
          .select { |_k, v| v.count > 1 }
          .map { |k, v| [k, v.count] }
          .to_h
  end

  def empty_or_zero_count(values)
    values.count do |x|
      !x.nil? && (
        (x.is_a?(String) && x.strip.empty?) ||
        (x.respond_to?(:empty?) && x.empty?) ||
        (x.respond_to?(:zero?) && x.zero?)
      )
    end
  end

  def average(values)
    arr = values.reject(&:nil?).select { |x| x.is_a?(Numeric) }
    res = arr.sum.to_f / arr.count
    res.nan? ? nil : res
  end

  def median(values)
    arr = values.reject(&:nil?).select { |x| x.is_a?(Numeric) }
    arr.sort[arr.size / 2]
  end
end

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
pp CollectionAnalyzer.new.call(arr)

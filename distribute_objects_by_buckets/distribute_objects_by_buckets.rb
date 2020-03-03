require 'ostruct'

# TODO: accept a block instead of ugly 'method:, arguments:' stuff
class Divider
  # IN: TODO: описать
  # OUT: TODO: описать
  def call(objects:, dividers:, method:, arguments: nil)
    objects = objects.sort_by { |x| x.public_send(method, *arguments) }
    results = {}

    obj_start_index = 0
    dividers.each_with_index do |d, i|
      next if i == 0
      p_start = dividers[i - 1]
      p_end = d

      results[i] = { start: p_start, end: p_end, objects: [] }

      arr = objects[obj_start_index..-1]
      break unless arr && !arr.empty?

      arr.each do |obj|
        break if obj.public_send(method, *arguments) > p_end

        if obj.public_send(method, *arguments) < p_end
          results[i][:objects] << obj
          obj_start_index += 1
        end
      end
    end
    results.values
  end
end

objects = [
  { id: 1, a: 1.0 },
  { id: 2, a: 1.2 },
  { id: 3, a: 1.5 },
  { id: 4, a: 2.0 },
  { id: 5, a: 4.0 },
  { id: 5, a: 7.0 }
]

# objects = [
  # OpenStruct.new(created_at: 1.0),
  # OpenStruct.new(created_at: 1.2),
  # OpenStruct.new(created_at: 1.5),
  # OpenStruct.new(created_at: 2.0),
  # OpenStruct.new(created_at: 4.0),
# ]

dividers = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]

# for Hashes:
res = Divider.new.call(objects: objects, dividers: dividers, method: :[], arguments: [:a])
puts res

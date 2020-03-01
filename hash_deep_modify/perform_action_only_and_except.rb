module MechosUtils
  module HashDeepModify
    module Shared

      # hash = { a1: 1, a2: { b1: 2, b2: 3 } }
      # pp all_possible_key_paths(hash)
      # => [[:a1], [:a2, :b1], [:a2, :b2]]
      def self.all_possible_key_paths(hash)
        hash.each do |key, val|
          if val.is_a?(Hash)
            result += traverse(val, parents + [key], [])
          else
            result << parents + [key]
          end
        end
        result
      end
    end

    # original = { a1: 0, a2: { b1: [0, 0, 0], b2: 0 }, a3: 0 }
    # only_keys = { a1: 1, a2: { b1: 1 } }
    #
    # pp OnlyKeys.new.call(original, only_keys) { |x| x + 1 }
    ## => {:a1=>1, :a2=>{:b1=>[1, 1, 1], :b2=>0}, :a3=>0}
    class OnlyKeys
      def call(original, selected_positions)
        keys_paths = Shared.all_possible_key_paths(selected_positions)

        result = original.dup # TODO: really need 'deep_dup' here

        keys_paths.each do |arr|
          node = result
          arr.each_with_index do |el, i|
            if i == (arr.size - 1)
              if node[el].is_a?(Enumerable)
                node[el] = node[el].map { |x| yield(x) }
              else
                node[el] = yield(node[el])
              end
            else
              node = node[el]
            end
          end
        end
        result
      end
    end

    # original = { a1: 0, a2: { b1: [0, 0, 0], b2: 0 }, a3: 0 }
    # except_keys = { a1: 1, a2: { b2: 1 } }

    # pp ExceptKeys.new.call(original, except_keys) { |x| x + 1 }
    # => {:a1=>0, :a2=>{:b1=>[1, 1, 1], :b2=>0}, :a3=>1}
    class ExceptKeys
      def call(original, excepts = nil, &block)
        result = original.dup # TODO: really need deep_dup - not to mutate the 'original' hash
        keys_paths = excepts ?  Shared.all_possible_key_paths(excepts) : []

        traverse(result, keys_paths, [], &block)
      end

      def traverse(hash, keys_paths, parents, &block)
        hash.each do |key, val|
          if val.is_a?(Hash)
            traverse(val, keys_paths, parents + [key], &block)
          else
            current_path = parents + [key]
            next if keys_paths.include?(current_path)

            if hash[key].is_a?(Enumerable)
              hash[key] = hash[key].map { |x|  yield(x) }
            else
              hash[key] = yield(val)
            end
          end
        end
        hash
      end
    end
  end
end

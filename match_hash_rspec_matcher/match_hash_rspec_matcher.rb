require 'rspec/expectations'

# TODO: It's a work-in-progress. This matcher will not show the diff when expected and actual differ.

# DOC:
# Consider having two hashes:
# foo = { a: [1, 2, 3] }
# bar = { a: [2, 3, 1] }
# the standard Rspec hash equality check returns false for these because
# the arrays inside are sorted differently.
# Rspec has 'match_array' for checking array equality in such cases.
# But there is no such thing when the array is a valued of a hash.
# This matcher is just for that !

# CustomMatchers::MatchHash.new.call(foo, bar) should return true for these.

module CustomMatchers
  class MatchHash

    def call(expected, actual)
      raise 'Matcher can be used only for Hash objects' unless expected.is_a?(Hash)
      return false unless actual.is_a?(Hash)

      traverse(expected, [], actual)
    end

    private

    def traverse(hash, parent_keys, actual)
      hash.each do |key, value|
        keys_chain = parent_keys + [key]
        if value.is_a?(Hash)
          res = traverse(value, keys_chain, actual)
          return false unless res
        else
          actual_value = actual.dig(*keys_chain)
          return false unless actual_value
          if value.is_a?(Array) && actual_value.is_a?(Array)
            return false if value.sort != actual_value.sort
          else
            return false if value != actual_value
          end
        end
      end
      true
    end
  end
end

RSpec::Matchers.define :match_hash do |expected|
  match do |actual|
    CustomMatchers::MatchHash.new.call(expected, actual)
  end
end

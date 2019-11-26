require 'rspec/expectations'

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

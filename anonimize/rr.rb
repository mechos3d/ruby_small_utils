require 'pry'

# TODO: в potok-legacy есть более продвинутый вариант - с кэшированием.
# TODO: лушче оперировать сразу буквами, а не ordinal'ами

class Anonimizer
  DIGITS_ORDINALS = (48..57).freeze

  UPCASE_CYRILLIC_ORDINALS  = (1040..1071).freeze
  LOWCASE_CYRILLIC_ORDINALS = (1072..1103).freeze

  UPCASE_ENGLISH_ORDINALS  = (65..90).freeze
  LOWCASE_ENGLISH_ORDINALS = (97..122).freeze

  def initialize
    @prng = Random.new(Random.new_seed)
  end

  def call(str)
    str.each_char.map { |char| process_char(char) }.join('')
  end

  private

  def process_char(str)
    ord = str.ord
    range = if DIGITS_ORDINALS.include?(ord)
      DIGITS_ORDINALS
    elsif UPCASE_CYRILLIC_ORDINALS.include?(ord)
      UPCASE_CYRILLIC_ORDINALS
    elsif LOWCASE_CYRILLIC_ORDINALS.include?(ord)
      LOWCASE_CYRILLIC_ORDINALS
    elsif UPCASE_ENGLISH_ORDINALS.include?(ord)
      UPCASE_ENGLISH_ORDINALS
    elsif LOWCASE_ENGLISH_ORDINALS.include?(ord)
      LOWCASE_ENGLISH_ORDINALS
    end
    if range
      [@prng.rand(range)].pack('U*')
    else
      str
    end
  end
end

puts Anonimizer.new.call('Абырвалг ОппА fgfateeeew Zummfafa 12328. !-+===')

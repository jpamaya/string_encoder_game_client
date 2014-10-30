class Decoder

  def decoder_1(word)
    word
  end

  def decoder_2(word)
    word.reverse
  end

  def decoder_3(word)
    word.tr('43106','aeiou')
  end

  def decoder_4(word)
    rotations = word.size - 2
    word.split('').rotate(rotations).join
  end

  def decoder_5(word)
    first_word = word.split('')
    second_word = word.upcase.split('')
    new_word = ''
    first_word.each_with_index {|item, index|
      new_word += first_word[index] if first_word[index] == second_word[index]
    }
    new_word_number_decoded = decoder_3(new_word)
    new_word_number_decoded.downcase
  end
end

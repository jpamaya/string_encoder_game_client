class Decoder

  # Noop
  def self.decoder_1(word)
    word
  end

  # Reverse
  def self.decoder_2(word)
    word.reverse
  end

  # Vowels to numbers
  def self.decoder_3(word)
    word.tr('43106','aeiou')
  end

  # Rotate
  def self.decoder_4(word)
    word.split('').rotate(-3).join
  end

  # Vowel obfuscate
  def self.decoder_5(word)
    vowels = %w{a e i o u}
    word.split('').map{| char| (char == '*') ? vowels.sample : char }.join
  end

  # Caesar algorithm
  def self.decoder_6(word)
    alphabet = ('a'..'z').to_a
    rotated_alphabet = alphabet.rotate(-5)
    word.split('').map{|char| rotated_alphabet[alphabet.index(char)] }.join
  end

  # Simple random obfuscate
  def self.decoder_7(word)
    new_word = word.split('').map {|char| (char.upcase == char) ? char : '' }.join
    decoder_3(new_word).downcase
  end
end

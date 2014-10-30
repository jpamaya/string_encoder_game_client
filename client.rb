require 'net/http'
require './decoder'

TOTAL_CHALLENGES = 6
SERVER_URI = 'http://localhost:4567'
CHALLENGE_URI = "#{SERVER_URI}/word"
ANSWER_URI = "#{SERVER_URI}/answer?answer="


def self.getChallenge
  uri = URI(CHALLENGE_URI)
  challenge_word = Net::HTTP.get(uri).strip
  puts "\nChallenge word: #{challenge_word}"
  challenge_word
end

def self.resolveChallenge(challenge_number, challenge_word)
  decoded_word = Decoder.send("decoder_#{challenge_number}", challenge_word)
  puts "\nDecoded word: #{decoded_word}"
  decoded_word
end

def self.answerChallenge(answer)
  uri = URI("#{ANSWER_URI}#{answer}")
  response = Net::HTTP.get(uri)
  if response.include?('OK')
    puts response
    challenge_success = true
  else
    puts response
    challenge_success = false
  end
  challenge_success
end

# Initialize challenges
challenge_number = 1
challenge_success = false

# Main loop to pass through all challenges
loop do
  challenge_word = getChallenge
  answer = resolveChallenge(challenge_number, challenge_word)
  challenge_success = answerChallenge(answer)
  # If success go to the next challenge
  challenge_number += 1 if challenge_success
  # Exit if all challenges are completed
  break if ( (challenge_number == TOTAL_CHALLENGES + 1) && challenge_success)
end

puts "\nCHALLENGE COMPLETED!!!"

require 'net/http'
require 'json'
require './decoder'

@server_uri = 'http://localhost:4567'
@decoder_algorithm_index = 1
@challenge_uri = '/'
@challenge_word = ''
@decoder = Decoder.new
@next_challenge = true

def self.getChallenge
  uri = URI("#{@server_uri}#{@challenge_uri}word")
  @challenge_word = Net::HTTP.get(uri).strip
  puts "\nChallenge word: #{@challenge_word}"
end

def self.resolveChallenge
  decoded_word = @decoder.send("decoder_#{@decoder_algorithm_index}", @challenge_word)
  puts "\nDecoded word: #{decoded_word}"
  decoded_word
end

def self.answerChallenge(answer)
  uri = URI("#{@server_uri}#{@challenge_uri}#{@challenge_word}")
  response = Net::HTTP.post_form(uri, 'answer' => answer)
  response_hash = JSON.parse(response.body)
  result = response_hash['result']
  @challenge_uri = response_hash['next_url']
  clue = response_hash['clue']
  if result == 'OK'
    @decoder_algorithm_index += 1
    puts "\nPerfect!"
    puts 'Try the new challenge.' if @challenge_uri
    puts "Clue: #{clue}" if clue
  else
    puts "\nYou failed. Try again!"
  end
  @challenge_uri ? true : false
end

while @next_challenge do
  getChallenge
  answer = resolveChallenge
  @next_challenge = answerChallenge(answer)
end

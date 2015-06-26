require 'pry'
module TextReader
  class Speaker
    def initialize(text)
      @text = text
      @authorization = "Bearer #{ENV['VOICE_TOKEN']}"
    end

    attr_reader :text, :authorization

    VOICE_URI = "https://api.att.com/speech/v3/textToSpeech"

    def speak
      retrieve_sounds
      send_sounds
    end

    private

    def retrieve_sounds
      uri = VOICE_URI

      text = keep_alphabetic(text)

      options = {
        :method => :post,
        'Authorization' => authorization,
        'Content-Type'  => 'text/plain',
        'Accept'        => 'audio/amr-wb'
      }

      RestClient.post(uri, text, options) do |response|
        binding.pry
      end
    end

    def send_sounds
    end

    def keep_alphabetic(str)
      str.gsub(/[^0-9a-z]/i, '').squeeze(' ')
    end
  end
end

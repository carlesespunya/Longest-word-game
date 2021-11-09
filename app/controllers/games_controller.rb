require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:score]
    @letters_array = params[:letters_array].chars
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    json = open(url).read
    user = JSON.parse(json)
    warr = @word.upcase.chars
    if user["found"]
      warr.each do |x|
        if @letters_array.find_index(x).nil?
          @result = " is not in the grid"
          @score = 0
          break
        else
          @letters_array.delete_at(@letters_array.find_index(x))
          @score = 1
          @result = " is Correct!!!!!"
        end
      end
    else
      @result = " is not an english word"
      @score = 0
    end
  end
end

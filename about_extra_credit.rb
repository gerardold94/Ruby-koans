# EXTRA CREDIT:
#
# Create a program that will play the Greed Game.
# Rules for the game are in GREED_RULES.TXT.
#
# You already have a DiceSet class and score function you can use.
# Write a player class and a Game class to complete the project.  This
# is a free form assignment, so approach it however you desire.
require_relative "about_dice_project"
require_relative "about_scoring_project"

class Player
  attr_reader :number, :score
	def initialize(number)
		@score = 0
    @number = number
    @in_the_game = false
	end

  def add_score(points)
    @score += points if in_the_game?(points)
  end

  def in_the_game?(points)
    @in_the_game ||= points >= 300
  end
end

class Game
  def initialize(num_of_players)
    @num_of_players = num_of_players
    @dice = DiceSet.new
    @round = 0
    @game_over = false
    @players = []
    num_of_players.times { |i| @players << Player.new(i+1) }
  end

  def new_round
    return if @game_over

    @round += 1
    puts "Round #{@round}"

    @players.each_with_index do |player, i|
      score = score(@dice.roll(5))
      player.add_score(score)
      puts "Player #{player.number}\tScore #{score}\tTotal #{player.score}"

      @game_over ||= player.score >= 3000
    end
    puts ""
  end

  def show_winner
    return nil unless @game_over
    winner = @players.max_by(&:score)
    puts "Player #{winner.number} is the winner"
  end

  def is_game_over?
    @game_over
  end
end

game = Game.new(10)
while !game.is_game_over?
  game.new_round
end

game.show_winner

require_relative 'bowling'

game = Bowling::Game.new
puts "#{ARGV[0]} => #{game.calculate_scores(ARGV[0])}"
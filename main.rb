require_relative 'bowling'

game = Bowling::Game.new
puts "#{ARGV} => #{game.calculate_scores(ARGV[0])}"
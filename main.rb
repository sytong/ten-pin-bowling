require_relative 'bowling'

game = Bowling::Game.new ARGV[0]
puts "#{ARGV[0]} => #{game.scores}"
require 'minitest/autorun'
require_relative '../bowling'

class TestGame < Minitest::Test
  def setup
    @game = Bowling::Game.new
  end

  def teardown
    @game = nil
  end

  def test_max_scores
  	score = @game.calculate_scores '10,10,10,10,10,10,10,10,10,10,10,10'

  	assert_equal(300, score)
  end

  def test_open_open_spare
  	score = @game.calculate_scores '1,2,3,4,5,5'

  	assert_equal(20, score)
  end

  def test_spare_strike_open
  	score = @game.calculate_scores '9,1,10,8,0,2'

  	assert_equal(48, score)
  end

  def test_full_game_1
  	score = @game.calculate_scores '10,0,0,9,1,0,0,8,2,0,0,7,3,0,0,6,4,0,0'

  	assert_equal(50, score)
  end
end
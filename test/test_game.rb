require 'minitest/autorun'
require_relative '../bowling'

class TestGame < Minitest::Test
  def setup
    @game = nil
  end

  def teardown
    @game = nil
  end

  def test_max_scores
    @game = Bowling::Game.new '10,10,10,10,10,10,10,10,10,10,10,10'
    assert_equal(300, @game.scores)
  end

  def test_open_open_spare
    @game = Bowling::Game.new '1,2,3,4,5,5'
    assert_equal(20, @game.scores)
  end

  def test_spare_strike_open
    @game = Bowling::Game.new '9,1,10,8,0,2'
    assert_equal(48, @game.scores)
  end

  def test_full_game_1
    @game = Bowling::Game.new '10,0,0,9,1,0,0,8,2,0,0,7,3,0,0,6,4,0,0'
    assert_equal(50, @game.scores)
  end

  def test_full_game_2
    @game = Bowling::Game.new '10,5,5,7,2,5,5,10,10,10,2,3,5,5,7,3,3'
    assert_equal(168, @game.scores)
  end
end

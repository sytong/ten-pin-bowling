require 'minitest/autorun'
require_relative '../bowling'

class TestFrameParser < Minitest::Test
  def setup
    @parser = Bowling::FrameParser.new
  end

  def teardown
    @parser = nil
  end

  def test_one_frame_strike
    frames = @parser.parse '10'

    assert_equal(1, frames.size)
    assert_equal(10, frames[0].ball1)
  end

  def test_one_frame_spare
    frames = @parser.parse '2,8'

    assert_equal(1, frames.size)
    assert_equal(2, frames[0].ball1)
    assert_equal(8, frames[0].ball2)
  end

  def test_one_frame_open
    frames = @parser.parse '2,4'

    assert_equal(1, frames.size)
    assert_equal(2, frames[0].ball1)
    assert_equal(4, frames[0].ball2)
  end

  def test_two_frames_strike_strike
    frames = @parser.parse '10,10'

    assert_equal(2, frames.size)
    assert_equal(10, frames[0].ball1)
    assert_equal(10, frames[1].ball1)
  end

  def test_two_frames_strike_spare
    frames = @parser.parse '10,3,7'

    assert_equal(2, frames.size)
    assert_equal(10, frames[0].ball1)
    assert_equal(3, frames[1].ball1)
    assert_equal(7, frames[1].ball2)
  end

  def test_three_frames_strike_spare_open
    frames = @parser.parse '10,3,7,2,4'

    assert_equal(3, frames.size)
    assert_equal(10, frames[0].ball1)
    assert_equal(3, frames[1].ball1)
    assert_equal(7, frames[1].ball2)
    assert_equal(2, frames[2].ball1)
    assert_equal(4, frames[2].ball2)
  end

  def test_four_frames_open_strike_spare_strike
    frames = @parser.parse '2,5,10,6,4,10'

    assert_equal(4, frames.size)
    assert_equal(2, frames[0].ball1)
    assert_equal(5, frames[0].ball2)
    assert_equal(10, frames[1].ball1)
    assert_equal(6, frames[2].ball1)
    assert_equal(4, frames[2].ball2)
    assert_equal(10, frames[3].ball1)
  end

  def test_four_frames_open_strike_strike_spare
    frames = @parser.parse '2,5,10,10,6,4'

    assert_equal(4, frames.size)
    assert_equal(2, frames[0].ball1)
    assert_equal(5, frames[0].ball2)
    assert_equal(10, frames[1].ball1)
    assert_equal(10, frames[2].ball1)
    assert_equal(6, frames[3].ball1)
    assert_equal(4, frames[3].ball2)
  end

  def test_ten_frames_max_scores
    frames = @parser.parse '10,10,10,10,10,10,10,10,10,10,10,10'

    assert_equal(10, frames.size)
    assert_equal(10, frames[0].ball1)
    assert_equal(10, frames[1].ball1)
    assert_equal(10, frames[2].ball1)
    assert_equal(10, frames[3].ball1)
    assert_equal(10, frames[4].ball1)
    assert_equal(10, frames[5].ball1)
    assert_equal(10, frames[6].ball1)
    assert_equal(10, frames[7].ball1)
    assert_equal(10, frames[8].ball1)
    assert_equal(10, frames[9].ball1)
    assert_equal(10, frames[9].ball2)
    assert_equal(10, frames[9].ball3)
  end
end
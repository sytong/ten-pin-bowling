require 'minitest/autorun'
require_relative '../bowling'

class TestFrame < Minitest::Test
  def setup
    @frame = Bowling::Frame.new
  end

  def teardown
    @frame = nil
  end

  def test_strike
    @frame.knock_down(10)

    assert_equal(true, @frame.strike?, 'Failed to match a strike')
    refute_equal(true, @frame.spare?, 'Match a spare incorrectly')
    refute_equal(true, @frame.open_frame?, 'Match an open frame incorrectly')
  end

  def test_spare
  	@frame.knock_down(3)
  	@frame.knock_down(7)

  	assert_equal(true, @frame.spare?, 'Failed to match a spare')
  	refute_equal(true, @frame.strike?, 'Match a strike incorrectly')
  	refute_equal(true, @frame.open_frame?, 'Match an open frame incorrectly')
  end

  def test_open_frame
  	@frame.knock_down(4)
  	@frame.knock_down(2)

  	assert_equal(true, @frame.open_frame?, 'Failed to match an open frame')
  	refute_equal(true, @frame.strike?, 'Match a strike incorrectly')
  	refute_equal(true, @frame.spare?, 'Match a spare incorrectly')
  end

  def test_open_frame_with_zero_pin
  	@frame.knock_down(0)
  	@frame.knock_down(0)

  	assert_equal(true, @frame.open_frame?, 'Failed to match an open frame')
  	refute_equal(true, @frame.strike?, 'Match a strike incorrectly')
  	refute_equal(true, @frame.spare?, 'Match a spare incorrectly')
  end

  def test_spare_with_zero_first_throw
  	@frame.knock_down(0)
  	@frame.knock_down(10)

  	assert_equal(true, @frame.spare?, 'Failed to match a spare')
  	refute_equal(true, @frame.strike?, 'Match a strike incorrectly')
  	refute_equal(true, @frame.open_frame?, 'Match an open frame incorrectly')
  end

  def test_open_frame_with_zero_first_throw
  	@frame.knock_down(0)
  	@frame.knock_down(5)

  	assert_equal(true, @frame.open_frame?, 'Failed to match an open frame')
  	refute_equal(true, @frame.strike?, 'Match a strike incorrectly')
  	refute_equal(true, @frame.spare?, 'Match a spare incorrectly')
  end
end
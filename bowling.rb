# coding: utf-8

# Ten Pin Bowling - coding exercise
module Bowling
  # A game can only have 10 frames
  MAX_FRAMES = 10

  # A frame in a ten-pin bowling game
  class Frame
    # @return [Integer] the number of pins knocked down by the first ball
    attr_reader :ball1

    # @return [Integer] the number of pins knocked down by the second ball
    attr_reader :ball2

    # @return [Integer] the number of pins knocked down by the third ball
    attr_reader :ball3

    # @return [Integer] the numer of throws attempted in this frame
    attr_reader :throws

    # Set the number of pins knocked down by a throw
    #
    # @param [Integer] pins knocked down by a throw
    def knock_down(pins)
      if ball1.nil?
        @ball1 = pins
        @throws = 1
      elsif ball2.nil?
        @ball2 = pins
        @throws = 2
      else
        @ball3 = pins
        @throws = 3
      end
    end

    # Return true if this frame is a strike
    def strike?
      ball1 == 10
    end

    # Return true if this frame is a spare
    def spare?
      if ball2.nil?
        false
      else
        ball1 + ball2 == 10
      end
    end

    # Return true if this frame ends up as an open frame
    def open_frame?
      if ball2.nil?
        false
      else
        ball1 + ball2 < 10
      end
    end

    # Return the basic score (no strike/spare bonus) of this frame
    def scores
      s = ball1 unless ball1.nil?
      s += ball2 unless ball2.nil?
      s += ball3 unless ball3.nil?
      s
    end
  end

  # Read the pins and create frames
  class FrameParser
    # Parse a series of bowling pins in terms of comma-separated integer.
    # The score can represent either a complete game or a partial game.
    #
    # @param [String] comma-separated pins assumed to be correct
    # @return [Array] an array of Frames
    def parse(pins)
      frames = []
      frame = nil
      pins.split(',').map(&:to_i).each do |p|
        if frame.nil?
          frame = Frame.new
          frame.knock_down p
          frames << frame

          frame = nil if frame.strike? && frames.size < MAX_FRAMES
        else
          frame.knock_down p
          frame = nil if frames.size < MAX_FRAMES
        end
      end
      frames
    end
  end

  # Let's play a bowling game
  class Game
    # Initialize the game with comma-separated pins
    #
    # @param [String] comma-separated pins assumed to be correct
    def initialize(pins)
      parser = Bowling::FrameParser.new
      @frames = parser.parse(pins)
    end

    # Return the scores of a game
    #
    # @return [Integer] game scores
    def scores
      total_scores = 0
      @frames.each_with_index do |frame, idx|
        bonus = 0
        # No bonus if this is alreay the last frame
        if idx < @frames.size - 1
          bonus = strike_bonus(idx) if frame.strike?
          bonus = spare_bonus(idx) if frame.spare?
        end
        total_scores = total_scores + frame.scores + bonus
      end
      total_scores
    end

    private

    # Return the strike bonus
    #
    # @param [Integer] index of the current frame
    # @return [Integer] bonus scores of a strike frame
    def strike_bonus(current_idx)
      next_frame = @frames[current_idx + 1]
      bonus = next_frame.ball1
      if next_frame.throws >= 2
        bonus += next_frame.ball2
      else
        bonus += @frames[current_idx + 2].ball1
      end
      bonus
    end

    # Return the spare bonus
    #
    # @param [Integer] index of the current frame
    # @return [Integer] bonus scores of a spare frame
    def spare_bonus(current_idx)
      @frames[current_idx + 1].ball1
    end
  end
end

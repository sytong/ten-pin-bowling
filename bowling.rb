# coding: utf-8

module Bowling

  # A frame in a ten-pin bowling game
  class Frame
  	# @return [Integer] the number of pins knocked down by the first ball. Mandatory.
    attr_reader :ball1

   	# @return [Integer] the number of pins knocked down by the second ball. Optional.
    attr_reader :ball2

    # @return [Integer] the number of pins knocked down by the third ball. Tenth frame only.
    attr_reader :ball3

    # @return [Integer] the numer of throws attempted in this frame
    attr_reader :throws

    # Set the number of pins knocked down by a throw
    #
    # @param [Integer] pins knocked down by a throw
    def knock_down(pins)
      if @ball1.nil? 
      	@ball1 = pins
      	@throws = 1
      else
      	@ball2 = pins
      	@throws = 2
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
  end

  # Read the pins and create frames
  class FrameParser
  	# Parse a series of bowling pins in terms of comma-separated integer.
  	# 
  	# The score can represent either a complete game or a partial game.
  	#
  	# @param [String] comma-separated pins assumed to be correct
  	# @return [Array] an array of Frames
    def parse(pins)
    	frames = []
    	frame = nil
      pins.split(',').map{|x| x.to_i}.each do |p|
        if frame.nil?
        	frame = Frame.new
        	frame.knock_down p
        	frames << frame

        	frame = nil if frame.strike?
        else
        	frame.knock_down p
        	frame = nil
        end
      end
      frames
    end
  end

  # Let's play a bowling game
  class Game
  	# Return the scores of a game based on a comma-separate pins
  	def calculate_scores(pins)
  		parser = Bowling::FrameParser.new
  		frames = parser.parse(pins)

      # A very literal way to implement this
      total_scores = 0
      frames.each_with_index do |frame, idx|
        if frame.strike?
          score = frame.ball1
          next_frame = frames[idx+1]
          bonus = next_frame.ball1
          if next_frame.throws >= 2
            bonus = bonus + next_frame.ball2
          else
          	bonus = bonus + frames[idx+2].ball1
          end
          total_scores = total_scores + score + bonus
        elsif frame.spare?
          score = frame.ball1 + frame.ball2
          next_frame = frames[idx+1]
          bonus = next_frame.ball1
          total_scores = total_scores + score + bonus
        else # open_frame, what else?
        	total_scores = total_scores + frame.ball1 + frame.ball2
        end
      end
      total_scores
  	end
  end
end

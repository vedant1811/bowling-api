ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def completed_game
    game = nine_strikes_game
    game.frames << open_frame
    game
  end

  def nine_strikes_game
    game = Game.new
    frames = Array.new(9) { strike_frame }
    game.frames = frames
    game.save!
    game
  end

  def strike_frame
    Frame.new(balls: [ Ball.new(pins: 10) ])
  end

  def open_frame
    Frame.new(balls: Array.new(2) { Ball.new(pins: 1) })
  end

  def spare_frame
    Frame.new(balls: [ Ball.new(pins: 1), Ball.new(pins: 9) ])
  end
end

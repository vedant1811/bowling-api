require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should create new record' do
    game = Game.new
    assert game.save
  end

  test 'should give a new frame for new game' do
    game = games(:empty)
    frame = game.next_frame
    refute_nil frame
    assert frame.new_record?
  end

  test 'should give the last frame for 10th strike' do
    game = nine_strikes_game
    game.frames << strike_frame

    frame = game.next_frame
    refute_nil frame
    refute frame.new_record?
  end

  test 'should not give a new frame' do
    game = nine_strikes_game
    game.frames << open_frame

    frame = game.next_frame
    assert_nil frame
  end
end

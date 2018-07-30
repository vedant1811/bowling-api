require 'test_helper'

class NewBallTest < ActiveSupport::TestCase
  test 'should create a new ball and new frame' do
    game = games(:empty)
    assert_difference ['Ball.count', 'Frame.count', 'game.frames.size'], 1 do
      assert game.new_ball 1
    end
  end

  test 'should create a new ball but not frame' do
    game = games(:empty)
    game.frames << Frame.new(balls: [ Ball.new(pins: 3) ])
    assert_difference ->{ Ball.count } => 1, ->{ Frame.count } => 0 do
      assert game.new_ball 1
    end
  end

  test 'should create a new ball and new frame after strike' do
    game = games(:empty)
    game.frames << strike_frame
    assert_difference ['Ball.count', 'Frame.count', 'game.frames.size'], 1 do
      assert game.new_ball 1
    end
  end

  test 'should create new balls but no frame for 10th strike' do
    game = nine_strikes_game
    game.frames << strike_frame

    assert_difference ->{ Ball.count } => 2, ->{ Frame.count } => 0 do
      assert game.new_ball 1
      assert game.new_ball 1
      refute game.new_ball 1
    end
  end

  test 'should create perfect score' do
    game = nine_strikes_game

    assert_difference ->{ Ball.count } => 3, ->{ Frame.count } => 1, ->{ game.frames.size } => 1 do
      assert game.new_ball MAX_PINS
      assert game.new_ball MAX_PINS
      assert game.new_ball MAX_PINS
      refute game.new_ball MAX_PINS
    end
  end

  test 'should create a new ball but no frame for 10th spare' do
    game = nine_strikes_game
    game.frames << spare_frame

    assert_difference ->{ Ball.count } => 1, ->{ Frame.count } => 0 do
      assert game.new_ball 1
    end
  end

  test 'should not create a new ball nor new frame for completed game' do
    game = completed_game

    assert_no_difference ['Ball.count', 'Frame.count'] do
      refute game.new_ball 1
    end
  end
end

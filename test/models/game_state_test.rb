require 'test_helper'

class GameStateTest < ActiveSupport::TestCase
  test 'should create a new ball and new frame' do
    game_state = GameState.new games(:empty)
    assert_difference ['Ball.count', 'Frame.count'], 1 do
      assert game_state.new_ball 1
    end
  end

  test 'should create a new ball but not frame' do
    game = games(:empty)
    game.frames << Frame.new(balls: [ Ball.new(pins: 3) ])
    game_state = GameState.new game
    assert_difference ->{ Ball.count } => 1, ->{ Frame.count } => 0 do
      assert game_state.new_ball 1
    end
  end

  test 'should create a new ball and new frame after strike' do
    game = games(:empty)
    game.frames << strike_frame
    game_state = GameState.new game
    assert_difference ['Ball.count', 'Frame.count'], 1 do
      assert game_state.new_ball 1
    end
  end

  test 'should create a new ball but no frame for 10th strike' do
    game = nine_strikes_game
    game.frames << strike_frame
    game_state = GameState.new game

    assert_difference ->{ Ball.count } => 1, ->{ Frame.count } => 0 do
      assert game_state.new_ball 1
    end
  end

  test 'should create a new ball but no frame for 10th spare' do
    game = nine_strikes_game
    game.frames << spare_frame
    game_state = GameState.new game

    assert_difference ->{ Ball.count } => 1, ->{ Frame.count } => 0 do
      assert game_state.new_ball 1
    end
  end

  test 'should not create a new ball nor new frame for completed game' do
    game = nine_strikes_game
    game.frames << open_frame
    game_state = GameState.new game

    assert_no_difference ['Ball.count', 'Frame.count'] do
      refute game_state.new_ball 1
    end
  end
end

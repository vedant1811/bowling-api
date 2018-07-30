require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = nine_strikes_game
  end

  test 'should create game' do
    assert_difference 'Game.count', 1 do
      post games_url
    end
    assert_response :created
  end

  test 'should show game' do
    get game_url(@game)
    assert_response :ok
  end

  test 'should create ball' do
    assert_difference 'Ball.count' do
      post game_new_ball_url @game, pins: 2
    end

    assert_response :created
  end

  test 'should not create ball for completed game' do
    game = completed_game
    assert_no_difference 'Ball.count' do
      post game_new_ball_url game, pins: 2
    end

    assert_response :unprocessable_entity
  end
end

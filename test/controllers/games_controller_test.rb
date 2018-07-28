require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = games(:one)
  end

  test "should create game" do
    assert_difference('Game.count', 1) do
      post games_url
    end
    assert_response :created
  end

  test "should show game" do
    get game_url(@game)
    assert_response :success
  end
end

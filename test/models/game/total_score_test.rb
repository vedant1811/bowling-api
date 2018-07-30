require 'test_helper'

class TotalScoreTest < ActiveSupport::TestCase
  test 'total score for empty game' do
    game = games(:empty)
    assert_nil game.total_score
  end

  test 'score for 1 open frame game' do
    game = Game.new
    game.frames << open_frame
    expected = [2]
    assert_fame_scores game, expected
  end

  test 'score for 1 strike frame game' do
    game = Game.new
    game.frames << strike_frame
    expected = []
    assert_fame_scores game, expected
  end

  test 'score for 1 strike frame, 1 incomplete frame game' do
    game = Game.new
    game.frames << strike_frame
    game.new_ball 1
    expected = []
    assert_fame_scores game, expected
  end

  test 'score for 1 strike, 1 open frame game' do
    game = Game.new
    game.frames << strike_frame << open_frame
    game.save!
    expected = [12, 14]
    assert_fame_scores game, expected
  end

  test 'score for 9 strikes game' do
    game = nine_strikes_game
    expected = [30, 60, 90, 120, 150, 180, 210]
    assert_fame_scores game, expected
  end

  test 'score for perfect score game' do
    game = nine_strikes_game
    game.new_ball MAX_PINS
    game.new_ball MAX_PINS
    game.new_ball MAX_PINS
    expected = [30, 60, 90, 120, 150, 180, 210, 240, 270, 300]
    assert_fame_scores game, expected
  end

private
  def assert_fame_scores(game, expected)
    assert_nil_safe_equal expected.last, game.total_score
    game.frames.each_with_index do |frame, i|
      assert_nil_safe_equal expected[i], frame.score
    end
  end
end

require 'test_helper'

class TotalScoreTest < ActiveSupport::TestCase
  test 'total score for empty game' do
    game = games(:empty)
    assert_equal 0, game.total_score
  end

  test 'score for 9 strikes game' do
    game = nine_strikes_game
    expected = [30, 60, 90, 120, 150, 180, 210, 240, 270]
    assert_fame_scores game, expected
  end

private
  def assert_fame_scores(game, expected)
    assert_equal expected.last, game.total_score
    expected.each_with_index do |expected_score, i|
      assert_equal expected_score, game.frames[i].score
    end
  end
end

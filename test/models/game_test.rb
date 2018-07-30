require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'should create new record' do
    game = Game.new
    assert game.save
  end
end

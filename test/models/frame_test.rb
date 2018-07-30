require 'test_helper'

class FrameTest < ActiveSupport::TestCase
  setup do
    @frame = frames(:one)
    @game = games(:one)
  end

  test 'should create frame' do
    frame = Frame.new
    frame.game = @game
    assert frame.save
  end

  test 'should not create frame without game' do
    frame = Frame.new
    refute frame.save
  end

  test 'balls total should be correct' do
    frame = strike_frame
    frame.game = @game
    frame.save!

    assert_equal MAX_PINS, frame.balls_total
  end
end

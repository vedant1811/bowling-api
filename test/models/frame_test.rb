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
end

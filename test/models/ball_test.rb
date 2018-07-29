require 'test_helper'

class BallTest < ActiveSupport::TestCase
  setup do
    @frame = frames(:one)
  end

  test 'should not create ball without pins' do
    ball = Ball.new
    ball.frame = @frame
    refute ball.save
  end

  test 'should not create ball without frame' do
    ball = Ball.new
    ball.pins = 2
    refute ball.save
  end

  test 'should create ball' do
    ball = Ball.new
    ball.frame = @frame
    ball.pins = 2
    assert ball.save
  end

  test 'should not create ball with pins > 10' do
    ball = Ball.new
    ball.frame = @frame
    ball.pins = 20
    refute ball.save
  end
end

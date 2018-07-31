MAX_PINS = 10.freeze

class Frame < ApplicationRecord
  belongs_to :game, inverse_of: :frames
  has_many :balls, inverse_of: :frame

  attr_accessor :score

  def complete?
    if last?
      max = strike? || spare? ? 3 : 2
      balls.to_a.count == max
    else
      strike? || balls.to_a.count == 2
    end
  end

  def incomplete?
    !complete?
  end

  def strike?
    balls.first&.pins == 10
  end

  def spare?
    return false if balls.to_a.count < 2
    balls.first.pins + balls.second.pins == MAX_PINS
  end

  def balls_total
    balls.reduce(0) { |sum, ball| sum + ball.pins }
  end

private
  def last?
    # TODO: break the cyclic dependency and not call game methods
    game.frames.to_a.count == 10
  end
end

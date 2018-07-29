class Frame < ApplicationRecord
  belongs_to :game, inverse_of: :frames
  has_many :balls, inverse_of: :frame

  def complete?
    if last?
      max = strike? || spare? ? 3 : 2
      balls.count == max
    else
      strike? || balls.count == 2
    end
  end

  def incomplete?
    !complete?
  end

private
  def last?
    game.frames.count == 10
  end

  def strike?
    balls.first&.pins == 10
  end

  def spare?
    return false if balls.count < 2
    balls.first.pins + balls.last.pins == 10
  end
end

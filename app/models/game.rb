##
# the primary key (id) is a UUID
class Game < ApplicationRecord
  has_many :frames, inverse_of: :game
  has_many :balls, through: :frames

  # @return false if game has finished, true otherwise
  def new_ball(pins)
    if frames.last&.incomplete?
      frames.last.balls.create! pins: pins
    elsif frames.count == 10
      return false
    else
      frames << Frame.new(balls: [ Ball.new(pins: pins) ])
    end
    true
  end

  # can be +nil+
  def total_score
    calculate_scores
  end

private
  def calculate_scores
    score = nil
    frames.each do |frame|
      current =
      if frame.strike?
        next_n_balls_score(frame.balls.first, 2)&.+ 10
      elsif frame.spare?
        next_n_balls_score(frame.balls.second, 1)&.+ 10
      elsif frame.balls.size == 2
        frame.balls_total
      end
      break unless current
      score = score ? score + current : current
      frame.score = score
    end
    score
  end

  def next_n_balls_score(current_ball, n)
    index = balls.index(current_ball)
    return nil unless index && (index + n < balls.size)
    balls[index + 1, n].reduce(0) { |sum, ball| sum + ball.pins }
  end
end

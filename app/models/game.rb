##
# the primary key (id) is a UUID
class Game < ApplicationRecord
  has_many :frames, inverse_of: :game
  has_many :balls, through: :frames

  # load all frams and balls all the time
  # on frames and balls, get count by +to_a.count+, otherwise SQL query SELECT COUNT(*) is executed
  default_scope {
    includes(:frames, :balls)
  }

  # @return array of errors. An empty array if no errors and record was saved
  def new_ball(pins)
    ball = Ball.new pins: pins
    if frames.last&.incomplete?
      frames.last.balls << ball
    elsif frames.to_a.count == 10
      return ['Game is completed']
    else
      frames << Frame.new(balls: [ ball ])
    end
    ball.errors.to_a
  end

  # can be +nil+
  def total_score
    # TODO: calcute scores in some other hook
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
        frame.balls.second.value = '/'
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

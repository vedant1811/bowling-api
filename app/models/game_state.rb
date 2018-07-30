##
# The state of a game that can be completely created by the persisted data
class GameState
  include ActiveModel::Validations

  def initialize(game)
    @game = game
  end

  # @return false if game has finished, true otherwise
  def new_ball(pins)
    frame = next_frame
    return false unless frame
    frame.balls.build pins: pins
    frame.save
  end

private
  def next_frame
    if @game.frames.last&.incomplete?
      @game.frames.last
    elsif @game.frames.count == 10
      nil
    else
      Frame.new(game: @game)
    end
  end
end

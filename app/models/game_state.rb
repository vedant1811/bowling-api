##
# The state of a game that can be completely created by the persisted data
class GameState

  def initialize(game)
    @game = game
  end

  # @return false if game has finished, true otherwise
  def new_ball(pins)
    frame = @game.next_frame
    return false unless frame
    frame.balls.build pins: pins
    frame.save
  end
end

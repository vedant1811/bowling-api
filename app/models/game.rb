##
# the primary key (id) is a UUID
class Game < ApplicationRecord
  has_many :frames, inverse_of: :game

  def next_frame
    if frames.last&.incomplete?
      frames.last
    elsif frames.count == 10
      nil
    else
      Frame.new(game: self)
    end
  end
end

class Frame < ApplicationRecord
  belongs_to :game, inverse_of: :frames
  has_many :balls, inverse_of: :frame
end

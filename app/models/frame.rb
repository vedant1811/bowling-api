class Frame < ApplicationRecord
  belongs_to :game, inverse_of: :frames

  validates :game, presence: true
end

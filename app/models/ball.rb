class Ball < ApplicationRecord
  belongs_to :frame, inverse_of: :balls

  validates :pins, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
end

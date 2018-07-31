class Ball < ApplicationRecord
  belongs_to :frame, inverse_of: :balls

  attr_accessor :value

  validates :pins, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }

  def value
    return @value if @value # do not calcute value if already set from outside

    pins == 10 ? 'X' : pins.to_s
  end
end

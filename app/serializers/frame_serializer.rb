class FrameSerializer < ActiveModel::Serializer
  attributes :score
  has_many :balls
end

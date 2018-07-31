class GameSerializer < ActiveModel::Serializer
  attributes :id, :total_score
  has_many :frames
end

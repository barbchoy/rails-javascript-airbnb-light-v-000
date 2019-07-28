class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :title, :comments, :house_id, :user_id
  belongs_to :house
end

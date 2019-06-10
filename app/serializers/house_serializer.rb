class HouseSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_per_night, :city, :max_guests, :pets_allowed, :owner_id
  has_many :reviews
end

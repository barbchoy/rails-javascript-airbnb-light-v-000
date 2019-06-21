class HouseSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_per_night, :city, :max_guests, :pets_allowed, :description, :amenities, :owner_id
  has_many :reviews
end

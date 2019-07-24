class HouseSerializer < ActiveModel::Serializer
  attributes :id, :name, :price_per_night, :city, :max_guests, :pets_allowed, :description, :amenities, :owner_id
  has_many :reviews

  def self.serialize(house)
    serialized_house = '{'

    serialized_house += '"id": ' + house.id.to_s + ', '
    serialized_house += '"name": "' + house.name + '", '
    serialized_house += '"description": "' + house.description + '", '
    serialized_house += '"city": ' + house.city + ', '
    serialized_house += '"price": "' + house.price_per_night.to_s + '"'

    serialized_house += '}'
  end
end

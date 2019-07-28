class House < ApplicationRecord

  validates :name, presence: true

  has_many  :stays
  has_many  :guests, through: :stays, :class_name => "User"
  belongs_to :owner, :class_name => "User"
  has_many :reviews

  scope :sort_by_price_per_night_asc, -> {order(:price_per_night)}
  scope :sort_by_price_per_night_desc, -> {order(price_per_night: :desc)}
  scope :pets_ok, -> {where("pets_allowed = ?", true)}
  scope :pets_not_ok, -> {where("pets_allowed = ?", false)}
  scope :mininum_guest, -> (guests) {where("max_guests >= ?", guests)}
  scope :in_location, -> (city) {where("city = ?", city)}

  accepts_nested_attributes_for :reviews

  def cleanliness_rating
    self.reviews.average(:cleanliness_rating)
  end

  def location_rating
    self.reviews.average(:location_rating)
  end

  def value_rating
    self.reviews.average(:value_rating)
  end

  def overall_rating
    ratings = [cleanliness_rating, location_rating, value_rating]
    overall = ratings.inject(0.0) { |sum, el| sum + el } / ratings.size
    overall.round
  end

  def next
    house = House.where("id > ?", id).first

    if house
      house
    else
      House.first
    end

  end




end

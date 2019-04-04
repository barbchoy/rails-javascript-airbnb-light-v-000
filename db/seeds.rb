# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


DATA = {
  :user_keys =>
    ["name", "budget", "guests", "password"],
  :users => [
    ["Max Charles", 100, 3, "password"],
    ["Skai Jackson", 500, 6, "password"],
    ["Kaleo Elam", 350, 2, "password"],
    ["Megan Charpentier", 400, 4, "password"],
    ["Hayden Byerly", 800, 4, "password"],
    ["Tenzing Norgay Trainor", 1000, 5, "password"],
    ["Davis Cleveland", 600, 3, "password"],
    ["Cole Sand", 700, 4, "password"],
    ["Quvenzhané Wallis", 500, 3, "password"]
  ],
  :house_keys =>
   ["name", "price_per_night", "city", "max_guests", "cleanliness_rating", "location_rating", "value_rating", "reviews_count"],
  :houses => [
    ["Studio Guest House Hot Tub Wifi", 93, "South Lake Tahoe", 2, 4, 4, 4, 379],
    ["Amazing A-frame cabin with hot tub, 2 fireplaces & more", 154, "Tahoe City", 8, 5, 4, 4, 50],
    ["Rustic Chic Cabin Walk 2 Lake Woodstove Fireplace", 86, "South Lake Tahoe", 6, 5, 3, 4, 86],
    ["Pine Cone the Awesome (Sunnyside)", 131, "Tahoe City", 16, 5, 5, 4, 192],
    ["Classic, Lake Tahoe cabin on double lot w/ WiFi & fireplace!", 126, "Carnelian Bay", 11, 5, 5, 4, 41],
    ["Awesome Lakeview Hot TUB-Birds Eye Lookout-SAUNA", 250, "Tahoe City", 10, 5, 5, 5, 161],
    ["Steps to Heavenly and Stateline", 112, "South Lake Tahoe", 6, 5, 4, 5, 166],
    ["Cozy Condo In the Heart of Incline", 56, "Incline Village", 10, 5, 4, 5, 120],
    ["Heavenly Cabin", 175, "South Lake Tahoe", 6, 5, 5, 4, 33]
  ],
  :owners => [
    "Mary Elitch Long",
    "John Elitch"
  ]
}

def main
  make_users
  make_owners
  make_houses_owner_and_stays
end

def make_users
  DATA[:users].each do |user|
    new_user = User.new
    user.each_with_index do |attribute, i|
      new_user.send(DATA[:user_keys][i]+"=", attribute)
    end
    new_user.save
  end
end

def make_owners
  DATA[:owners].each do |name|
    User.create(name: name, owner: true, password: 'password')
  end
end


def make_houses_owner_and_stays
  DATA[:houses].each do |house|
    new_house = House.new
    house.each_with_index do |attribute, i|
      new_house.send(DATA[:house_keys][i] + "=", attribute)
    end

      guests = []
      owners = []
      User.all.each { |u|
        if u.owner != true
          guests << u
        else
          owners << u
        end
        }
      new_house.guests << guests[rand(0...guests.length)]
      new_house.owner = owners.shuffle.first

    new_house.save
  end
end

main

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


DATA = {
  :user_keys =>
    ["name", "balance", "guests", "pets", "password"],
  :users => [
    ["Max Charles", 100, 3, true, "password"],
    ["Skai Jackson", 500, 6, true, "password"],
    ["Kaleo Elam", 350, 2, false,"password"],
    ["Megan Charpentier", 400, 4, false, "password"],
    ["Hayden Byerly", 800, 4, true, "password"],
    ["Tenzing Norgay Trainor", 1000, 5, true, "password"],
    ["Davis Cleveland", 600, 3, true, "password"],
    ["Cole Sand", 700, 4, false, "password"],
    ["Quvenzhané Wallis", 500, 3, false, "password"]
  ],
  :house_keys =>
   ["name", "price_per_night", "city", "max_guests", "pets_allowed", "description", "amenities"],
  :houses => [
    ["Studio Guest House Hot Tub Wifi", 93, "South Lake Tahoe", 2, true, "Conveniently located steps to trails, town , casinos, and resorts. Our quiet, one bedroom, one bath is furnished with bed and couch. Linens are not provided. Guest will have the entire apartment to themselves with full kitchen. Kitchen has granite counter tops. Onsite laundry. Snow removal included! 1 Car onsite parking.", "dryer, washer, free parking on premises, kitchen"],
    ["Amazing A-frame cabin with hot tub, 2 fireplaces & more", 154, "Tahoe City", 8, true, "PRIVATE April 16th - May 7th! I am leaving for vacation those dates, so if you book during that time my bedroom door will be locked, my place will be professionally cleaned before every stay, and you will have the entire place privately to yourselves :-)", "kitchen, wifi, free parking on premises"],
    ["Rustic Chic Cabin Walk 2 Lake Woodstove Fireplace", 86, "South Lake Tahoe", 6, false, "My place is close to the beach, restaurants and dining, family-friendly activities, art and culture, and great views. You’ll love my place because of the views and the location. My place is good for couples, solo adventurers, and business travelers. This is a cabin built in the 1970's, not a 2010 Condo. 2 of the 3 rooms in the house are Air B&B so there may be other guests..TAX ID # 328727", "shampoo, wifi, kitchen, washer, dryer"],
    ["Pine Cone the Awesome (Sunnyside)", 131, "Tahoe City", 16, false, "Our home is conveniently located close to the lake, Heavenly and nearby shops and restaurants. Gorgeous views of Mt. Tallac and wildlife in the lagoon right outside your window. City of South Lake Tahoe License # 328787", "kitchen, hair dryer, hot tub"],
    ["Classic, Lake Tahoe cabin on double lot w/ WiFi & fireplace!", 126, "Carnelian Bay", 11, false, "The lower level of our home has a private entrance which will be yours to use. We are upstairs to provide tips on sights and amenities but separated enough that you have your privacy.", "hot tub, parking, shampoo, ironing board"],
    ["Awesome Lakeview Hot TUB-Birds Eye Lookout-SAUNA", 250, "Tahoe City", 10, true, "The guest suite includes a separate bedroom with queen size bed and private bathroom. The living area has a small kitchenette with microwave, toaster oven, kettle, coffee maker, egg cooker, crock pot, electric fry pan, fridge, sink and dishwasher. There is also a gas grill outside with an extra burner so you can grill dinner. Relax in the hot tub after skiing or hiking and then curl up on the couch to watch the HD TV or a movie (selection provided). During the summer months enjoy an evening sitting outside under the stars beside the fire. There is a canoe at your disposal whereby you can explore the lagoon and get a birds eye view of the homes. A walk to the beach is nearby as are many other easy to access walks, bike rides and hikes.", "dryer, washer, kitchen, wifi, hot tub"],
    ["Steps to Heavenly and Stateline", 112, "South Lake Tahoe", 6, true, "We are dog friendly under the following conditions:
No more than one dog. Your dog must be both people and dog friendly. Your dog may not be left alone in the suite by itself unless you know with certainty that it isn't going to cry, whine or bark due to separation anxiety or being in an unfamiliar location where it can see things out the windows or hear noises that scare it. We love dogs and can't stand having stressed out dogs in our home. Just not fair to the dog or us.", "dryer, washer, air con, heating, TV"],
    ["Cozy Condo In the Heart of Incline", 56, "Incline Village", 10, false, "Minutes away from every Tahoe activity (summer and winter)! Located on a bike path (bikes included), you are a beautiful ride from hiking, boating, and swimming. Or just a short drive to world renowned skiing. Our dog- friendly ($20/night/dog) cabin features a queen-size bed, a full bathroom, and a full kitchen.", "fireplace, towels, bed sheets, heating"],
    ["Heavenly Cabin", 175, "South Lake Tahoe", 6, false, "Need to accommodate more people? Our complex has more cabins (see Emerald Bay Courtyard listings), which are cozy and intimate, perfect for a family or friend getaway!", "laundry, barbeque, parking, washer, dryer"]
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

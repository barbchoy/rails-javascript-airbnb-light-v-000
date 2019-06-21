class CreateHouse < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :name
      t.integer :price_per_night
      t.string :city
      t.integer :max_guests
      t.boolean :pets_allowed
      t.text :description
      t.text :amenities
      t.references :owner
    end
  end

end

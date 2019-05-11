class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :destination
      t.date :startdate
      t.date :enddate
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :day
      t.string :fromAddress
      t.float :from_lat
      t.float :from_long
      t.string :toAddress
      t.float :to_lat
      t.float :to_long
      t.string :time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

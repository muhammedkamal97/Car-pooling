class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.references :drive_user, index: true
      t.references :location, index: true
      t.string :request
      t.boolean :read

      t.timestamps
    end
    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :users, column: :drive_user_id
    add_foreign_key :notifications, :locations
  end
end

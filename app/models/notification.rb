class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :drive_user
  belongs_to :location
end

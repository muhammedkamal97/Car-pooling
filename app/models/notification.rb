class Notification < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :drive_user,  class_name: 'User'
  belongs_to :location
end

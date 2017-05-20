class NotificationsController < ApplicationController
  def viewALL
  	@notification = current_user.notifications.each
  end
end

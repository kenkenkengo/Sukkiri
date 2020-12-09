class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.paginate(page: params[:page], per_page: 10)
    current_user.update_attribute(:notification, false)
  end
end

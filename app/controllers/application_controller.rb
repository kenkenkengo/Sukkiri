class ApplicationController < ActionController::Base
  include GroupsHelper
  protect_from_forgery prepend: true, with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def correct_user
    unless current_user.groups.find_by(id: params[:group_id])
      redirect_to user_path(current_user)
      flash[:alert] = "入室許可されたグループではありません"
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

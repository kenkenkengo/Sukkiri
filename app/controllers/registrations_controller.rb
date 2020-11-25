class RegistrationsController < Devise::RegistrationsController
  def edit_password
  end

  def update_password
    if current_user.valid_password?(params[:user][:current_password])
      if current_user.update(user_params)
        flash[:notice] = "パスワード変更しました"
        bypass_sign_in(current_user)
        redirect_to edit_user_registration_path
      else
        render :edit_password
      end
    else
      flash.now[:alert] = "現在のパスワードが間違っています"
      render :edit_password
    end
  end

  protected

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end
end
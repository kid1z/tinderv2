class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    super
  end

  def update
    @user = User.where(email: params[:user][:email]).first
    if @user.id == current_user.id
      if user_params[:password].blank?
        user_params.delete(:password)
        user_params.delete(:password_confirmation)
      end

      successfully_updated = if needs_password?(@user, user_params)
                                @user.update(user_params)
                             else
                                @user.update_without_password(user_params)
                             end

      if successfully_updated
        flash[:success] = "Update successfully"
        redirect_to edit_user_registration_path
      else
        flash[:alert] = @user.errors.full_messages.to_sentence
        redirect_to edit_user_registration_path
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :phonenumber, :age, :gender, :address, :password, :password_confirmation)
  end

  def needs_password?(_user, params)
    params[:password].present?
  end
end 
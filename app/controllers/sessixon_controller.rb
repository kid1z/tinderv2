class SessixonController < ApplicationController
  # before_action :authenticate_user!
  def new; end

  # log in
  def create
    # byebug
    user = User.find_user_by_username_or_password(params[:username])
    # user = User.where("username = #{params[:username]}").first
    # user = User.where("username = '#{params[:username]}'").first
    # byebug
    # user = User.where("username = '#{params[:username]}' AND password = '#{params[:password]}'").first
    if user.present?
    # if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to new_app_path
    else
      flash.now[:alert] = "Invalid email/password combination"
      render "new"
    end
  end

  # log out 
  def destroy
    session.delete(:session_id)
    flash[:success] = "Log out successfully"
    redirect_to new_session_path
  end

  # filter
  def filter; end

  def filter_by_condition
    @params = params.to_enum.to_h
    redirect_to new_app_path
  end

 

  private

  def send_params
    params.require(:likes).permit(:user_id, :liked_user_id)
  end
end

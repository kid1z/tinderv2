class UserController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ change_password edit_profile update destroy update]

  def index
    @users = User.all
  end

  def new
    @user  = User.new

  end

  # sign in 
  def create
    @user  = User.new(user_params)
    if @user.save
      flash[:success] = "Signed In Successfully"
      redirect_to new_session_path
    else 
      flash.now[:alert] = "Signed In Failed"
      render "new"
    end
  end

  # change password 
  def change_password_template; end

  def change_password
    @user = current_user
    if (@user.authenticate(params[:password]) && params[:newpassword] == params[:confirmpassword])
      @user.update_attribute :password, params[:newpassword]
      flash[:success] = "Change Password Successfully"
      redirect_to new_session_path
    else 
      flash.now[:alert] = "Change Password Failed"
      render "new"
    end
  end

  # edit profile 
  def edit_profile
    @user = current_user
  end

  # update profile
  def update
    # byebug
    # p user_params.except(:password), @user.password
    if @user.update!(user_params.except(:password))
      flash.now[:success] = "Update Successfully"
      render "edit_profile"
    else
      flash.now[:alert] = "Update Failed"
      render "edit_profile"
    end
    
  end

  # delete account
  def destroy
    @user = current_user
    @user.destroy
    session.delete(:session_id)
    flash[:success] = "Delete Successfully"
    redirect_to new_session_path
  end

  #match
  def match
    @user = current_user
    @new_match = Like.match(@user)
  end

  # chat_room 
  def chat_room
    @partner = User.find(params[:id])
    @room = Message.find_by(sender_id: current_user.id, receiver_id: @partner.id)
    if @room === nil
      @createMessage = Message.create(sender_id: current_user.id, receiver_id: @partner.id)
    end
    @room_id = [current_user.id, @partner.id].sort().join('_')
    @match_user = Message.find_by(sender_id: params[:id], receiver_id: current_user.id)
  end
    

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name, :age, :username, :email, :password, :phonenumber, :gender, :address, :avatar)
  end

  def message_params
    # params.require(:message).permit(:)
  end
end
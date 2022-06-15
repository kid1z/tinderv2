class AppController < ApplicationController

  def new
    if !params[:commit].present?
      @users = User.all_except_id(current_user.id)
    else
      @users = User.filter(current_user.id, params[:age] , params[:address], params[:gender])
    end
  end

  def create
    current_user_id = current_user.id #1
    liked_user_id = params[:user_id].to_i #4
    new_like = Like.new(liked_user_id: liked_user_id, user_id: current_user_id)
    new_like.save
  end

   # filter
   def filter; end

   def filter_by_condition
    byebug
    @params = params.to_enum.to_h
    redirect_to new_app_path
   end
 
end

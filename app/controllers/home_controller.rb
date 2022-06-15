class HomeController < ApplicationController
  before_action :check_signed_in

  def index; end

  private

  def check_signed_in
   redirect_to new_app_path if user_signed_in?
  end
end

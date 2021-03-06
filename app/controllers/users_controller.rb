class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    if current_user.update_attributes(user_params)
      flash[:notice] = "User information updated"
      redirect_to root_path
    else
      flash[:error] = "Invalid user information"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
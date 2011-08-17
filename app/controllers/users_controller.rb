class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
	@user = User.all
  end
  
  def show

    @user = User.where(:name => params[:id])
  end

end
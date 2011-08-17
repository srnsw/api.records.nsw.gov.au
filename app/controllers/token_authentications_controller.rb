class TokenAuthenticationsController < ApplicationController 

  def create
    @user = User.find(params[:user_id])
    if @user
    	@user.reset_authentication_token!
    end
    redirect_to edit_user_registration_path(@user)
  end

  def destroy
    @user = User.find(params[:id])
    if @user
    	@user.authentication_token = nil
    	@user.save
    end
    redirect_to edit_user_registration_path(@user)
  end

end
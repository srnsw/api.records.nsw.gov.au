class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionHelper

  # Customize the Devise after_sign_in_path_for() for redirecct to previous page after login
  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope
    when :user, User
      store_location = session[:return_to]
      clear_stored_location
      (store_location.nil?) ? "/" : store_location.to_s
    else
      super
    end
  end
  
  #handle POST
  def create

	if current_user.nil?
      deny_access
   else 
     if params[:comment]  	
	  	 current_user.comments.create!(comments: params[:comment], entitytype: params[:entitytype], entityid: params[:id])
	  end	
	  if params[:tag]
	    current_user.tags.create!(tag: params[:tag], entitytype: params[:entitytype], entityid: params[:id], link: params[:link], title: params[:title])
	  end
	  redirect_to :back
   end
  end
  
end

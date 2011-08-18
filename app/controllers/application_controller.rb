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


  def tags
     @tags = self.model.tags 
     
	  respond_to do |format|
     format.any {render :action => 'tags/index'}
     format.xml {render :xml => @tags.to_xml}
     format.json {render :json => @tags.to_json}
    end
  end
  
  def comments
  	  @comments = self.model.comments 
     
	  respond_to do |format|
     format.any {render :action => 'comments/index'}
     format.xml {render :xml => to_paginated_xml(@tags, params[:page])}
     format.json {render :json => to_paginated_json(@tags, params[:page])}
     end
  end  
  
  
  #handle POST
  def create

	if current_user.nil?
      deny_access
   else
     
     if params[:comment]  	
	  	 current_user.comments.create!(comments: params[:comment], entitytype: params[:entitytype], entityid: params[:id], link: params[:link], title: params[:title])
	  end	
	  if params[:tag]
	    current_user.tags.create!(tag: params[:tag], entitytype: params[:entitytype], entityid: params[:id], link: params[:link], title: params[:title])
	  end
	  redirect_to :back
   end
  end
  
end

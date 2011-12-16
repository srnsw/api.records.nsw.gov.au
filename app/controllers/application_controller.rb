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
     format.xml {render :xml => @tags.to_xml(:only => [:tag])}
     format.json {render :json => @tags.to_json(:only => [:tag])}
    end
  end
  
  def comments
  	  @comments = self.model.comments 
     
	  respond_to do |format|
     format.any {render :action => 'comments/index'}
     format.xml {render :xml => @comments.to_xml(:only => [:comments])}
     format.json {render :json => @comments.to_json(:only => [:comments])}
     end
  end  
  
  
  #handle POST
  def create

   #anonymous tagging will be logged as api's tags
   #if params[:tag] and current_user.nil?
   #current_user = User.where(email: "api@records.nsw.gov.au").first
   #end 

   if current_user.nil?
      deny_access 
   else
     entitytype = ApplicationHelper::CONTROLLER_TO_MODEL[self.class.name]
     link = request.env['PATH_INFO'] 
     title = self.model.title

     if params[:comment]
       comment = current_user.comments.new(comments: params[:comment], entitytype: entitytype, entityid: params[:id], link: link, title: title)
       comment.save unless comment.spam?
     end	
     
     if params[:tag]
       tags = params[:tag].split(',')
       tags.each do |tag|
         current_user.tags.create!(tag: tag.strip, safe_tag: tag.gsub(/[^0-9A-Za-z]/,''), entitytype: entitytype, entityid: params[:id], link: link, title: title)
       end
     end
     redirect_to :back
   end
  end
  
end

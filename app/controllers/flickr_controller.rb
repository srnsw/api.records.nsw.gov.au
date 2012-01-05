
class FlickrController < ApplicationController
  caches_action :index
  def index
    
	begin
	  @photos = flickr.photos.search(:group_id => "1826099@N21")
	rescue
	  @photos = Array.new
	end 
   
   render :partial => 'index'

  end
  
  def entity
   render( :partial => 'flickr_photo', :locals => {:url => params[:url]})
  end

end
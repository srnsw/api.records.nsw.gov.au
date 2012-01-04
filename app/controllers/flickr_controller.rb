class FlickrController < ApplicationController
  def index
    
	begin
	  @photos = flickr.photos.search(:machine_tags => "srnsw.*=")
	rescue
	  @photos = Array.new
	end 
   
   render :partial => 'index'
  end
end
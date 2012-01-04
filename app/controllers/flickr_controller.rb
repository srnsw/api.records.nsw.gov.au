class FlickrController < ApplicationController
  def index
    
	begin
	  @photos = flickr.photos.search(:text => "srnsw.*")
	rescue
	  @photos = Array.new
	end 
   
   render :partial => 'index'
  end
end
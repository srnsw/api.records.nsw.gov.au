class TagsController < ApplicationController
  
  def index
	@tags = Tag.asc(:created_at).distinct(:tag)
	
	respond_to do |format|
		format.html
		format.xml {render :xml => @tags.to_xml(:only => [:tag])}
      format.json {render :json => @tags.to_json(:only => [:tag])}
	end
  end
  
  def show

    @tags = Tag.where(safe_tag: params[:id]).order_by([:created_at, :asc])
    
    #backward compatibility
    @tags = Tag.where(tag: params[:id]).order_by([:created_at, :asc]) if @tags.count == 0
    
    respond_to do |format|
		format.html
		format.xml {render :xml => @tags.to_xml(:only => [:tag, :safe_tag, :link, :title])}
      format.json {render :json => @tags.to_json(:only => [:tag, :safe_tag, :link, :title])}
	 end
  end

end
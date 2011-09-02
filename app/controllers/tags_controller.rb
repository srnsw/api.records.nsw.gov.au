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

    @tags = Tag.where(tag: params[:id]).order_by([:created_at, :asc])
    
    respond_to do |format|
		format.html
		format.xml {render :xml => @tags.to_xml(:only => [:tag])}
      format.json {render :json => @tags.to_json(:only => [:tag])}
	 end
  end

end
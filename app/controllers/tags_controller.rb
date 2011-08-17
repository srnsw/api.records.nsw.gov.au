class TagsController < ApplicationController
  
  def index
	@tags = Tag.asc(:created_at).distinct(:tag)
	
	respond_to do |format|
		format.html
	end
  end
  
  def show

    @tags = Tag.where(tag: params[:id]).order_by([:created_at, :asc])
    
    respond_to do |format|
		format.html
	 end
  end

end
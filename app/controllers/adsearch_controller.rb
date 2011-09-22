class AdsearchController < ApplicationController
  include SRNSW # lib/srnsw.rb
  include SRNSW::Utils
  
  def index
  end
  
  def show
    if params[:q]
      per_page = 20
      page = params[:page]
      page = 1 unless params[:page]
      
  		@search = Sunspot.search(Accessdirection) do
  			fulltext params[:q]
  			paginate(:page => page, :per_page => per_page)
      end
          
      @page = Kaminari.paginate_array(Array.new(@search.total)).page(params[:page]).per(20)
    end
    respond_to do |format|
      format.any
      format.yaml {render :text => @search.to_xml}
    end
  end
end

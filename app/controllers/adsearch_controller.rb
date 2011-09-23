class AdsearchController < ApplicationController
  include SRNSW::Serializers
  
  def index
  end
  
  def show
    if params[:q]
      per_page = Kaminari.config.default_per_page
      page = params[:page]
      page = 1 unless params[:page]
      
  		@search = Sunspot.search(Accessdirection) do
  			keywords(params[:q], :highlight => true)
  			paginate(:page => page, :per_page => per_page)
      end
          
      @page = Kaminari.paginate_array(Array.new(@search.total)).page(page).per(Kaminari.config.default_per_page)
      @current_page = page
    end
    respond_to do |format|
      format.any
      format.xml {render :xml => to_paginated_xml(@search.results, params[:page], @search.total)}
      format.json
    end
  end
end

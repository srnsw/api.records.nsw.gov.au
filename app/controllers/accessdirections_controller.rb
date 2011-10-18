class AccessdirectionsController <  ApplicationController

include SRNSW::Serializers

  def index
    @accessdirs = Accessdirection.page params[:page]

    respond_to do |format|
      format.html
      format.yaml {render :text => @accessdirs.to_yaml}
      format.xml {render :xml => to_paginated_xml(@accessdirs, params[:page])}
      format.json {render :json => to_paginated_json(@accessdirs, params[:page])}
    end
  end
  
  def show
    @accessdir = Accessdirection.find(params[:id])
    
    respond_to do |format|
      format.html
      format.yaml {render :text => @accessdir.to_yaml}
      format.xml {render :xml => @accessdir.to_xml}
      format.json {render :json => @accessdir.to_json}
    end
  end
  
  def search
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
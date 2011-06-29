class SeriesController < EntitiesController
  def index
    @series = pages Series
         
     respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@series)}  
      format.json {render :json => to_paginated_json(@series)}
    end
  end
  
  def show
    
	
	@series = Series.find(params[:id])
    @items_page = Item.where(:Series_number => params[:id]).paginate(:page => params[:items_page], :per_page => 5)
	
	@activities_page = @series.activities.paginate(:page => params[:activities_page], :per_page => 5)
	@controlling_agencies_page = @series.controlling_agencies.paginate(:page => params[:controlling_agencies_page], :per_page => 5)
	@creating_agencies_page = @series.creating_agencies.paginate(:page => params[:creating_agencies_page], :per_page => 5)
	@persons_page = @series.persons.paginate(:page => params[:persons_page], :per_page => 5)
	@preceding_series_page = @series.preceding_series.paginate(:page => params[:preceding_series_page], :per_page => 5)
	@related_series_page = @series.related_series.paginate(:page => params[:related_series_page], :per_page => 5)
	@succeeding_series_page = @series.succeeding_series.paginate(:page => params[:succeeding_series_page], :per_page => 5)
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @series.to_xml}
      format.json {render :json => @series.to_json}
    end
  end
end

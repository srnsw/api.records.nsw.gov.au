class SeriesController < EntitiesController
  def index
    @series = Series.pages params
         
     respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml @series}  
      format.json {render :json => to_paginated_json @series}
    end
  end
  
  def show
    
	suppage = numeric_param params[:suppage]
	
	@series = Series.find(params[:id])
  @items_page = Item.where(:Series_number => params[:id]).paginate(:page => params[:items_page], :per_page => 5)
	
	@activities_page = @series.activities.pages(params, :activities_page, 5)
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
  
  def items
   @series = Series.find(params[:id])
   @items_page = Item.where(:Series_number => params[:id]).paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @items_page.to_xml}
      format.json {render :json => @items_page.to_json}
    end
  end
  
  def agencies_creating
   @series = Series.find(params[:id])
   @creating_agencies_page = @series.creating_agencies.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @creating_agencies_page.to_xml}
      format.json {render :json => @creating_agencies_page.to_json}
    end
  end

  def agencies_controlling
   @series = Series.find(params[:id])
   @controlling_agencies_page = @series.controlling_agencies.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @controlling_agencies_page.to_xml}
      format.json {render :json => @controlling_agencies_page.to_json}
    end
  end
		
  def preceding
   @series = Series.find(params[:id])
   @preceding_series_page = @series.preceding_series.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @preceding_series_page.to_xml}
      format.json {render :json => @preceding_series_page.to_json}
    end
  end
		
  def succeeding
   @series = Series.find(params[:id])
   @succeeding_series_page = @series.succeeding_series.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @succeeding_series_page.to_xml}
      format.json {render :json => @succeeding_series_page.to_json}
    end
  end
		
  def related
   @series = Series.find(params[:id])
   @related_series_page = @series.related_series.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @related_series_page.to_xml}
      format.json {render :json => @related_series_page.to_json}
    end
  end
		
  def activities
   @series = Series.find(params[:id])
   @activities_page = @series.activities.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @activities_page.to_xml}
      format.json {render :json => @activities_page.to_json}
    end
  end
		
  def persons
   @series = Series.find(params[:id])
   @persons_page = @series.persons.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @persons_page.to_xml}
      format.json {render :json => @persons_page.to_json}
    end
  end
  
end

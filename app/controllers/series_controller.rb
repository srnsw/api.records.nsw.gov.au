class SeriesController < EntitiesController
  def index
    @series = Series.pages params
         
     respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => to_paginated_xml(@series)}  
      format.json {render :json => to_paginated_json(@series)}
    end
  end
  
  def show
	  @series = Series.find(params[:id])
	  
	  @creating_agencies = @series.creating_agencies.pages(params, :creating_agencies_page, 5)
	  @persons = @series.persons.pages(params, :persons_page, 5)
    @controlling_agencies = @series.controlling_agencies.pages(params, :controlling_agencies_page, 5)
	  
    @activities = @series.activities.pages(params, :activities_page, 5)
    
    @preceding_series = @series.preceding_series.pages(params, :preceding_series_page, 5)
	  @succeeding_series = @series.succeeding_series.pages(params, :succeeding_series_page, 5)
    @related_series = @series.related_series.pages(params, :related_series_page, 5)
    
    @items = Item.where(:Series_number => params[:id]).pages(params, :items_page, 10)
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @series.to_xml}
      format.json {render :json => @series.to_json}
    end
  end
  
  def items
    @items = Item.where(:Series_number => params[:id]).pages(params)
    respond_to do |format|
      format.any {render :action => 'items/index'}
      format.xml {render :xml => to_paginated_xml(@items)}
      format.json {render :json => to_paginated_json(@items)}
    end
  end
  
  def agencies_creating
    series = Series.find(params[:id])
    @agencies = series.creating_agencies.pages(params)
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end

  def agencies_controlling
    series = Series.find(params[:id])
    @agencies = series.controlling_agencies.pages(params)
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
		
  def preceding
    series = Series.find(params[:id])
    @series = series.preceding_series.pages(params)
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
		
  def succeeding
    series = Series.find(params[:id])
    @series = series.succeeding_series.pages(params)
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
		
  def related
    series = Series.find(params[:id])
    @series = series.related_series.pages(params)
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
		
  def activities
    series = Series.find(params[:id])
    @activities = series.activities.pages(params)
    respond_to do |format|
      format.any {render :action => 'activities/index'}
      format.xml {render :xml => to_paginated_xml(@activities)}
      format.json {render :json => to_paginated_json(@activities)}
    end
  end
		
  def persons
    series = Series.find(params[:id])
    @persons = series.persons.pages(params)
    respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
end

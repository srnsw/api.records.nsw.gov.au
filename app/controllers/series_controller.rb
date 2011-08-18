class SeriesController < EntitiesController
  
  def index
    @series = Series.page params[:page]
         
     respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}  
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
  
  def model
    Series.find(params[:id])
  end
  
  def show
	@series = Series.find(params[:id])
	  
		@creating_agencies = @series.creating_agencies.page(params[:creating_agencies_page]).per(5)
		@persons = @series.persons.page(params[:persons_page]).per(5)
    @controlling_agencies = @series.controlling_agencies.page(params[:controlling_agencies_page]).per(5)
	  
    @activities = @series.activities.page(params[:activities_page]).per(5)
    
    @preceding_series = @series.preceding_series.page(params[:preceding_series_page]).per(5)
		@succeeding_series = @series.succeeding_series.page(params[:succeeding_series_page]).per(5)
    @related_series = @series.related_series.page(params[:related_series_page]).per(5)
    @controlling_series = @series.controlling_series.page(params[:controlling_series_page]).per(5)
		@controlled_series = @series.controlled_series.page(params[:controlled_series_page]).per(5)
	
    @items = Item.where(:Series_number => params[:id]).page(params[:items_page]).per(10)

    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @series.to_xml}
      format.json {render :json => @series.to_json}
    end
  end
  
  def controlling
    series = Series.find(params[:id])
    @series = series.controlling_series.page params[:page]
    respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
  
  def controlled
    series = Series.find(params[:id])
    @series = series.controlled_series.page params[:page]
    respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
  
  def items
    @items = Item.where(:Series_number => params[:id]).page params[:page]
    respond_to do |format|
      format.any {render :action => 'items/index'}
      format.xml {render :xml => to_paginated_xml(@items, params[:page])}
      format.json {render :json => to_paginated_json(@items, params[:page])}
    end
  end
  
  def agencies_creating
    series = Series.find(params[:id])
    @agencies = series.creating_agencies.page params[:page]
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end

  def agencies_controlling
    series = Series.find(params[:id])
    @agencies = series.controlling_agencies.page params[:page]
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
		
  def preceding
    series = Series.find(params[:id])
    @series = series.preceding_series.page params[:page]
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
		
  def succeeding
    series = Series.find(params[:id])
    @series = series.succeeding_series.page params[:page]
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
		
  def related
    series = Series.find(params[:id])
    @series = series.related_series.page params[:page]
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
		
  def activities
    series = Series.find(params[:id])
    @activities = series.activities.page params[:page]
    respond_to do |format|
      format.any {render :action => 'activities/index'}
      format.xml {render :xml => to_paginated_xml(@activities, params[:page])}
      format.json {render :json => to_paginated_json(@activities, params[:page])}
    end
  end
		
  def persons
    series = Series.find(params[:id])
    @persons = series.persons.page params[:page]
    respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
end

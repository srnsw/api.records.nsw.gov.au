class AgenciesController < EntitiesController
  def index
    @agencies = Agency.page params[:page]
    
    respond_to do |format|
      format.any
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def model
  	 Agency.find(params[:id])
  end
  
  def show
    @agency = Agency.find(params[:id])
    
    @preceding = @agency.preceding.page( params[:preceding_page]).per(5)
    @succeeding = @agency.succeeding.page( params[:succeeding_page]).per(5)
    @superiors = @agency.superiors.page( params[:superiors_page]).per(5)
    @subordinates = @agency.subordinates.page( params[:subordinates_page]).per(5)
    @related = @agency.related.page( params[:related_page]).per(5)
	    
    @organisations = @agency.organisations.page( params[:organisations_page]).per(5)
    @persons = @agency.persons.page( params[:persons_page]).per(5)
    
    @functions = @agency.functions.page( params[:functions_page]).per(5)
        
    @series_created = @agency.series_created.page( params[:series_created_page]).per(5)
    @series_controlled = @agency.series_controlled.page( params[:series_controlled_page]).per(5)

    respond_to do |format|
      format.any
      format.oai_dc
      format.xml {render :xml => @agency.to_xml}
      format.json {render :json => @agency.to_json}
    end
  end
  
  
  def preceding
    agency = Agency.find(params[:id])
	  @agencies = agency.preceding.page params[:page]
	
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def succeeding
    agency = Agency.find(params[:id])
    @agencies = agency.succeeding.page params[:page]
    
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def superior
    agency = Agency.find(params[:id])
    @agencies = agency.superiors.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def subordinate
    agency = Agency.find(params[:id])
    @agencies = agency.subordinates.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def related
    agency = Agency.find(params[:id])
    @agencies = agency.related.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def functions
    agency = Agency.find(params[:id])
    @functions = agency.functions.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'functions/index'}
      format.xml {render :xml => to_paginated_xml(@functions, params[:page])}
      format.json {render :json => to_paginated_json(@functions, params[:page])}
    end
  end
  
  def organisations
    agency = Agency.find(params[:id])
    @organisations = agency.organisations.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'organisations/index'}
      format.xml {render :xml => to_paginated_xml(@organisations, params[:page])}
      format.json {render :json => to_paginated_json(@organisations, params[:page])}
    end
  end
  
  def persons
    agency = Agency.find(params[:id])
    @persons = agency.persons.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
  
  def series_created
    agency = Agency.find(params[:id])
    @series = agency.series_created.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
  
  def series_controlled
    agency = Agency.find(params[:id])
    @series = agency.series_controlled.page params[:page]
  
	  respond_to do |format|
      format.any {render :action => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
end

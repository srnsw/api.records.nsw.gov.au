class AgenciesController < EntitiesController
  def index
    @agencies = Agency.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def show
    @agency = Agency.find(params[:id])
    
    @preceding = @agency.preceding.pages(params, :preceding_page, 5)
    @succeeding = @agency.succeeding.pages(params, :succeeding_page, 5)
    @superiors = @agency.superiors.pages(params, :superiors_page, 5)
    @subordinates = @agency.subordinates.pages(params, :subordinates_page, 5)
    @related = @agency.related.pages(params, :related_page, 5)
	    
    @organisations = @agency.organisations.pages(params, :organisations_page, 5)
    @persons = @agency.persons.pages(params, :persons_page, 5)
    
    @functions = @agency.functions.pages(params, :functions_page, 5)
        
    @series_created = @agency.series_created.pages(params, :series_created_page, 5)
    @series_controlled = @agency.series_controlled.pages(params, :series_controlled_page, 5)

    respond_to do |format|
      format.html
      format.oai_dc
      format.xml {render :xml => @agency.to_xml}
      format.json {render :json => @agency.to_json}
    end
  end
  
  
  def preceding
    agency = Agency.find(params[:id])
	  @agencies = agency.preceding.pages(params)
	
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def succeeding
    agency = Agency.find(params[:id])
    @agencies = agency.succeeding.pages(params)
    
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def superior
    agency = Agency.find(params[:id])
    @agencies = agency.superiors.pages(params)
  
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def subordinate
    agency = Agency.find(params[:id])
    @agencies = agency.subordinates.pages(params)
  
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def related
    agency = Agency.find(params[:id])
    @agencies = agency.related.pages(params)
  
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def functions
    agency = Agency.find(params[:id])
    @functions = agency.functions.pages(params)
  
	  respond_to do |format|
      format.html {render :template => 'functions/index'}
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
    end
  end
  
  def organisations
    agency = Agency.find(params[:id])
    @organisations = agency.organisations.pages(params)
  
	  respond_to do |format|
      format.html {render :template => 'organisations/index'}
      format.xml {render :xml => to_paginated_xml(@organisations)}
      format.json {render :json => to_paginated_json(@organisations)}
    end
  end
  
  def persons
    agency = Agency.find(params[:id])
    @persons = agency.persons.pages(params)
  
	  respond_to do |format|
      format.html {render :template => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
  
  def series_created
    agency = Agency.find(params[:id])
    @series = agency.series_created.pages(params)
  
	  respond_to do |format|
      format.html {render :template => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
  
  def series_controlled
    agency = Agency.find(params[:id])
    @series = agency.series_controlled.pages(params)
  
	  respond_to do |format|
      format.html {render :template => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
end

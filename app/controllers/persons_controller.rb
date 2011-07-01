class PersonsController < EntitiesController
  def index
    @persons = Person.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
  
  def show
    @person = Person.find(params[:id])
    
    @agencies = @person.agencies.pages(params, :agencies_page, 5)
    @ministries = @person.ministries.pages(params, :ministries_page, 5)
    @portfolios = @person.portfolios.pages(params, :portfolios_page, 5)
    @functions = @person.functions.pages(params, :functions_page, 5)
    @series = @person.series.paginate(params, :series_page, 10)
  
    respond_to do |format|
      format.html
      format.xml {render :xml => @person.to_xml}
      format.json {render :json => @person.to_json}
    end
  end
  
   def functions
     person = Person.find(params[:id])
     @functions = person.functions.pages(params)
     respond_to do |format|
        format.html {render :template => 'functions/index'}
        format.xml {render :xml => to_paginated_xml(@functions)}
        format.json {render :json => to_paginated_json(@functions)}
      end
  end
  
   def agencies
     person = Person.find(params[:id])
     @agencies = person.agencies.pages(params)
     respond_to do |format|
        format.html {render :template => 'agencies/index'}
        format.xml {render :xml => to_paginated_xml(@agencies)}
        format.json {render :json => to_paginated_json(@agencies)}
      end
  end
  
  def portfolios
    person = Person.find(params[:id])
    @portfolios = person.portfolios.pages(params)
    respond_to do |format|
      format.html {render :template => 'portfolios/index'}
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
  
  def ministries
    person = Person.find(params[:id])
    @ministries = person.ministries.pages(params)
    respond_to do |format|
      format.html {render :template => 'ministries/index'}
      format.xml {render :xml => to_paginated_xml(@ministries)}
      format.json {render :json => to_paginated_json(@ministries)}
    end
  end
  
  def series
    person = Person.find(params[:id])
    @series = person.series.pages(params)
    respond_to do |format|
      format.html {render :template => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
end

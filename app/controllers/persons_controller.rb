class PersonsController < EntitiesController
  def index
    @persons = Person.page params[:page]
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
  
  def model
	Person.find(params[:id])
  end
  
  def show
    @person = Person.find(params[:id])
    
    @agencies = @person.agencies.page(params[:agencies_page]).per(5)
    @ministries = @person.ministries.page(params[:ministries_page]).per(5)
    @portfolios = @person.portfolios.page(params[:portfolios_page]).per(5)
    @functions = @person.functions.page(params[:functions_page]).per(5)
    @series = @person.series.page(params[:series_page]).per(10)

    respond_to do |format|
      format.html
      format.xml {render :xml => @person.to_xml}
      format.json {render :json => @person.to_json}
    end
  end
  
   def functions
     person = Person.find(params[:id])
     @functions = person.functions.page params[:page]
     respond_to do |format|
        format.any {render :action => 'functions/index'}
        format.xml {render :xml => to_paginated_xml(@functions, params[:page])}
        format.json {render :json => to_paginated_json(@functions, params[:page])}
      end
  end
  
   def agencies
     person = Person.find(params[:id])
     @agencies = person.agencies.page params[:page]
     respond_to do |format|
        format.any {render :action => 'agencies/index'}
        format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
        format.json {render :json => to_paginated_json(@agencies, params[:page])}
      end
  end
  
  def portfolios
    person = Person.find(params[:id])
    @portfolios = person.portfolios.page params[:page]
    respond_to do |format|
      format.any {render :action => 'portfolios/index'}
      format.xml {render :xml => to_paginated_xml(@portfolios, params[:page])}
      format.json {render :json => to_paginated_json(@portfolios, params[:page])}
    end
  end
  
  def ministries
    person = Person.find(params[:id])
    @ministries = person.ministries.page params[:page]
    respond_to do |format|
      format.any {render :action => 'ministries/index'}
      format.xml {render :xml => to_paginated_xml(@ministries, params[:page])}
      format.json {render :json => to_paginated_json(@ministries, params[:page])}
    end
  end
  
  def series
    person = Person.find(params[:id])
    @series = person.series.page params[:page]
    respond_to do |format|
      format.any {render :action => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series, params[:page])}
      format.json {render :json => to_paginated_json(@series, params[:page])}
    end
  end
end

class PersonsController < EntitiesController
  def index
    @persons = pages Person
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
  
  def show
    @person = Person.find(params[:id])
    
	@functions_page = @person.functions.paginate(:page => params[:functions_page], :per_page => 5)
	@agencies_page = @person.agencies.paginate(:page => params[:agencies_page], :per_page => 5)
	@portfolios_page = @person.portfolios.paginate(:page => params[:portfolios_page], :per_page => 5)
	@ministries_page = @person.ministries.paginate(:page => params[:ministries_page], :per_page => 5)
	@series_page = @person.series.paginate(:page => params[:series_page], :per_page => 10)
  
    respond_to do |format|
      format.html
      format.xml {render :xml => @person.to_xml}
      format.json {render :json => @person.to_json}
    end
  end
end

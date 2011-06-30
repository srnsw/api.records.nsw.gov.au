class PersonsController < EntitiesController
  def index
    @persons = Person.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @persons.to_xml}
      format.json {render :json => @persons.to_json}
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
  
   def functions
   @person = Person.find(params[:id])
   @functions_page = @person.functions.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @functions_page.to_xml}
      format.json {render :json => @functions_page.to_json}
    end
  end
  
   def agencies
   @person = Person.find(params[:id])
   	@agencies_page = @person.agencies.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @agencies_page.to_xml}
      format.json {render :json => @agencies_page.to_json}
    end
  end
  
  def portfolios
   @person = Person.find(params[:id])
   @portfolios_page = @person.portfolios.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @portfolios_page.to_xml}
      format.json {render :json => @portfolios_page.to_json}
    end
  end
  
   def ministries
   @person = Person.find(params[:id])
   @ministries_page = @person.ministries.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @ministries_page.to_xml}
      format.json {render :json => @ministries_page.to_json}
    end
  end
  
   def series
   @person = Person.find(params[:id])
   @series_page = @person.series.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @series_page.to_xml}
      format.json {render :json => @series_page.to_json}
    end
  end
end

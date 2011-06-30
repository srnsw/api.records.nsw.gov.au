class FunctionsController < EntitiesController
  def index
    @functions = Function.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @functions.to_xml}
      format.json {render :json => @functions.to_json}
    end
  end
  
  def show
    @function = Function.find(params[:id])
    @activities_page = @function.activities.paginate(:page => params[:activities_page], :per_page => 5)
	@agencies_page = @function.agencies.paginate(:page => params[:agencies_page], :per_page => 5)
	@persons_page = @function.persons.paginate(:page => params[:persons_page], :per_page => 5)
	
    respond_to do |format|
      format.html
      format.xml {render :xml => @function.to_xml}
      format.json {render :json => @function.to_json}
    end
  end
  
  def agencies
   @function = Function.find(params[:id])
   @agencies_page = @function.agencies.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @agencies_page.to_xml}
      format.json {render :json => @agencies_page.to_json}
    end
  end
  
  def persons
   @function = Function.find(params[:id])
   @persons_page = @function.persons.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @persons_page.to_xml}
      format.json {render :json => @persons_page.to_json}
    end
  end
  
  def activities
   @function = Function.find(params[:id])
   @activities_page = @function.activities.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @activities_page.to_xml}
      format.json {render :json => @activities_page.to_json}
    end
  end
end

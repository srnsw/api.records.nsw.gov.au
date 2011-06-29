class FunctionsController < EntitiesController
  def index
    @functions = pages Function
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
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
end

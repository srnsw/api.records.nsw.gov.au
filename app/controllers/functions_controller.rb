class FunctionsController < EntitiesController
  def index
    @functions = Function.page params[:page]
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@functions, params[:page])}
      format.json {render :json => to_paginated_json(@functions, params[:page])}
    end
  end
  
  def model
  	 Function.find(params[:id])
  end
  
  def show
    @function = Function.find(params[:id])
    
    @activities = @function.activities.page(params[:activities_page]).per(5)
	  @agencies = @function.agencies.page(params[:agencies_page]).per(5)
	  @persons = @function.persons.page(params[:persons_page]).per(5)
	

    respond_to do |format|
      format.html
      format.xml {render :xml => @function.to_xml}
      format.json {render :json => @function.to_json}
    end
  end
  
  def agencies
   function = Function.find(params[:id])
   @agencies = function.agencies.page params[:page]
   respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def persons
   function = Function.find(params[:id])
   @persons = function.persons.page params[:page]
   respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
  
  def activities
   function = Function.find(params[:id])
   @activities = function.activities.page params[:page]
   respond_to do |format|
      format.any {render :action => 'activities/index'}
      format.xml {render :xml => to_paginated_xml(@activities, params[:page])}
      format.json {render :json => to_paginated_json(@activities, params[:page])}
    end
  end
end

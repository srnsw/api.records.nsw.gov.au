class FunctionsController < EntitiesController
  def index
    @functions = Function.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
    end
  end
  
  def show
    @function = Function.find(params[:id])
    
    @activities = @function.activities.pages(params, :activities_page, 5)
	  @agencies = @function.agencies.pages(params, :agencies_page, 5)
	  @persons = @function.persons.pages(params, :persons_page, 5)
	
    respond_to do |format|
      format.html
      format.xml {render :xml => @function.to_xml}
      format.json {render :json => @function.to_json}
    end
  end
  
  def agencies
   function = Function.find(params[:id])
   @agencies = function.agencies.pages(params)
   respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def persons
   function = Function.find(params[:id])
   @persons = function.persons.pages(params)
   respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
  
  def activities
   function = Function.find(params[:id])
   @activities = function.activities.pages(params)
   respond_to do |format|
      format.any {render :action => 'activities/index'}
      format.xml {render :xml => to_paginated_xml(@activities)}
      format.json {render :json => to_paginated_json(@activities)}
    end
  end
end

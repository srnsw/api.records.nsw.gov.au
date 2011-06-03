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
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @person.to_xml}
      format.json {render :json => @person.to_json}
    end
  end
end

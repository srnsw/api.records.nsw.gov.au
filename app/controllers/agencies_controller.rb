class AgenciesController < EntitiesController
  def index
    @agencies = pages Agency
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def show
    @agency = Agency.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @agency.to_xml}
      format.json {render :json => @agency.to_json}
    end
  end
end

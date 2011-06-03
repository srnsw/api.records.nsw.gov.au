class OrganisationsController < EntityController
  def index
    @organisations = pages Organisation
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@organisations)}
      format.json {render :json => to_paginated_json(@organisations)}
    end
  end
  
  def show
    @organisation = Organisation.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @organisation.to_xml}
      format.json {render :json => @organisation.to_json}
    end
  end
end

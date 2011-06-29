class OrganisationsController < EntitiesController
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
    
	@agencies_page = @organisation.agencies.paginate(:page => params[:agencies_page], :per_page => 15)
	@preceding_page =  @organisation.preceding.paginate(:page => params[:preceding_page], :per_page => 5)
	@succeeding_page =  @organisation.succeeding.paginate(:page => params[:succeeding_page], :per_page => 5)
	
    respond_to do |format|
      format.html
      format.xml {render :xml => @organisation.to_xml}
      format.json {render :json => @organisation.to_json}
    end
  end
end

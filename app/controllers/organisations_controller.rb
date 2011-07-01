class OrganisationsController < EntitiesController
  def index
    @organisations = Organisation.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@organisations)}
      format.json {render :json => to_paginated_json(@organisations)}
    end
  end
  
  def show
    @organisation = Organisation.find(params[:id])
    
	  @preceding = @organisation.preceding.pages(params, :preceding_page, 5)
	  @succeeding = @organisation.succeeding.pages(params, :succeeding_page, 5)
    @agencies = @organisation.agencies.pages(params, :agencies_page, 15)
	
    respond_to do |format|
      format.html
      format.xml {render :xml => @organisation.to_xml}
      format.json {render :json => @organisation.to_json}
    end
  end
  
  
  def preceding
    organisation = Organisation.find(params[:id])
    @organisations = organisation.preceding.pages(params)
	
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@organisations)}
      format.json {render :json => to_paginated_json(@organisations)}
    end
  end
  
  def succeeding
    organisation = Organisation.find(params[:id])
    @organisations = organisation.succeeding.pages(params)
	
	  respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@organisations)}
      format.json {render :json => to_paginated_json(@organisations)}
    end
  end

  def agencies
   organisation = Organisation.find(params[:id])
   @agencies = organisation.agencies.pages(params)
   
   respond_to do |format|
      format.html {render :template => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
end

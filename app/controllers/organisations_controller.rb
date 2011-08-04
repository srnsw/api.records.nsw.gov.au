class OrganisationsController < EntitiesController
  def index
    @organisations = Organisation.page params[:page]
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@organisations, params[:page])}
      format.json {render :json => to_paginated_json(@organisations, params[:page])}
    end
  end
  
  def show
    @organisation = Organisation.find(params[:id])
    
	  @preceding = @organisation.preceding.page params[:preceding_page]
	  @succeeding = @organisation.succeeding.page params[:succeeding_page]
    @agencies = @organisation.agencies.page params[:agencies_page]

    respond_to do |format|
      format.html
      format.xml {render :xml => @organisation.to_xml}
      format.json {render :json => @organisation.to_json}
    end
  end
  
  
  def preceding
    organisation = Organisation.find(params[:id])
    @organisations = organisation.preceding.page params[:page]
	
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@organisations, params[:page])}
      format.json {render :json => to_paginated_json(@organisations, params[:page])}
    end
  end
  
  def succeeding
    organisation = Organisation.find(params[:id])
    @organisations = organisation.succeeding.page params[:page]
	
	  respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@organisations, params[:page])}
      format.json {render :json => to_paginated_json(@organisations, params[:page])}
    end
  end

  def agencies
   organisation = Organisation.find(params[:id])
   @agencies = organisation.agencies.page params[:page]
   
   respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
end

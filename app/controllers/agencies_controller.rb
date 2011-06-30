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
    @functions_page = @agency.functions.paginate(:page => params[:functions_page], :per_page => 5)
	@organisations_page = @agency.organisations.paginate(:page => params[:organisations_page], :per_page => 5)
	@persons_page = @agency.persons.paginate(:page => params[:persons_page], :per_page => 5)
	@preceding_page = @agency.preceding.paginate(:page => params[:preceding_page], :per_page => 5)
	@related_page = @agency.related.paginate(:page => params[:related_page], :per_page => 5)
	@series_controlled_page = @agency.series_controlled.paginate(:page => params[:series_controlled_page], :per_page => 5)
	@series_created_page = @agency.series_created.paginate(:page => params[:series_created_page], :per_page => 5)
	@subordinates_page = @agency.subordinates.paginate(:page => params[:subordinates_page], :per_page => 5)
	@succeeding_page = @agency.succeeding.paginate(:page => params[:succeeding_page], :per_page => 5)
	@superiors_page = @agency.superiors.paginate(:page => params[:superiors_page], :per_page => 5)

    respond_to do |format|
      format.html
      format.oai_dc
      format.xml {render :xml => @agency.to_xml}
      format.json {render :json => @agency.to_json}
    end
  end
end

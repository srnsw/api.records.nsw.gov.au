class AgenciesController < EntitiesController
  def index
    @agencies = Agency.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @agencies.to_xml}
      format.json {render :json => @agencies.to_json}
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
      format.xml {render :xml => @agency.to_xml}
      format.json {render :json => @agency.to_json}
    end
  end
  
  
  def preceding
    @agency = Agency.find(params[:id])
	@preceding_page = @agency.preceding.paginate(:page => params[:page], :per_page => 25)
	
	respond_to do |format|
      format.html
      format.xml {render :xml => @preceding_page.to_xml}
      format.json {render :json => @preceding_page.to_json}
    end
  end
  
  def succeeding
    @agency = Agency.find(params[:id])
    @succeeding_page = @agency.succeeding.paginate(:page => params[:page], :per_page => 25)
	respond_to do |format|
      format.html
      format.xml {render :xml => @succeeding_page.to_xml}
      format.json {render :json => @succeeding_page.to_json}
    end
  end
  
  def superior
    @agency = Agency.find(params[:id])
    @superiors_page = @agency.superiors.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @superiors_page.to_xml}
      format.json {render :json => @superiors_page.to_json}
    end
  end
  
  def subordinate
    @agency = Agency.find(params[:id])
    @subordinates_page = @agency.subordinates.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @subordinates_page.to_xml}
      format.json {render :json => @subordinates_page.to_json}
    end
  end
  
  def related
    @agency = Agency.find(params[:id])
    @related_page = @agency.related.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @related_page.to_xml}
      format.json {render :json => @related_page.to_json}
    end
  end
  
  def functions
    @agency = Agency.find(params[:id])
    @functions_page = @agency.functions.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @functions_page.to_xml}
      format.json {render :json => @functions_page.to_json}
    end
  end
  
  def organisations
    @agency = Agency.find(params[:id])
    @organisations_page = @agency.organisations.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @organisations_page.to_xml}
      format.json {render :json => @organisations_page.to_json}
    end
  end
  
  def persons
    @agency = Agency.find(params[:id])
    @persons_page = @agency.persons.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @persons_page.to_xml}
      format.json {render :json => @persons_page.to_json}
    end
  end
  
  def series_created
    @agency = Agency.find(params[:id])
    @series_created_page = @agency.series_created.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @series_created_page.to_xml}
      format.json {render :json => @series_created_page.to_json}
    end
  end
  
  def series_controlled
    @agency = Agency.find(params[:id])
    @series_controlled_page = @agency.series_controlled.paginate(:page => params[:page], :per_page => 25)
  
	respond_to do |format|
      format.html
      format.xml {render :xml => @series_controlled_page.to_xml}
      format.json {render :json => @series_controlled_page.to_json}
    end
  end
end

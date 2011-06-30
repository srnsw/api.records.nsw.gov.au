class OrganisationsController < EntitiesController
  def index
    @organisations = Organisation.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @organisations.to_xml}
      format.json {render :json => @organisations.to_json}
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
  
  
  def preceding
    @organisation = Organisation.find(params[:id])
    @preceding_page = @organisation.preceding.paginate(:page => params[:page], :per_page => 25)
	
	respond_to do |format|
      format.html
      format.xml {render :xml => @preceding_page.to_xml}
      format.json {render :json => @preceding_page.to_json}
    end
  end
  
  def succeeding
    @organisation = Organisation.find(params[:id])
    @succeeding_page = @organisation.succeeding.paginate(:page => params[:page], :per_page => 25)
	
	respond_to do |format|
      format.html
      format.xml {render :xml => @succeeding_page.to_xml}
      format.json {render :json => @succeeding_page.to_json}
    end
  end

  def agencies
   @organisation = Organisation.find(params[:id])
   @agencies_page = @organisation.agencies.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @agencies_page.to_xml}
      format.json {render :json => @agencies_page.to_json}
    end
  end
end

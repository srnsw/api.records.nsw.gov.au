class MinistriesController < EntitiesController
  def index
    @ministries = Ministry.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @ministries.to_xml}
      format.json {render :json => @ministries.to_json}
    end
  end
  
  def show
    @ministry = Ministry.find(params[:id])
    @portfolios_page = @ministry.portfolios.paginate(:page => params[:portfolios_page], :per_page => 10)
		
    respond_to do |format|
      format.html
      format.xml {render :xml => @ministry.to_xml}
      format.json {render :json => @ministry.to_json}
    end
  end
  
  def portfolios
    @ministry = Ministry.find(params[:id])
    @portfolios_page = @ministry.portfolios.paginate(:page => params[:page], :per_page => 25)
		
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolios_page.to_xml}
      format.json {render :json => @portfolios_page.to_json}
    end
  end
end

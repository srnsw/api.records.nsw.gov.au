class PortfoliosController < EntitiesController
  def index
    @portfolios = Portfolio.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolios.to_xml}
      format.json {render :json => @portfolios.to_json}
    end
  end
  
  def show
  
  suppage = numeric_param params[:suppage]
  
    @portfolio = Portfolio.find(params[:id])
	@agencies_page = @portfolio.agencies.paginate(:page => params[:agencies_page], :per_page => 5)
	@persons_page = @portfolio.persons.paginate(:page => params[:persons_page], :per_page => 5)
	@ministries_page = @portfolio.ministries.paginate(:page => params[:ministries_page], :per_page => 5)
	@preceding_page = @portfolio.preceding.paginate(:page => params[:preceding_page], :per_page => 5)
	@succeeding_page = @portfolio.succeeding.paginate(:page => params[:succeeding_page], :per_page => 5)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolio.to_xml}
      format.json {render :json => @portfolio.to_json}
    end
  end
  
  def ministries
    @portfolio = Portfolio.find(params[:id])
    @ministries_page = @portfolio.ministries.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html
      format.xml {render :xml => @ministries_page.to_xml}
      format.json {render :json => @ministries_page.to_json}
    end
  end
  
  def agencies
    @portfolio = Portfolio.find(params[:id])
    @agencies_page = @portfolio.agencies.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html
      format.xml {render :xml => @agencies_page.to_xml}
      format.json {render :json => @agencies_page.to_json}
    end
  end
  
  def persons
    @portfolio = Portfolio.find(params[:id])
    @persons_page = @portfolio.persons.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html
      format.xml {render :xml => @persons_page.to_xml}
      format.json {render :json => @persons_page.to_json}
    end
  end
  
  def preceding
    @portfolio = Portfolio.find(params[:id])
    @preceding_page = @portfolio.preceding.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html
      format.xml {render :xml => @preceding_page.to_xml}
      format.json {render :json => @preceding_page.to_json}
    end
  end
  
  def succeeding
    @portfolio = Portfolio.find(params[:id])
    @succeeding_page = @portfolio.succeeding.paginate(:page => params[:page], :per_page => 25)
    respond_to do |format|
      format.html
      format.xml {render :xml => @succeeding_page.to_xml}
      format.json {render :json => @succeeding_page.to_json}
    end
  end
  
end

class PortfoliosController < EntitiesController
  def index
    @portfolios = pages Portfolio
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
  
  def show
  
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
end

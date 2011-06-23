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
	@agencies_page = pages @portfolio.agencies, 5
	@persons_page = pages @portfolio.persons, 5
	@ministries_page = pages @portfolio.ministries, 5
	@preceding_page = pages @portfolio.preceding, 5
	@succeeding_page = pages @portfolio.succeeding, 5
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolio.to_xml}
      format.json {render :json => @portfolio.to_json}
    end
  end
end

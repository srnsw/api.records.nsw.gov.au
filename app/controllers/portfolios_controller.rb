class PortfoliosController < EntityController
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
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolio.to_xml}
      format.json {render :json => @portfolio.to_json}
    end
  end
end

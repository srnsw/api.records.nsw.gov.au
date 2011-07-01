class PortfoliosController < EntitiesController
  def index
    @portfolios = Portfolio.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
  
  def show
    @portfolio = Portfolio.find(params[:id])
    
    @preceding = @portfolio.preceding.pages(params, :preceding_page, 5)
    @succeeding = @portfolio.succeeding.pages(params, :succeeding_page, 5)
    @ministries = @portfolio.ministries.pages(params, :ministries_page, 5)
    @persons = @portfolio.persons.pages(params, :persons_page, 5)
    @agencies = @portfolio.agencies.pages(params, :agencies_page, 5)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolio.to_xml}
      format.json {render :json => @portfolio.to_json}
    end
  end
  
  def ministries
    portfolio = Portfolio.find(params[:id])
    @ministries = portfolio.ministries.pages(params)
    
    respond_to do |format|
      format.html {render :template => 'ministries/index'}
      format.xml {render :xml => to_paginated_xml(@ministries)}
      format.json {render :json => to_paginated_json(@ministries)}
    end
  end
  
  def agencies
    portfolio = Portfolio.find(params[:id])
    @agencies = portfolio.agencies.pages(params)
    
    respond_to do |format|
      format.html {render :template => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
  
  def persons
    portfolio = Portfolio.find(params[:id])
    @persons = portfolio.persons.pages(params)
    
    respond_to do |format|
      format.html {render :template => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
  
  def preceding
    portfolio = Portfolio.find(params[:id])
    @portfolios = portfolio.preceding.pages(params)
    
    respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
  
  def succeeding
    portfolio = Portfolio.find(params[:id])
    @portfolios = portfolio.succeeding.pages(params)
    
    respond_to do |format|
      format.html {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
end

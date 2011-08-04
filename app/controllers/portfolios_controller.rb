class PortfoliosController < EntitiesController
  def index
    @portfolios = Portfolio.page params[:page]
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@portfolios, params[:page])}
      format.json {render :json => to_paginated_json(@portfolios, params[:page])}
    end
  end
  
  def show
    @portfolio = Portfolio.find(params[:id])
    
    @preceding = @portfolio.preceding.page(params[:preceding_page]).per(5)
    @succeeding = @portfolio.succeeding.page(params[:succeeding_page]).per(5)
    @ministries = @portfolio.ministries.page(params[:ministries_page]).per(5)
    @persons = @portfolio.persons.page(params[:persons_page]).per(5)
    @agencies = @portfolio.agencies.page(params[:agencies_page]).per(5)

    respond_to do |format|
      format.html
      format.xml {render :xml => @portfolio.to_xml}
      format.json {render :json => @portfolio.to_json}
    end
  end
  
  def ministries
    portfolio = Portfolio.find(params[:id])
    @ministries = portfolio.ministries.page params[:page]
    
    respond_to do |format|
      format.any {render :action => 'ministries/index'}
      format.xml {render :xml => to_paginated_xml(@ministries, params[:page])}
      format.json {render :json => to_paginated_json(@ministries, params[:page])}
    end
  end
  
  def agencies
    portfolio = Portfolio.find(params[:id])
    @agencies = portfolio.agencies.page params[:page]
    
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
  
  def persons
    portfolio = Portfolio.find(params[:id])
    @persons = portfolio.persons.page params[:page]
    
    respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
  
  def preceding
    portfolio = Portfolio.find(params[:id])
    @portfolios = portfolio.preceding.page params[:page]
    
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@portfolios, params[:page])}
      format.json {render :json => to_paginated_json(@portfolios, params[:page])}
    end
  end
  
  def succeeding
    portfolio = Portfolio.find(params[:id])
    @portfolios = portfolio.succeeding.page params[:page]
    
    respond_to do |format|
      format.any {render :action => 'index'}
      format.xml {render :xml => to_paginated_xml(@portfolios, params[:page])}
      format.json {render :json => to_paginated_json(@portfolios, params[:page])}
    end
  end
end

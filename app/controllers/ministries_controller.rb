class MinistriesController < EntitiesController
  def index
    @ministries = Ministry.pages(params)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@ministries)}
      format.json {render :json => to_paginated_json(@ministries)}
    end
  end
  
  def show
    @ministry = Ministry.find(params[:id])
    @portfolios = @ministry.portfolios.pages(params, :portfolios_page, 10)
		
    respond_to do |format|
      format.html
      format.xml {render :xml => @ministry.to_xml}
      format.json {render :json => @ministry.to_json}
    end
  end
  
  def portfolios	
	ministry = Ministry.find(params[:id])
    @portfolios = ministry.portfolios.pages(params)
	
    respond_to do |format|
      format.html {render :template => 'portfolios/index'}
      format.xml {render :xml => to_paginated_xml(@portfolios)}
      format.json {render :json => to_paginated_json(@portfolios)}
    end
  end
end

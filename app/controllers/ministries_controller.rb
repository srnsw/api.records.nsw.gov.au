class MinistriesController < EntitiesController
  def index
    @ministries = Ministry.page params[:page]
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@ministries, params[:page])}
      format.json {render :json => to_paginated_json(@ministries, params[:page])}
    end
  end
  
  def model
    Ministry.find(params[:id])
  end 
  
  def show
    @ministry = Ministry.find(params[:id])
    @portfolios = @ministry.portfolios.page(params[:portfolios_page]).per(10)

    respond_to do |format|
      format.html
      format.xml {render :xml => @ministry.to_xml}
      format.json {render :json => @ministry.to_json}
    end
  end
  
  def portfolios	
	ministry = Ministry.find(params[:id])
    @portfolios = ministry.portfolios.page params[:page]
	
    respond_to do |format|
      format.any {render :action => 'portfolios/index'}
      format.xml {render :xml => to_paginated_xml(@portfolios, params[:page])}
      format.json {render :json => to_paginated_json(@portfolios, params[:page])}
    end
  end
end

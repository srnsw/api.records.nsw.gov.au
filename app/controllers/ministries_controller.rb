class MinistriesController < EntitiesController
  def index
    @ministries = pages Ministry
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@ministries)}
      format.json {render :json => to_paginated_json(@ministries)}
    end
  end
  
  def show
    @ministry = Ministry.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @ministry.to_xml}
      format.json {render :json => @ministry.to_json}
    end
  end
end

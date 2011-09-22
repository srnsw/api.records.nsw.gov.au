class AccessdirectionsController <  ApplicationController

include SRNSW::Serializers

  def index
    @accessdirs = Accessdirection.page params[:page]

    respond_to do |format|
      format.html
      format.yaml {render :text => @accessdirs.to_yaml}
      format.xml {render :xml => to_paginated_xml(@accessdirs, params[:page])}
      format.json {render :json => to_paginated_json(@accessdirs, params[:page])}
    end
  end
  
  def show
    @accessdir = Accessdirection.find(params[:id])
    
    respond_to do |format|
      format.html
      format.yaml {render :text => @accessdir.to_yaml}
      format.xml {render :xml => @accessdir.to_xml}
      format.json {render :json => @accessdir.to_json}
    end
  end
end
class FunctionsController < EntityController
  def index
    @functions = pages Function
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
    end
  end
  
  def show
    @function = Function.find(params[:id])
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @function.to_xml}
      format.json {render :json => @function.to_json}
    end
  end
end

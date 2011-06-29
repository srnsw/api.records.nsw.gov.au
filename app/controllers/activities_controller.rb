class ActivitiesController < EntitiesController
  def index
    
    @activities = pages Activity
	respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@activities)}
      format.json {render :json => to_paginated_json(@activities)}
    end
  end
  
  def show
  
  @activity = Activity.find(params[:id])
  @series_page = @activity.series.paginate(:page => params[:series_page], :per_page => 10)
  @functions_page = @activity.functions.paginate(:page => params[:functions_page], :per_page => 10)
	
    respond_to do |format|
      format.html
      format.xml {render :xml => @activity.to_xml}
      format.json {render :json => @activity.to_json}
    end
  end
end

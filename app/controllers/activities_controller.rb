class ActivitiesController < EntityController
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
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @activity.to_xml}
      format.json {render :json => @activity.to_json}
    end
  end
end

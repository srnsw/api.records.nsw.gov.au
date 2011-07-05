class ActivitiesController < EntitiesController
  def index
    @activities = Activity.pages(params)
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@activities)}
      format.json {render :json => to_paginated_json(@activities)}
    end
  end
  
  def show
    @activity = Activity.find(params[:id])
    @functions = @activity.functions.pages(params, :functions_page, 5)
    @series = @activity.series.pages(params, :series_page, 10)

    respond_to do |format|
      format.html
      format.xml {render :xml => @activity.to_xml}
      format.json {render :json => @activity.to_json}
    end
  end
  
  def functions
    activity = Activity.find(params[:id])
    @functions = activity.functions.pages(params)
    respond_to do |format|
      format.any {render :action => 'functions/index'}
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
    end
  end
  
  def series
    activity = Activity.find(params[:id])
    @series = activity.series.pages(params)
    respond_to do |format|
      format.any {render :action => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
end

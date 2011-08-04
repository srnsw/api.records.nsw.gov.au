class ActivitiesController < EntitiesController
  def index
    @activities = Activity.page params[:page]
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@activities, params[:page])}
      format.json {render :json => to_paginated_json(@activities, params[:page])}
    end
  end
  
  def show
    @activity = Activity.find(params[:id])
    @functions = @activity.functions.page(params[:functions_page]).per(5)
    @series = @activity.series.page(params[:series_page]).per(10)
  
    respond_to do |format|
      format.html
      format.xml {render :xml => @activity.to_xml}
      format.json {render :json => @activity.to_json}
    end
  end
  
  def functions
    activity = Activity.find(params[:id])
    @functions = activity.functions.page
    respond_to do |format|
      format.any {render :action => 'functions/index'}
      format.xml {render :xml => to_paginated_xml(@functions)}
      format.json {render :json => to_paginated_json(@functions)}
    end
  end
  
  def series
    activity = Activity.find(params[:id])
    @series = activity.series.page
    respond_to do |format|
      format.any {render :action => 'series/index'}
      format.xml {render :xml => to_paginated_xml(@series)}
      format.json {render :json => to_paginated_json(@series)}
    end
  end
end

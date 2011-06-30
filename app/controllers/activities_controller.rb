class ActivitiesController < EntitiesController
  def index
    
    @activities = Activity.paginate(:page => params[:page], :per_page => 25)
	respond_to do |format|
      format.html
      format.xml {render :xml => @activities.to_xml}
      format.json {render :json => @activities.to_json}
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
  
  def functions
  @activity = Activity.find(params[:id])
  @functions_page = @activity.functions.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html
      format.xml {render :xml => @functions_page.to_xml}
      format.json {render :json => @functions_page.to_json}
    end
  end
  
  def series
  @activity = Activity.find(params[:id])
  @series_page = @activity.series.paginate(:page => params[:page], :per_page => 25)
   respond_to do |format|
      format.html
      format.xml {render :xml => @series_page.to_xml}
      format.json {render :json => @series_page.to_json}
    end
  end

end

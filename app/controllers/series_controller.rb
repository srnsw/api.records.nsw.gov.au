class SeriesController < EntityController
  def index
    @series = pages Series
         
     respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@series)}  
      format.json {render :json => to_paginated_json(@series)}
    end
  end
  
  def show
    @series = Series.find(params[:id])
    @items = pages Item.where(:Series_number => params[:id])
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @series.to_xml}
      format.json {render :json => @series.to_json}
    end
  end
end

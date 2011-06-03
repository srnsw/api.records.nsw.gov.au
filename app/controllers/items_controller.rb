class ItemsController < EntityController
  def index
    if params[:series_id]
      @items = pages Item.where(:Series_number => params[:series_id])
    else
      @items = pages Item
    end
    
    respond_to do |format|
      format.html
      format.xml {render :xml => to_paginated_xml(@items)}
      format.json {render :json => to_paginated_json(@items)}
    end
  end
  
  def show
    if params[:series_id]
      @item = Item.where(:Series_number => params[:series_id]).limit(1).offset(params[:id].to_i - 1).first
    else
      @item = Item.find(params[:id])
    end
        
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @item.to_xml}
      format.json {render :json => @item.to_json}
    end
  end
end

class ItemsController < EntitiesController
  def index
    @items = Item.pages(params)
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => to_paginated_xml(@items)}
      format.json {render :json => to_paginated_json(@items)}
    end
  end
  
  def show
	@item = Item.find(params[:id])
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @item.to_xml}
      format.json {render :json => @item.to_json}
    end
  end
end

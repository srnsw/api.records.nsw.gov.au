class ItemsController < EntitiesController
  def index
    @items = Item.page params[:page]
    
    respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => to_paginated_xml(@items, params[:page])}
      format.json {render :json => to_paginated_json(@items, params[:page])}
    end
  end
  
  def model
    Item.find(params[:id])
  end
  
  def show
    @item = Item.find(params[:id])

    @creating_agencies = @item.series.creating_agencies.page params[:creating_agencies_page]
    @persons = @item.series.persons.page params[:persons_page]

		respond_to do |format|
      format.html
      format.mods
      format.rdf_zotero
      format.xml {render :xml => @item.to_xml}
      format.json {render :json => @item.to_json}
    end
  end
	
	def persons
    item = Item.find(params[:id])
    @persons = item.series.persons.page params[:page]
    respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons, params[:page])}
      format.json {render :json => to_paginated_json(@persons, params[:page])}
    end
  end
	
	def agencies
    item = Item.find(params[:id])
    @agencies = item.series.creating_agencies.page params[:page]
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies, params[:page])}
      format.json {render :json => to_paginated_json(@agencies, params[:page])}
    end
  end
end

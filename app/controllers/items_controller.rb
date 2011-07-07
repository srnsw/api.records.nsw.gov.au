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
  @creating_agencies = @item.series.creating_agencies.pages(params, :creating_agencies_page, 5)
	@persons = @item.series.persons.pages(params, :persons_page, 5)
  
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
    @persons = item.series.persons.pages(params)
    respond_to do |format|
      format.any {render :action => 'persons/index'}
      format.xml {render :xml => to_paginated_xml(@persons)}
      format.json {render :json => to_paginated_json(@persons)}
    end
  end
	
	def agencies
    item = Item.find(params[:id])
    @agencies = item.series.creating_agencies.pages(params)
    respond_to do |format|
      format.any {render :action => 'agencies/index'}
      format.xml {render :xml => to_paginated_xml(@agencies)}
      format.json {render :json => to_paginated_json(@agencies)}
    end
  end
end

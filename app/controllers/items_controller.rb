class ItemsController < EntitiesController
  def index
    
    @items = Item.paginate(:page => params[:page], :per_page => 25)
    
    respond_to do |format|
      format.html
      format.xml {render :xml => @items.to_xml}
      format.json {render :json => @items.to_json}
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

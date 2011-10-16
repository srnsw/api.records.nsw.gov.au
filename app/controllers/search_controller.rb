class SearchController < ApplicationController
  include SRNSW # lib/srnsw.rb
  include SRNSW::Utils
  
  def index
  end
  
  def show
    page = numeric_param params[:page]
    count = max_param(params[:count], 200, 25)
    apage = numeric_param params[:apage]
    fpage = numeric_param params[:fpage]
    entities = const_param params[:entities]
    
    if params[:q] && params[:q].include?(?:)
      clean_query = Array.new
      params_hash = Hash.new
      nodes = params[:q].split 
      nodes.each do |node|
        if node.start_with?('page:', 'count:', 'entities:', 'series:', 'from:', 'to:')
          pair = node.split(":")
          sym = pair[0].to_sym
          params_hash[sym] = pair[1] if pair[1]
        else
          clean_query << node
        end  
      end
      unless params_hash.empty?
        params_hash[:q] = clean_query.join(" ")
        redirect_to params_hash and return     
      end
    end
    
    if entities
      @custom_search, @page_details = search entities, page, count
    else
      @what_search, @page_details = search [Item, Series], page, count
      @who_search, @apage_details = search [Agency, Person], apage, 15, :apage
      @why_search, @fpage_details = search [Function, Activity], fpage, 5, :fpage
    end
    
    respond_to do |format|
      format.html
      format.xml
      format.json
    end
  end
  
  protected
  def search entities, page, count, page_param=:page
     eras = [[1775,1800], [1800,1825], [1825,1850], [1850,1875], [1875,1900],
    [1900,1925], [1925,1950], [1950,1975], [1975,2000], [2000,2025]]
    
    page = 1 unless page
    
    search = Sunspot.search(entities) do
    
      keywords(params[:q], :highlight => true)

		if (params[:location] and not (entities - [Item, Series])[0])
		   any_of do
          all_of do
            with(:class, Item)
            with(:location, params[:location])
          end
          all_of do
            with(:class, Series)
            with(:location, params[:location])
          end
        end
		end      
      
      if (from = numeric_param params[:from])
        any_of do
          with(:end_year).greater_than from
          with(:end_year, nil)
        end
      end
      if (to = numeric_param params[:to])
        with(:start_year).less_than to
      end
      
      if ((series = numeric_param params[:series]) and entities.include?(Item))
        any_of do
          all_of do
            with(:class, Item)
            with(:Series_number, series)
          end
          all_of do
            with(:class, Series)
            with(:id, series)
          end
        end
      end

		facet(:location, :limit => 20)  if entities.include?(Item) 
      
      facet(:Series_number, :limit => 20) if entities.include?(Item)
      
      facet(:era) do
        eras.each do |era|
          row(era) do
            with(:start_year).less_than era[1]
            unless entities == [Function]
              any_of do
                with(:end_year).greater_than era[0]
                with(:end_year, nil)
               end
            end
          end
        end
      end
      
     paginate(:page => page, :per_page => count)
    end
    
    length = search.total
    
    [search] << Pagination.new(page, count, length, page_param)
  end
  
   def const_param entities
    if entities
      entities.split(',').collect do |entity|
        entity = entity.camelcase
        if ['Series', 'Item', 'Function', 'Activity', 'Agency', 'Person'].include?(entity)
          entity.constantize
        else
          return nil
        end
      end
    end
  end
end

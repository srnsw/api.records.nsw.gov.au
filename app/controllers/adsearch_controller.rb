class AdsearchController < ApplicationController
  include SRNSW # lib/srnsw.rb
  include SRNSW::Utils
  
  def index
  end
  
  def show
    per_page = 20
    page = params[:page]
    page = 1 unless params[:page]
    
		@search = Sunspot.search(Accessdirection) do
			fulltext params[:q]
			paginate(:page => page, :per_page => per_page)
    end
    
    @page = @search.hits
    num_pages = (@search.total/20.0).ceil.to_i   
    
    @page.instance_eval <<-EVAL
      def current_page
        #{params[:page] || 1}
      end
      def num_pages
       #{num_pages}
      end
      def limit_value
        #{per_page}
      end
    EVAL
        
    respond_to do |format|
      format.any
      format.yaml {render :text => @search.to_xml}
    end
  end
end

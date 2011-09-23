module SRNSW
# 
# This module contains a custom Pagination class and functions.
# It might make more sense to use Kaminari or WillPaginate!
#
  class Pagination
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
  
    attr_accessor :total_results, :this_page, :offset, :per_page, :next_page, :prev_page, :total_pages, :page_param
  
    def initialize(page, count, length, page_param=:page)
      @total_results = length
      @this_page = page
      @offset = (page - 1) * count
      @per_page = count
      @next_page = page * count < length ? page + 1 : nil
      @prev_page = page > 1 ? page - 1 : nil
      @total_pages = (length.to_f / count).ceil
      @page_param = page_param
    end
     
    def attributes
     {'total_results' => @total_results,
      'this_page' => @this_page,
      'per_page' => @per_page}
    end
    
    def needs_navigation?
      @next_page or @prev_page
    end
    
    def showing
      @this_page.to_s + " of " + @total_pages.to_s
    end
  end 
  
  module Pages
    def pages params, page_param=:page, default_count=25
      length = self.count
      page = SRNSW::Utils.numeric_param params[page_param]
      page = 1 unless page
      if page_param == :page
        count = SRNSW::Utils.max_param params[:count], 200, default_count
      else
        count = default_count
      end
      @page_details = SRNSW::Pagination.new(page, count, length, page_param)
      self.limit(count).offset(@page_details.offset) 
    end 
    
    def page_details
      @page_details
    end
  end
  
  module Utils
    module_function
    def numeric_param page
      if page
        page = page.to_i > 0 ? page.to_i : nil
      end
    end
   
    def max_param param, max, default=nil
      param = numeric_param(param)
      if param
         param > max ? max : param
      else
        default
      end
    end
  end
  
  module Serializers
    def to_paginated_xml set, page, total = nil

      page = page.to_i > 0 ? page.to_i : 1
      total = set.total_count if total.nil? 
      set.to_xml(:except => :__rn) do |xml|
  		  xml.pagination do
  				xml.this_page page
  				xml.total_results total 
  				xml.per_page Kaminari.config.default_per_page
  			end
      end
        
    end
    
    def to_paginated_json set, page
		
		page = page.to_i > 0 ? page.to_i : 1
      
      payload = Serializers::Pagination.new page, set.total_count, Kaminari.config.default_per_page
       
      set.to_a.unshift(payload).to_json
    end
    
    class Pagination
    include ActiveModel::Serializers::JSON
    attr_accessor :total_results, :this_page, :per_page
  
    def initialize(page, count, length)
      @total_results = length
      @this_page = page
      @per_page = count
    end
     
    def attributes
     {'total_results' => @total_results,
      'this_page' => @this_page,
      'per_page' => @per_page}
    end
    end
  end
end

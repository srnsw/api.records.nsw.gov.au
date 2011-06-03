module SRNSW
# 
# This module contains a custom Pagination class and functions.
# It might make more sense to use Kaminari or WillPaginate!
#
  class Pagination
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
  
    attr_accessor :total_results, :this_page, :offset, :per_page, :next_page, :prev_page, :total_pages
  
    def initialize(page, count, length)
      @total_results = length
      @this_page = page
      @offset = (page - 1) * count
      @per_page = count
      @next_page = page * count < length ? page + 1 : nil
      @prev_page = page > 1 ? page - 1 : nil
      @total_pages = (length.to_f / count).ceil
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

  def pages model
    length = model.count
    page = numeric_param params[:page]
    page = 1 unless page
    count = max_param params[:count], 200, 25
    @page_details = Pagination.new(page, count, length)
    model.limit(count).offset(@page_details.offset) 
  end
  
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
  
  def to_paginated_xml set
    require 'builder' unless defined? ::Builder

    builder = ::Builder::XmlMarkup.new(:indent => 2)
    builder.instruct!
    root = set.first.class.name.pluralize.downcase
    builder.tag!(root, {:type => "array"}) do |xml|
      set.to_a.unshift(@page_details).each do |record|
      xml << record.to_xml(:skip_instruct => true)
      end
    end
  end
  
  def to_paginated_json set
    set.to_a.unshift(@page_details).to_json
  end
end

module SearchHelper
  LAST_MODIFIED = "2011-02-28T12:00:00Z" # FIX THIS - All models need a "last modified" field!

  def search_url entity_name, id, only_path = true
    url_for(:action => "show", :controller => ApplicationHelper::ENTITIES[entity_name][0], :id => id, :only_path => only_path)
  end
  
  def search_link hit
    entity = hit.class_name
    link = link_to(hit.stored(:title).html_safe, search_url(entity, hit.stored(:id)))
    img_link link, entity
  end 
  
  def series_filter row
    params_dup = params.dup
    if params_dup[:series]
      params_dup.delete(:series)
      image = image_tag("cross.png", {:alt => "Remove filter"})
    else
      params_dup[:series] = row.value
      image = image_tag("folder_page.png", {:alt=> "Filter by series"})
    end
    params_dup = reset_pages params_dup
    link = link_to(row.instance.Series_title, params_dup)
    link =  image + " " + link + " (#{row.count})"
    p = content_tag :p, link
  end
  
  def reset_pages params_dup
    params_dup.delete(:page)
    params_dup.delete(:fpage)
    params_dup.delete(:apage)
    params_dup
  end
  
  def date_filter row
    params_dup = params.dup
    if ((from = params_dup[:from]) && (to = params_dup[:to]))
      from, to = from.to_i, to.to_i
      if (from == row.value[0] || to == row.value[1])
        params_dup.delete(:from)
        params_dup.delete(:to)
        image = image_tag("cross.png", {:alt => "Remove filter"})
      else
        if from < row.value[0]
          params_dup[:from] = row.value[0]
        else
          params_dup[:to] = row.value[1]
        end
          image = image_tag("hourglass.png", {:alt=> "Filter by date"})
      end
    else
      params_dup[:from] = row.value[0]
      params_dup[:to] = row.value[1]
      image = image_tag("hourglass.png", {:alt=> "Filter by date"})
    end
    params_dup = reset_pages params_dup
    link = link_to((row.value[0].to_s + " to " + row.value[1].to_s), params_dup)
    link =  image + " " + link + " (#{row.count})"
    p = content_tag :p, link
  end
  
  def highlight_hits hit
    if hit.highlight(:description) and not (hit.stored(:title).strip == (hit.highlight(:description).format {|fragment| fragment}).strip)
      content = hit.highlight(:description).format {|fragment| content_tag(:em, fragment)}
      desc = content_tag :p, "..." + content, {:class => "collection_p"}, false
    end
  end
  
  def entity_names entities
    entities = entities.split(",")
    entities.collect {|entity| entity.camelcase.pluralize}.join(", ")
  end
  
  def open_search_query
    query_string = "searchTerms=\"#{params[:q]}\""
    query_string += " startPage=\"#{params[:page]}\"" if params[:page]
    query_string += " count=\"#{params[:count]}\"" if params[:count]
    query_string += " srnsw-custom:entities=\"#{params[:entities]}\"" if params[:entities]
    query_string += " srnsw-custom:series=\"#{params[:series]}\"" if params[:series]
    query_string += " srnsw-custom:from=\"#{params[:from]}\"" if params[:from]
    query_string += " srnsw-custom:to=\"#{params[:to]}\"" if params[:to]
    query_string.html_safe
    end
end

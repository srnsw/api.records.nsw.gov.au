module ApplicationHelper
  ENTITIES = {'Function' => ['functions', 'tag_red.png'], 'Activity' => ['activities', 'tag_purple.png'], 'Agency' => ['agencies', 'group.png'], 'Person' => ['persons', 'user_suit.png'], 'Organisation' => ['organisations', 'group.png'], 'Ministry' => ['ministries', 'group.png'], 'Series' => ['series', 'folder_page.png'], 'Portfolio' => ['portfolios', 'folder_page.png'], 'Item' => ['items', 'page.png'], 'Accessdirection' => ['accessdirections', 'page.png']} 
  ENTITY_CONTROLLERS = {'functions' => 'Function', 'activities' => 'Activity', 'agencies' => 'Agency', 'persons' => 'Person', 'organisations' => 'Organisation', 'ministries' => 'Ministry', 'series' => 'Series', 'items' => 'Item', 'portfolios' => 'Portfolio'}
  
  CONTROLLER_TO_MODEL = { "ActivitiesController" => "Activity",
   "AgenciesController" => "Agency",
   "FunctionsController" => "Function",
   "ItemsController" => "Item",
   "MinistriesController" => "Ministry",
   "PersonsController" => "Person",
   "PortfoliosController" => "Portfolio",
   "SeriesController" => "Series" }

  # used in OAI layout and EAC-CPF views
  def utcdatetime
    Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def make_header entity
    content_tag :h1, entity
  end
  
  def make_title title
    content_tag :h3, title.html_safe
  end
  
  def rich_field title, field
    if field
      dic_title = content_tag :dt, title + ":"
      dic_def = content_tag :dd, field.html_safe.gsub(/\n/, '<br/>').gsub('<br><br/>', '<br/>')
      content_tag :dl, dic_title + dic_def
    end
  end
  
  def simple_field title, field
    if field
      dic_title = content_tag :dt, title + ":"
      dic_def = content_tag :dd, field.html_safe
      content_tag :dl, dic_title + dic_def
    end
  end
  
   def bool_field title, field
    unless field.nil?
      dic_title = content_tag :dt, title + ":"
      dic_def = content_tag :dd, (field ? "yes" : "no")
      content_tag :dl, dic_title + dic_def
    end
  end
  
  def numeric_field title, field
    if field
      return if field == 0
      dic_title = content_tag :dt, title + ":"
      dic_def = content_tag :dd, field.to_s
      content_tag :dl, dic_title + dic_def
    end
  end
    
  def make_link text, entity
    link = link_to text.html_safe, entity
  end
  
  def img_link link, entity_name
    if image_name = ApplicationHelper::ENTITIES[entity_name][1]
      link = image_tag(image_name, {:alt=> entity_name}) + " " + link
    end
    p = content_tag :p, link
  end
  
  def link_field title, text, entity
    if text
      dic_title = content_tag :dt, title + ":"
      link = make_link text, entity
      dic_def = content_tag :dd, link
      content_tag :dl, dic_title + dic_def
    end
  end
  
	def link_browse uri
		link_to image_tag("folder_explore.png", {:alt=> "browse"}), uri
	end
	
	def link_ai_purchase text, item     
	  linktag = link_to text.html_safe,  "http://investigator.records.nsw.gov.au/Entity.aspx?Path=\\Item\\#{item}" , :target => "_blank"
     link = image_tag("basket.png", {:alt=> "process through Archive Investigator"}) + " " + linktag
     p = content_tag :p, link
	end
	
	def link_tag title, lnk, entityname
		linktag = link_to title.html_safe, lnk
		img_link linktag, entityname
		
	end
	
	def link_p text, entity
    link = make_link text, entity
    content_tag :p, link
  end
  
  def link_i text, entity
    link = make_link text, entity
    img_link link, entity.class.name
  end
  
  def make_qr_code  
    entity_uri = CGI.escape(url_for(:only_path => false))
    image_tag "http://chart.apis.google.com/chart?chs=200x100&cht=qr&chl=#{entity_uri}",
      :width=> "200", :height=> "100", :alt => "QR code"
  end
  
  def params_swap param, value
    params_dup = params.dup
    params_dup[param] = value
    params_dup
  end
  
  # returns YYYY-MM-DD
  def date_simple datetime
    if datetime
     datetime.to_date.to_s
    end
  end
  
  # custom page navigation (see SRNSW.rb)
  def page_navigation page_details, browse_uri=nil
    if page_details.needs_navigation? 
      showing = page_details.showing
      if page_details.prev_page
        prev_image = link_to image_tag("resultset_previous.png", {:alt=> "Previous page"}), params_swap(page_details.page_param, page_details.prev_page)
        showing = " " + showing
      end
      if page_details.next_page
        next_image = link_to image_tag("resultset_next.png", {:alt=> "Next page"}), params_swap(page_details.page_param, page_details.next_page)
        showing = showing + " "
      end
      content = prev_image ? prev_image : String.new
      content += showing
      content += next_image if next_image
      content += " ".html_safe.concat(link_browse browse_uri) if browse_uri
      content_tag :p, content, {:class => "collection_navigation"}, false
    end
  end
end

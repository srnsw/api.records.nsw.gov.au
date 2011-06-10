module UsageHelper
	# this module contains parameters and formats that apply across the whole API
	PARAMS = [["page", "integer", "2", "return a particular page of results"],
    ["count", "integer &le; 200", "50", "increase the number of results per page (default is 25)"]]
    FORMATS = ["xml", "json"]
  
  module Search
    # this module contains parameters and schemas for formats specific to the search method
  	PARAMS = [["q", "query string", "unemployment", "keyword search"],
   		["series", "series id", "13660", "filter results by series id"],
    	["entities", "comma-separated list of entities", "Item,Series,Function,Activity", "return results for selected entities"],
    	["from", "year", "1940", "return results from this year onwards"],
    	["to", "year", "1980", "return results up to this year"]]
    # hash of descriptions and links to external schemas for special formats
    SCHEMAS = {"xml" => ["OpenSearch response elements", "http://www.opensearch.org/"]}
  end
  	
  module Entities
  	# this module contains descriptions, formats, schemas for formats, and associations specific to entity methods
  	# the DESCRIPTIONS arrays contain the names of entities, descriptions, and an ID (for hyperlinks)
    DESCRIPTIONS = [["Function", "A function is a major area of responsibility, "\
    	"authority or jurisdiction assigned to or assumed by an organisation. "\
    	"Functions derive from mandates usually given in legislation. Functions "\
    	"can be permissive or prescriptive. They constitute the principal themes of "\
    	"business of any organisation.", "1"],
		  ["Activity", "An activity is a part of a function. Activities provide more"\
		  " specific functional context for record series than can be provided"\
		  "be provided by a function.", "1"],
		  ["Agency", "﻿An agency is an administrative or business unit which has "\
		  "responsibility for carrying out some designated activity.",  "1"],
			["Person", "A person is an individual who creates records, usually in "\
			"an official capacity, but whose records have not been maintained in "\
			"the records of the associated agency.", "2"],
			["Organisation", "An organisation is a whole government, municipal "\
			"council, incorporated company, church or other body that is generally "\
			"regarded as independent and autonomous in the performance of its "\
			"normal functions.", "1"],
			["Ministry", "A ministry is the body of ministers who hold warrants "\
			"from the Head of State as members of the Executive Council. A ministry "\
			"comprises a number of portfolios. A ministry is often named for the Premier "\
			"who led it. Coalition ministries are often named after both leaders.", "1"],
			["Series", "A record series is a group of (one or more) record items "\
			"accumulated by an agency or person which have a common identity "\
			"and system of control, and are generally in the same format.", "13660"],
			["Item", "A record item is an individual unit within a record series, "\
			"and the smallest entity. A record item may be in any format:"\
			" (for example) a file, card, volume, plan or drawing, photograph "\
			"or videotape. Some record items (such as files) may contain multiple "\
			"individual documents but these are not normally listed as individual "\
			"entities. In order to fully understand the significance of a record item "\
			"it is vital to know what record series it forms part of. There is usually "\
			"no way to determine the context or content, or format of a record "\
			"item without learning about the record series.", "2844"]]
   	# additional formats for particular entities
   	FORMATS = {"Series" => ["mods", "rdf_zotero"], "Item" => ["mods", "rdf_zotero"]}
   	# hash of descriptions and links to external schemas for special formats
   	SCHEMAS = {"mods" => ["Library of Congress Metadata Object Description Schema",
   	  "http://www.loc.gov/standards/mods/"]}
   	# Hash of any associations between entities e.g. series/13660/items
   	ASSOCIATIONS = {"Series"=> "Item"}
  end
  
  # takes an array of formats, a hash of special schemas, and an example path
  # returns a list of formats within dd tags
 	def formats_documentation formats, schemas, path
 	  title = content_tag :dt, "Formats:"
 	  format_string = formats.collect do |format|
 	    link = link_to format, path + "." + format
 	    if schemas[format]
 	      arry = schemas[format]
 	      link + " (" + link_to(arry[0], arry[1]) + ")"
 	    else
 	      link
 	    end
 	  end.join(", ")
 	  definition = content_tag :dd, format_string.html_safe
    content_tag :dl, title + definition
 	end
  
  # takes an array of parameters
  # returns a list of parameters within dd tags	
  def params_documentation parameters
  	title = content_tag :dt, "Parameters:"
  	param_string = parameters.collect do |param|
  	  content = "<b>#{param[0]}:</b> "
  	  content += "[#{param[1]} e.g. #{param[2]}] "
  	  content += param[3] 
  	end.join("<br/>")
  	definition = content_tag :dd, param_string.html_safe
    content_tag :dl, title + definition
  end
  
  # returns html string
  def title_description title, description
    content = content_tag :h3, "/" + title
    content += content_tag :p, description  
  end
  
  # creates documentation for search method
  # returns an html string	
  def search_documentation
    content = content_tag :h2, "Search"
    content += title_description "search", "Search the catalogue."
  	content += formats_documentation FORMATS, Search::SCHEMAS, "search"
  	content += params_documentation Search::PARAMS + PARAMS
  end
  
  # creates documentation for entity methods
  # returns an html string	
  def entity_documentation
    content = String.new
    Entities::DESCRIPTIONS.each do |description|
      entity = ApplicationHelper::ENTITIES[description[0]]
      content += content_tag :h2, description[0]
      content += content_tag :p, description[1]
      # documentation for method to acquire list of entities e.g. /series
      content += title_description entity[0], "Returns a list of " + entity[0] + "."
      formats = FORMATS
      # check for any special formats for this entity
      formats += Entities::FORMATS[description[0]] if Entities::FORMATS[description[0]]
      content += formats_documentation formats, Entities::SCHEMAS, entity[0]
      content += params_documentation PARAMS
      # documenation for method to acquire a single entity e.g. /series/13660     
      content += title_description entity[0] + "/[:id]", "Returns " + description[0].downcase + " with identifier :id."
      example_path = entity[0] + "/" + description[2]
      content += formats_documentation formats, Entities::SCHEMAS, example_path
      # check if this entity has any methods for associated entities (at the
      # moment just /series/[:id]/items)
      if association = Entities::ASSOCIATIONS[description[0]]
        associated_entity = ApplicationHelper::ENTITIES[association]
        associated_formats = FORMATS
        associated_formats += Entities::FORMATS[association] if Entities::FORMATS[association]
        # documentation for method to acquire list of associated entities
        content += title_description entity[0] + "/[:id]" + "/" + associated_entity[0],
          "Returns a list of " + associated_entity[0] + " within a particular " + description[0].downcase + "."
        content += formats_documentation associated_formats, Entities::SCHEMAS,
          entity[0] + "/" + description[2] + "/" + associated_entity[0]
        content += params_documentation PARAMS
        # documentation for method to acquire a single associated entity
        content += title_description entity[0] + "/[:id]" + "/" + associated_entity[0] + "/[:number]",
        	"Returns the nth " + association.downcase + " within a particular " + description[0].downcase + "."
        content += formats_documentation associated_formats,  Entities::SCHEMAS,
          entity[0] + "/" + description[2] + "/" + associated_entity[0] + "/1"
      end   
    end
    content.html_safe
  end
end


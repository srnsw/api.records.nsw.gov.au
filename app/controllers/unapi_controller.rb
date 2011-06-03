class UnapiController < ApplicationController
  FORMATS = [["rdf_zotero", "application/xml"],["mods", "application/xml"]]
    
  def index
    if params[:id]
      resource_string = CGI.unescape(params[:id])
      if params[:format]
        redirect_to resource_string + ".#{params[:format]}"
      else
        render :text => unapi_formats(resource_string), :content_type => "application/xml"
      end
    else  
      render :text => unapi_formats, :content_type => "application/xml"
    end
  end
  
  def unapi_formats resource_string=nil
    xml_string = '<?xml version="1.0" encoding="UTF-8"?><formats'
    xml_string += " id=\"#{resource_string}\"" if resource_string
    xml_string += '>'
    xml_string += FORMATS.collect {|format| '<format name="' + format[0] + '" type="' + format[1] + '"/>'}.join
    xml_string += '</formats>'
  end
end



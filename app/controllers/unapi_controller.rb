class UnapiController < ApplicationController
  include XmlHelper
  
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
  
  protected
  def unapi_formats resource_string=nil
    xml_string = xml_processing_instruction
    attributes = resource_string ? [["id", resource_string]] : nil 
    xml_string += open_xml_tag "formats", attributes
    xml_string += FORMATS.collect do |format|
      make_xml_element "format", nil, [["name", format[0]], ["type", format[1]]]
    end.join
    xml_string += close_xml_tag "formats"
  end
end



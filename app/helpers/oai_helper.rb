module OaiHelper
include XmlHelper

def utcdatetime
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
end

def oai_id entity
  "oai:" + request.host + ":" + url_for(entity)[1..-1]
end

# checks if the OAI is a valid ID
# returns [controller, ID] or false 
def resolve_oai_id id
  path = id.split(":")[-1]
  begin
    path_params = Rails.application.routes.recognize_path(path)
    # test if the path refers to a valid entity controller
    if (model = ApplicationHelper::ENTITY_CONTROLLERS[path_params[:controller]])
    # test if there is an entity corresponding to the ID
      model.constantize.find(path_params[:id]) ? [path_params[:controller], path_params[:id]] : false
    else
      false
    end
  # rescue clause checks for completely bogus IDs e.g. oai:api.records.nsw.gov.au:meaningless/5
  rescue
    false
  end
end

def has_format? controller
  
end

# from the spec... "in cases where the request that generated this response
# resulted in a badVerb or badArgument error condition, the repository must return
# the base URL of the protocol request only"
def make_request_element
  if (@error_code == "badArgument" || @error_code == "badVerb")
    make_xml_element "request", url_for(:only_path => false)
  else
    make_xml_element "request", url_for(:only_path => false), params.except(:action, :controller).to_a
  end
end
end

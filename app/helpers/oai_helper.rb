module OaiHelper
include XmlHelper

def utcdatetime
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
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

# create an OAI ID from an entity
def oai_id entity
  "oai:" + request.host + ":" + url_for(entity)[1..-1]
end

# create a set_spec (really just controller string) from an entity
def to_set_spec entity
  ApplicationHelper::ENTITIES[entity.class.name][0]
end

# test resumption token
# valid tokens are: [format]_[set | 0]_[from | 0]_[until | 0]_[page]
def resolve_token token
  arry = token.split("_")
  return false unless arry.length == 5 # must be complete
  arry = arry.collect {|item| item == "0" ? nil : item}
  return false unless arry[0] # must have metadata prefix
  if arry[1]
    return false unless valid_spec? arry[1]
    return false unless has_format? arry[1], arry[0]
  else
    return false unless valid_format? arry[0] # if no set, format must be valid
  end
  arry[2..3].each do |date| # check any dates
    if date
      return false unless valid_date? date
    end
  end 
  # finally, check the page value
  if (arry[4] and arry[4].to_i > 0) # must have a numeric page value
    arry
  else
    false
  end
end    
        
def valid_format? format
  UsageHelper::Entities::SCHEMAS[format] ? true : false
end

def valid_spec? set_spec
  ApplicationHelper::ENTITY_CONTROLLERS[set_spec] ? true : false
end

def valid_date? date
  begin
    Date.parse(date)
  rescue
    return false
  end
  true
end

def has_format? controller, format
  formats = UsageHelper::Entities::FORMATS[ApplicationHelper::ENTITY_CONTROLLERS[controller]]
  formats ? formats.index(format) : nil 
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

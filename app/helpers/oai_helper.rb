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

def has_format? controller, format
  formats = UsageHelper::Entities::FORMATS[ApplicationHelper::ENTITY_CONTROLLERS[controller]]
  formats ? formats.index format : nil 
end

def set_spec entity
  ApplicationHelper::ENTITIES[entity.class.name][0]
end

# resumption formats in format: format_set_from_until_cursor
def resolve_token token
  arry = token.split("_")
  if arry.length == 5
  arry = arry.collect {|item| item == "0" ? nil : item}
    if format = arry[0]
      if UsageHelper::Entities::SCHEMAS[format]
        if set_spec = arry[1]
          if ApplicationHelper::ENTITY_CONTROLLERS[set_spec]
            return nil unless has_format? set_spec, format # if set_spec, must have format
          end
          else
            nil # set_spec must be valid
          end
        end
        # if dates exist, check that they are valid
        arry[2..3].each do |date|
          if date
            begin
              Date.parse(date)
            rescue
              return nil
            end
          end
        end
        if (arry[4] and arry[4].to_i > 0)
          arry[4] = arry[4].to_i
          return arry # the resumption token is passed all checks
        else
          nil # cursor must be a number
        end
      else
        nil # format must exist
      end
    else
     nil # must have a prefix
    end
   else
    nil  # must have all five elements (or 0s)
  end
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

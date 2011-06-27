module OaiHelper
include XmlHelper

def utcdatetime
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
end

# create an OAI ID from an entity
def oai_id entity
  "oai:" + request.host + ":" + url_for(entity)[1..-1]
end

# create a set_spec (really just controller string) from an entity
def to_set_spec entity
  ApplicationHelper::ENTITIES[entity.class.name][0]
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

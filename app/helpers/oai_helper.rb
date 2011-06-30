module OaiHelper
include XmlHelper

def utcdatetime
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
end

# create an OAI ID from a model name and id
def oai_id class_name, id
  "oai:" + request.host + ":" + to_set_spec(class_name) + "/" + id.to_s # id can be either passed as string or integer
end

# create a set_spec (really just controller string) from a model name
def to_set_spec class_name
  ApplicationHelper::ENTITIES[class_name][0]
end

# create a template path from model name and format prefix
def template_path class_name, format
  "#{to_set_spec(class_name)}/_#{format}.#{format}.erb"
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

def make_resumption_token
  if @page_details.needs_navigation?
    if @page_details.next_page
      @args[-1] = @page_details.next_page
      token = @args.collect {|arg| arg.nil? ? "0" : arg}.join(":")      
    else
      token = nil
    end
    make_xml_element("resumptionToken", token, [["completeListSize", @page_details.total_results], ["cursor", @page_details.offset]]).html_safe
  end
end
end

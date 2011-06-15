module OaiHelper
include XmlHelper

def utcdatetime
  Time.now.utc.strftime("%Y-%m-%dT%H:%M:%SZ")
end

def oai_header
  header = xml_processing_instruction
  header += open_xml_tag("OAI-PMH", [["xmlns", "http://www.openarchives.org/OAI/2.0/"],
  ["xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance"], 
  ["xsi:schemaLocation", "http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"]])
  header += make_xml_element "responseDate", utcdatetime
end

def oai_identifier entity
  "oai:" + request.host + ":" + url_for(entity)
end

def error_element error, content=nil
  make_xml_element "error", content, [["code", error]]
end
end

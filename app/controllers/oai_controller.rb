class OaiController < ApplicationController
include OaiHelper

def index
  render :text => make_oai, :content_type => "application/xml"
end

def make_oai
  xml = oai_header 
  xml += check_verb
  xml += close_xml_tag "OAI-PMH"
end

def check_verb
  case params[:verb]
  when "GetRecord"
    get_record
  when "Identify"
    identify
  when "ListIdentifiers"
    list_identifiers
  when "ListMetadataFormats"
    list_metadata_formats
  when "ListRecords" 
    list_records
  when "ListSets"
    list_sets
  else
    error_element("badArgument", "Expecting parameter verb=GetRecord|Identify|ListIdentifiers|ListMetadataFormats|ListRecords|ListSets")
  end
end

def check_identifier
  @agency = Agency.find(params[:id])
end

# retrieve an individual metadata record from a repository
# required params: identifier, metadataPrefix
def get_record


end

# retrieve information about a repository
# no arguments
def identify 
  identity = open_xml_tag "Identify"
  identity += make_xml_element "repositoryName", "State Records Authority of New South Wales"
  identity += make_xml_element "baseURL", root_url
  identity += make_xml_element "adminEmail", "richard.lehane@records.nsw.gov.au"
  identity += make_xml_element "earliestDateStamp", "1996-26-08"
  identity += make_xml_element "deletedRecord", "no"
  identity += make_xml_element "granularity", "YYYY-MM-DD"
  identity += close_xml_tag "Identify"
end

def list_identifiers


end

def list_metadata_formats


end

def list_records


end

def list_sets



end
end

class OaiController < ApplicationController
include SRNSW
include OaiHelper
layout "oai.xml.erb"

def index
  case params[:verb]
  when "GetRecord"
    if (error_content = bad_argument?([:identifier, :metadataPrefix]))
      report_error "badArgument", error_content
    else
      entity = resolve_oai_id(params[:identifier])
      if entity
      agency_id = entity[1]
      @agency = Agency.find(agency_id)
      render :template => "oai/getRecord.xml.erb", :content_type => "application/xml"
      else
        report_error "idDoesNotExist", "Bad identifier: #{params[:identifier]}"
      end
    end
  when "Identify"
    if (error_content = bad_argument?)
      report_error "badArgument", error_content
    else
      render :template => "oai/identify.xml.erb", :content_type => "application/xml"
    end
  when "ListIdentifiers"
    if (error_content = bad_argument?([:metadataPrefix], [:from, :until, :set, :resumptionToken]))
      report_error "badArgument", error_content
    else
      #
    end
  when "ListMetadataFormats"
    if (error_content = bad_argument?(nil, [:identifier]))
      report_error "badArgument", error_content
    else
      if params[:identifier]
        entity = resolve_oai_id params[:identifier]
        if entity
          formats = UsageHelper::Entities::FORMATS[ApplicationHelper::ENTITY_CONTROLLERS[entity[0]]]
          if formats
            @formats = formats.collect do |fmt|
              (arry = UsageHelper::Entities::SCHEMAS[fmt]) ? [fmt, arry[2], arry[3]] : nil           
            end.compact
            render :template => "oai/listMetdataFormats.xml.erb", :content_type => "application/xml"
          else
            report_error "noMetadataFormats", "There are no metadata formats for #{params[:identifier]}"
          end
        else
          report_error "idDoesNotExist", "Bad identifier: #{params[:identifier]}"
        end
      else
        @formats = UsageHelper::Entities::SCHEMAS.collect {|k, v| [k, v[2], v[3]]}
        render :template => "oai/listMetdataFormats.xml.erb", :content_type => "application/xml"
      end
    end 
  when "ListRecords" 
    if (error_content = bad_argument?([:metadataPrefix], [:from, :until, :set, :resumptionToken]))
      report_error "badArgument", error_content
    else
      #
    end
  when "ListSets"
    if (error_content = bad_argument?(nil, [:resumptionToken]))
      report_error "badArgument", error_content
    else
      @sets = UsageHelper::Entities::DESCRIPTIONS.collect do |desc|
        [ApplicationHelper::ENTITIES[desc[0]][0], desc[0] + " descriptions", desc[1]]
      end
      render :template => "oai/listSets.xml.erb", :content_type => "application/xml"
    end
  else
    report_error("badVerb",
      "Expecting parameter verb=GetRecord|Identify|ListIdentifiers|ListMetadataFormats|ListRecords|ListSets")
  end
end

# test arguments to make sure all required arguments for any particular verb
# are included and that no other arguments besides the optional ones are present
# returns error string or false if no bad arguments
protected
def bad_argument? required=nil, optional=nil
  arguments = params.except(:controller, :action)
  required ? required << :verb : required = [:verb]
  unless required.all? {|key| arguments.has_key?(key)}
    return "Missing required arguments: " + required.reject {|key| arguments.has_key?(key)}.join(", ")
  end
  arguments = arguments.except(*required)
  arguments = arguments.except(*optional) if optional
  if arguments.empty?
    false
  else
    "Includes illegal arguments: " + arguments.keys.join(", ")
  end
end

def report_error code, content=nil
  @error_code = code
  @error_content = content
  render :template => "oai/error.xml.erb", :content_type => "application/xml"
end
end

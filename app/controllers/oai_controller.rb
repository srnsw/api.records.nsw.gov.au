class OaiController < ApplicationController
  include SRNSW
  layout "oai.xml.erb"

  def index
    case params[:verb]
    when "GetRecord"
      if (error_content = bad_argument?([:identifier, :metadataPrefix]))
        report_error "badArgument", error_content
			else
				entity = resolve_oai_id(params[:identifier])
				if entity
					format = params[:metadataPrefix]
					if has_format? entity[0], format
						@format = format
						@template = "#{entity[0]}/_#{@format}.#{@format}.erb"
						model = ApplicationHelper::ENTITY_CONTROLLERS[entity[0]]
						@entity = model.constantize.find(entity[1])
						render :template => "oai/getRecord.xml.erb", :content_type => "application/xml"
					else
						report_error "cannotDisseminateFormat", "#{entity[0]} set does not support format: #{format}"
					end  
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
				if (args = parse_list_args)
				
				end
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
				if (args = parse_list_args)
				
				end
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

	# render the error template
	protected
	def report_error code, content=nil
		@error_code = code
		@error_content = content
		render :template => "oai/error.xml.erb", :content_type => "application/xml"
	end

	# make sure all required arguments for any particular verb
	# are included and that no other arguments besides the optional ones are present
	# returns error string or false if no bad arguments
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

	# return an array of args for use by ListIdentifiers and ListRecords verbs
	# or renders error and returns false
	def parse_list_args
		if token = params[:resumptionToken]
			args = resolve_token token
			if args
				args # parses successfully, return args
			else
				report_error "badResumptionToken", "Token invalid: #{token}" and return false
			end
		else
			if valid_format? format = params[:metadataPrefix]
				args = [format]
			else
				report_error "cannotDisseminateFormat", "Repository does not support format: #{format}" and return false
			end
			if spec = params[:set]
				if valid_spec? spec
					if has_format? spec, format
						args << spec
					else
						report_error "cannotDisseminateFormat", "#{spec} set does not support format: #{format}" and return false
					end
				else
					report_error "badArgument", "Set does not exist: #{spec}" and return false
				end
			else
				args << nil
			end
			if date = params[:from]
				if valid_date? date
					args << date
				else
					report_error "badArgument", "From is not a valid date: #{date}" and return false
				end
			else
				args << nil
			end
			if date = params[:until]
				if valid_date? date
					args << date
				else
					report_error "badArgument", "Until is not a valid date #{date}" and return false
				end
			else
				args << nil
			end
			args << nil # parses successfully, return args
		end
	end

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

  # ListIdentifier and ListRecord
	def list_search args
		if args[1]
			entities = args[1]
		else
			entities = UsageHelper::Entities::FORMATS.to_a.collect {|arry| arry[1].index(args[0]) ? arry[0] : nil}.compact
		end
		page = args[4]
		page = 1 unless page
		count = 100
		list = Sunspot.search(entities) do
			if args[2]
				 with(:modified).greater_than args[2]
			 end
			 if args[3]
				 with(:modified).less_than args[3]
			 end
			 paginate(:page => page, :per_page => count)
		 end
		 length = list.total
		 [list] << Pagination.new(page, count, length)
	end
end

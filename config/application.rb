require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'flickraw'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Collection
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
    
    # Rakismet setting
    config.rakismet.key = ''    
    config.rakismet.url = 'http://api.records.nsw.gov.au'    

    #Flickr setting
    FlickRaw.api_key="9e5278b20e4a4f10079c45faefed203f"
    FlickRaw.shared_secret="afe0a53e37630b73"
        
    Mime::Type.register "application/mods+xml", :mods
    Mime::Type.register "application/x-eac_cpf+xml", :eac_cpf
    Mime::Type.register "application/x-oai_dc+xml", :oai_dc
    Mime::Type.register "application/x-rdf_zotero+xml", :rdf_zotero
	 Mime::Type.register "application/xml", :xml
  end
end

# Load the rails application
require File.expand_path('../application', __FILE__)

# Load SRNSW module
require 'srnsw.rb'

#require 'magic_multi_connections'
connection_names = ActiveRecord::Base.configurations.keys.select do |name|
name =~ /^#{ENV['RAILS_ENV']}_clone/
end

@@connection_pool = connection_names.map do |connection_name|
Object.class_eval <<-EOS
module #{connection_name.camelize}
establish_connection :#{connection_name}
end
EOS
connection_name.camelize.constantize
end

# Initialize the rails application
Collection::Application.initialize!


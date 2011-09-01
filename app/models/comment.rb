class Comment

include Mongoid::Document
include Mongoid::Timestamps
include Rakismet::Model

self.collection_name = 'comments'

  belongs_to :user

  field :link, type: String
  field :title, type: String
  field :entitytype, type: String
  field :entityid, type: Integer
  field :comments, type: String

rakismet_attrs :author => proc{ user.name }, :author_email => proc{ user.email }, :content => :comments
end

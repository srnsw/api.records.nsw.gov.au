class Comment

include Mongoid::Document
include Mongoid::Timestamps

self.collection_name = 'comments'

belongs_to :user

field :comments, type: String
field :entitytype, type: String
field :entityid, type: Integer

end
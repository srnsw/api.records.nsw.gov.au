class Comment

include Mongoid::Document
include Mongoid::Timestamps

  self.collection_name = 'comments'

  belongs_to :user

  field :link, type: String
  field :title, type: String
  field :entitytype, type: String
  field :entityid, type: Integer
  field :comments, type: String

end
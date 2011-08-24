class Tag

include Mongoid::Document

  self.collection_name = 'tags'

  belongs_to :user

  field :link, type: String
  field :title, type: String
  field :entitytype, type: String
  field :entityid, type: Integer
  field :tag, type: String

  validates_length_of :tag, maximum: 30
  
  def to_param
    tag
  end
end
class User
  include Mongoid::Document

  has_many :comments
  has_many :tags  
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  field :email
  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  
  #allow :name to be used as a key for routing instead of :id
  #i.e from /users/1290000/ to /users/john
  def to_param
    name
  end

end


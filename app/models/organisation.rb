class Organisation < Entity
  set_table_name 'organisations_view'
  set_primary_key :Organisation_number
  
  has_and_belongs_to_many :succeeding, :class_name => "Organisation", :join_table => "organisations_link_succeeding",  :foreign_key => "organisation_id", :association_foreign_key => "succeeding_id" 
  has_and_belongs_to_many :preceding, :class_name => "Organisation", :join_table => "organisations_link_preceding",  :foreign_key => "organisation_id", :association_foreign_key => "preceding_id" 
  has_and_belongs_to_many :agencies, :class_name => "Agency", :join_table => "organisations_link_agencies"
  
end

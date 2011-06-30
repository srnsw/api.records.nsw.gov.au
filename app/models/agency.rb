class Agency < Entity
  set_table_name 'agencies_view'
  set_primary_key :Agency_number
  
  has_and_belongs_to_many :functions, :class_name => "Function", :join_table => "agencies_link_functions"
  has_and_belongs_to_many :organisations, :class_name => "Organisation", :join_table => "agencies_link_organisations"
  has_and_belongs_to_many :persons, :class_name => "Person", :join_table => "agencies_link_persons"
  has_and_belongs_to_many :series_controlled, :class_name => "Series", :join_table => "agencies_link_series_controlled"
  has_and_belongs_to_many :series_created, :class_name => "Series", :join_table => "agencies_link_series_created"
  
  has_and_belongs_to_many :preceding, :class_name => "Agency", :join_table => "agencies_link_preceding",  :foreign_key => "agency_id", :association_foreign_key => "preceding_id" 
  has_and_belongs_to_many :related, :class_name => "Agency", :join_table => "agencies_link_related",  :foreign_key => "agency_id", :association_foreign_key => "related_id" 
  has_and_belongs_to_many :subordinates, :class_name => "Agency", :join_table => "agencies_link_subordinates",  :foreign_key => "agency_id", :association_foreign_key => "subordinate_id" 
  has_and_belongs_to_many :succeeding, :class_name => "Agency", :join_table => "agencies_link_succeeding",  :foreign_key => "agency_id", :association_foreign_key => "succeeding_id" 
  has_and_belongs_to_many :superiors, :class_name => "Agency", :join_table => "agencies_link_superiors",  :foreign_key => "agency_id", :association_foreign_key => "superior_id" 
  
  
  searchable do 
    text :Agency_title, :boost => 2
    text :Administrative_history_note
    integer :start_year, :trie => true do |agency|
      agency.Start_date ? agency.Start_date.year : nil
    end
    integer :end_year, :trie => true do |agency|
      agency.End_date ? agency.End_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Agency_title, :stored => true
    integer :id, :using => :Agency_number, :stored => true
  end
end

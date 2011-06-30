class Organisation < Entity
  set_table_name 'organisations_view'
  set_primary_key :Organisation_number
  
  has_and_belongs_to_many :succeeding, :class_name => "Organisation", :join_table => "organisations_link_succeeding",  :foreign_key => "organisation_id", :association_foreign_key => "succeeding_id" 
  has_and_belongs_to_many :preceding, :class_name => "Organisation", :join_table => "organisations_link_preceding",  :foreign_key => "organisation_id", :association_foreign_key => "preceding_id" 
  has_and_belongs_to_many :agencies, :class_name => "Agency", :join_table => "organisations_link_agencies"
  
  searchable do 
    text :Organisation_title, :boost => 2
    text :Administrative_history_note
    integer :start_year, :trie => true do |organisation|
      organisation.Start_date ? organisation.Start_date.year : nil
    end
    integer :end_year, :trie => true do |organisation|
      organisation.End_date ? organisation.End_date.year : nil
    end
    time :modified, using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Organisation_title, :stored => true
    integer :id, :using => :Organisation_number, :stored => true
  end
  
end

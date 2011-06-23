class Agency < Entity
  set_table_name 'agencies_view'
  set_primary_key :Agency_number
  
  #has_and_belongs_to_many :functions, :class_name => "Function", :join_table => "agencies_link_functions"
  #has_and_belongs_to_many :series, :class_name => "Series", :join_table => "activities_link_series"
  
  searchable do 
    text :Agency_title, :boost => 2
    text :Administrative_history_note
    integer :start_year, :trie => true do |agency|
      agency.Start_date ? agency.Start_date.year : nil
    end
    integer :end_year, :trie => true do |agency|
      agency.End_date ? agency.End_date.year : nil
    end
    string :title, :using => :Agency_title, :stored => true
    integer :id, :using => :Agency_number, :stored => true
  end
end

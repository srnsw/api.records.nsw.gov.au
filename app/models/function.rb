class Function < Entity
  set_table_name 'functions_view'
  set_primary_key :Function_number
  
  has_and_belongs_to_many :activities, :class_name => "Activity", :join_table => "functions_link_activities"
  has_and_belongs_to_many :agencies, :class_name => "Agency", :join_table => "functions_link_agencies"
  has_and_belongs_to_many :persons, :class_name => "Person", :join_table => "functions_link_persons"

  searchable do 
    text :Function_title, :boost => 2
    text :Descriptive_note
    integer :start_year, :trie => true do |function|
      function.Start_date ? function.Start_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Function_title, :stored => true
    integer :id, :using => :Function_number, :stored => true
  end
  
  def date_range
    date_string self.Start_date_qualifier, self.Start_date
  end
end

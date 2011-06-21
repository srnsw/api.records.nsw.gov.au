class Function < Entity
  set_table_name 'functions_view'
  set_primary_key :Function_number
  searchable do 
    text :Function_title, :boost => 2
    text :Descriptive_note
    integer :start_year, :trie => true do |function|
      function.Start_date ? function.Start_date.year : nil
    end
    string :title, :using => :Function_title, :stored => true
    integer :id, :using => :Function_number, :stored => true
  end
  
  def date_range
    date_string self.Start_date_qualifier, self.Start_date
  end
end

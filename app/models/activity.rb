class Activity < Entity
  set_table_name 'activities'
  set_primary_key :Activity_number
  searchable do 
    text :Activity_title, :boost => 2
    text :Descriptive_note
    integer :start_year, :trie => true do |activity|
      activity.Start_date ? activity.Start_date.year : nil
    end
    integer :end_year, :trie => true do |activity|
      activity.End_date ? activity.End_date.year : nil
    end
    string :title, :using => :Activity_title, :stored => true
    integer :id, :using => :Activity_number, :stored => true
  end
end

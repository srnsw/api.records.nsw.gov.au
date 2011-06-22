class Activity < Entity
  set_table_name 'activities_view'
  set_primary_key :Activity_number
  has_and_belongs_to_many :functions, :class_name => "Function", :join_table => "activities_link_functions"
  has_and_belongs_to_many :series, :class_name => "Series", :join_table => "activities_link_series"

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

class Series < Entity
  set_table_name 'series_view'
  set_primary_key :Series_number
  has_many :items, :foreign_key => 'Series_number'
  
  has_and_belongs_to_many :activities, :class_name => "Activity", :join_table => "series_link_activities"
  has_and_belongs_to_many :controlling_agencies, :class_name => "Agency", :join_table => "series_link_controlling_agencies"
  has_and_belongs_to_many :creating_agencies, :class_name => "Agency", :join_table => "series_link_creating_agencies"
  has_and_belongs_to_many :persons, :class_name => "Person", :join_table => "series_link_persons"
  has_and_belongs_to_many :preceding_series, :class_name => "Series", :join_table => "series_link_preceding_series" ,  :foreign_key => "series_id", :association_foreign_key => "preceding_id"
  has_and_belongs_to_many :succeeding_series, :class_name => "Series", :join_table => "series_link_succeeding_series" , :foreign_key => "series_id", :association_foreign_key => "succeeding_id"
  has_and_belongs_to_many :related_series, :class_name => "Series", :join_table => "series_link_related_series", :foreign_key => "series_id", :association_foreign_key => "related_id"
  
  searchable do 
    text :Series_title, :boost => 2
    text :description, :using => :Descriptive_note, :stored => true
     integer :start_year, :trie => true do |series|
      series.Start_date ? series.Start_date.year : nil
    end
    integer :end_year, :trie => true do |series|
      series.End_date ? series.End_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Series_title, :stored => true
    integer :id, :using => :Series_number, :stored => true
  end
  
  def contents_date_range
    date_string self.Contents_start_date_qualifier, self.Contents_start_date, self.Contents_end_date_qualifier, self.Contents_end_date
  end
end

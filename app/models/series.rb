class Series < Entity
  set_table_name 'series_view'
  set_primary_key :Series_number
  has_many :items, :foreign_key => 'Series_number'
  searchable do 
    text :Series_title, :boost => 2
    text :description, :using => :Descriptive_note, :stored => true
     integer :start_year, :trie => true do |series|
      series.Start_date ? series.Start_date.year : nil
    end
    integer :end_year, :trie => true do |series|
      series.End_date ? series.End_date.year : nil
    end
    string :title, :using => :Series_title, :stored => true
    integer :id, :using => :Series_number, :stored => true
  end
  
  def contents_date_range
    date_string self.Contents_start_date_qualifier, self.Contents_start_date, self.Contents_end_date_qualifier, self.Contents_end_date
  end
end

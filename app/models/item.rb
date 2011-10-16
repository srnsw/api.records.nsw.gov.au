class Item < Entity
  set_table_name 'items_view'
  set_primary_key :ID
  belongs_to :series, :foreign_key => 'Series_number'

  alias_attribute :title, :Item_title
  
  searchable do 
    text :Item_title, :boost => 2
    text :description, :using => :Descriptive_Note, :stored => true
    string :location, :stored => true do |items|
      simple_location items.series.Repository
    end
    integer :start_year, :trie => true do |item|
      item.Start_date ? item.Start_date.year : nil
    end
    integer :end_year, :trie => true do |item|
      item.End_date ? item.End_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    integer :Series_number, :references => Series
    string :title, :using => :Item_title, :stored => true
    integer :id, :using => :ID, :stored => true
  end
  
  def date_range
    date_string nil, self.Start_date, nil, self.End_date
  end
end

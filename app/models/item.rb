class Item < Entity
  set_table_name 'items'
  set_primary_key :ID
  belongs_to :series, :foreign_key => 'Series_number'
  searchable do 
    text :Item_title, :boost => 2
    text :description, :using => :Descriptive_Note, :stored => true
    integer :start_year, :trie => true do |item|
      item.Start_date ? item.Start_date.year : nil
    end
    integer :end_year, :trie => true do |item|
      item.End_date ? item.End_date.year : nil
    end
    integer :Series_number, :references => Series
    string :title, :using => :Item_title, :stored => true
    integer :id, :using => :ID, :stored => true
  end
  
  def date_range
    date_string nil, self.Start_date, nil, self.End_date
  end
end

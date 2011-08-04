class Ministry < Entity
  set_table_name 'ministries_view'
  set_primary_key :Ministry_number
  
  has_and_belongs_to_many :portfolios, :class_name => "Portfolio", :join_table => "ministries_link_portfolios"
  
  searchable do 
    text :Ministry_title, :boost => 2
    integer :start_year, :trie => true do |ministry|
      ministry.Start_date ? ministry.Start_date.year : nil
    end
    integer :end_year, :trie => true do |ministry|
      ministry.End_date ? ministry.End_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Ministry_title, :stored => true
    integer :id, :using => :Ministry_number, :stored => true
  end
  
  def date_range
    date_string nil, self.Start_date, nil, self.End_date
  end
end

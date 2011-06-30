class Portfolio < Entity
  set_table_name 'portfolios_view'
  set_primary_key :Portfolio_number
  
  has_and_belongs_to_many :ministries, :class_name => "Ministry", :join_table => "portfolios_link_ministries"
  has_and_belongs_to_many :persons, :class_name => "Person", :join_table => "portfolios_link_persons"
  has_and_belongs_to_many :agencies, :class_name => "Agency", :join_table => "portfolios_link_agencies"
  has_and_belongs_to_many :preceding, :class_name => "Portfolio", :join_table => "portfolios_link_preceding",  :foreign_key => "portfolio_id", :association_foreign_key => "preceding_id" 
  has_and_belongs_to_many :succeeding, :class_name => "Portfolio", :join_table => "portfolios_link_succeeding",  :foreign_key => "portfolio_id", :association_foreign_key => "succeeding_id" 
  
  
  searchable do 
    text :Portfolio_title, :boost => 2
    text :Descriptive_note
    integer :start_year, :trie => true do |portfolio|
      portfolio.Start_date ? portfolio.Start_date.year : nil
    end
    integer :end_year, :trie => true do |portfolio|
      portfolio.End_date ? portfolio.End_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :Portfolio_title, :stored => true
    integer :id, :using => :Portfolio_number, :stored => true
  end
end

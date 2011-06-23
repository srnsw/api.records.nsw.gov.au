class Ministry < Entity
  set_table_name 'ministries_view'
  set_primary_key :Ministry_number
  
  has_and_belongs_to_many :portfolios, :class_name => "Portfolio", :join_table => "ministries_link_portfolios"
  
  def date_range
    date_string nil, self.Start_date, nil, self.End_date
  end
end

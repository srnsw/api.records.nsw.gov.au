class Ministry < Entity
  set_table_name 'ministries'
  set_primary_key :Ministry_number
  
  def date_range
    date_string nil, self.Start_date, nil, self.End_date
  end
end

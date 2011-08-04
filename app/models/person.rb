class Person < Entity
  set_table_name 'persons_view'
  set_primary_key :Person_number
  
  has_and_belongs_to_many :functions, :class_name => "Function", :join_table => "persons_link_functions"
  has_and_belongs_to_many :agencies, :class_name => "Agency", :join_table => "persons_link_agencies"
  has_and_belongs_to_many :series, :class_name => "Series", :join_table => "persons_link_series"
  has_and_belongs_to_many :portfolios, :class_name => "Portfolio", :join_table => "persons_link_portfolios"
  has_and_belongs_to_many :ministries, :class_name => "Ministry", :join_table => "persons_link_ministries"
  
  searchable do 
    text :name_short, :boost => 2
    text :Biographical_note
    integer :start_year, :trie => true do |person|
      person.Birth_date ? person.Birth_date.year : nil
    end
    integer :end_year, :trie => true do |person|
      person.Death_date ? person.Death_date.year : nil
    end
    time :modified, :using => :Last_amendment_date, :trie => true, :stored => true
    string :title, :using => :name_short, :stored => true
    integer :id, :using => :Person_number, :stored => true
  end
  
  def name_short
    name = String.new
    name += self.Surname if self.Surname
    if self.Given_names 
      name += ", " if self.Surname
      name += self.Given_names 
    end
    name
  end
  
  def name_long
    name = String.new
    name += self.Prenomial_honorifics + " " if self.Prenomial_honorifics
    name += self.Given_names + " " if self.Given_names
    name += self.Surname if self.Surname
    name += " (" + self.Postnomial_honorifics + ")" if self.Postnomial_honorifics
    name
  end
  
  def date_range
    date_string self.Birth_date_qualifier, self.Birth_date, self.Death_date_qualifier, self.Death_date
  end
end

  

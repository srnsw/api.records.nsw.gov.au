class Agency < Entity
  set_table_name 'agencies'
  set_primary_key :Agency_number
  searchable do 
    text :Agency_title, :boost => 2
    text :Administrative_history_note
    integer :start_year, :trie => true do |agency|
      agency.Start_date ? agency.Start_date.year : nil
    end
    integer :end_year, :trie => true do |agency|
      agency.End_date ? agency.End_date.year : nil
    end
    string :title, :using => :Agency_title, :stored => true
    integer :id, :using => :Agency_number, :stored => true
  end
end

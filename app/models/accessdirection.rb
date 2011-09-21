class Accessdirection < ActiveRecord::Base

set_table_name :accessdirections_view
set_primary_key :id

 
  searchable do 
    text :agency_title, :boost => 2
    text :scope
    text :type_access

    string :title, :using => :agency_title, :stored => true
    string :scope, :using => :scope, :stored => true
    integer :id, :using => :id, :stored => true
  end
  
end
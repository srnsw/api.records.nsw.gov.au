class Accessdirection < ActiveRecord::Base

set_table_name :accessdirections_view
set_primary_key :id

 
  searchable do 
    text :agency_title, :boost => 2
    text :scope
    text :type_access

    text :title, :using => :agency_title, :stored => true
    text :scope, :stored => true
    integer :id, :stored => true
  end
  
end
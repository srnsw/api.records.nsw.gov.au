class Entity < ActiveRecord::Base
#
# TO DO: Rails allows connections to multiple databases. SRNSW's API could act
# as front-end to separate data stores (AI, Photosearch, disposal authorities, digital archive, user-generated content)
#
# This entity model could be based on a direct, read-only connection to AI's SQL-server database.
#
# From Rails's documentation...
#
# Connection to multiple databases in different models (http://api.rubyonrails.org/classes/ActiveRecord/Base.html)
#
# Connections are usually created through ActiveRecord::Base.establish_connection and retrieved by ActiveRecord::Base.connection.
# All classes inheriting from ActiveRecord::Base will use this connection.
# But you can also set a class-specific connection. For example, if Course is an ActiveRecord::Base,
# but resides in a different database, you can just say Course.establish_connection
# and Course and all of its subclasses will use this connection instead.
#
# This feature is implemented by keeping a connection pool in ActiveRecord::Base
# that is a Hash indexed by the class. If a connection is requested,
# the retrieve_connection method will go up the class-hierarchy until a connection is found in the connection pool.
#
# add custom pagination
extend SRNSW::Pages

  def date_range
    date_string self.Start_date_qualifier, self.Start_date, self.End_date_qualifier, self.End_date
  end
  
  # used in eac-cpf views
  def date_start
    parse_date(self.Start_date_qualifier, self.Start_date)
  end
  
  def date_end
    parse_date(self.End_date_qualifier, self.End_date)
  end
  
  def date_string start_qual, start_date, end_qual=nil, end_date=nil
    date_string = String.new
    start_date = parse_date(start_qual, start_date)
    if end_date
      end_date = parse_date(end_qual, end_date)
    end
    
    if start_date
      date_string += start_date
      if end_date
        date_string += " to "
        date_string += end_date
      else
        date_string += " +"
      end
    elsif end_date
      date_string += "- "
      date_string += end_date
    else
      date_string += "unknown"
    end
  end

  def parse_date qualifier, date
    if date
      if (qualifier.nil? or qualifier.strip.empty?)
        day_month_year(date)
      elsif qualifier == "year only" 
        date.year.to_s
      else
       string = ["?", "circa", "c", "c."].index(qualifier) ? "c. " : qualifier + " "
       string += day_month_year(date)
      end
    else
      nil
    end
  end
  
  def day_month_year date
    date.day.to_s + "/" + date.month.to_s + "/" + date.year.to_s
  end
end

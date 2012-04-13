class Entity < ActiveRecord::Base

  # add custom pagination
  extend SRNSW::Pages

   LOCATIONS = Hash.new
	 LOCATIONS["Charles Sturt"] = "Charles Sturt University Regional Archives, Wagga Wagga"
	 LOCATIONS["University of Newcastle"] = "Auchmuty Library, University of Newcastle"
	 LOCATIONS["New England"] = "University of New England and Regional Archives, Armidale"
	 LOCATIONS["Outback"] = "Outback Archives, Broken Hill City Library"
	 LOCATIONS["Police Force"] = "New South Wales Police Force"
	 LOCATIONS["Newcastle Region"] = "Newcastle Region Library"
	 LOCATIONS["Mitchell"] = "Mitchell Library, State Library of NSW"
	 LOCATIONS["University of Western Sydney"] = "University of Western Sydney, Hawkesbury"
	 LOCATIONS["University of Wollongong"] = "Library, University of Wollongong"
	 
	 DEFAULT_LOCATION = "Western Sydney Records Centre, Kingswood"
	 
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

  def self.simple_location location
   loc = DEFAULT_LOCATION
	 LOCATIONS.keys.each do |key| 
	   if location.include? key
		   loc = LOCATIONS[key]
		   break
		 end
	 end
	 loc
  end 
  
  def comments
	@comments = Comment.where(:entitytype => self.class.name).and(:entityid => self.id).order_by([:created_at, :asc])	
  end
  
  def tags
	@tags = Tag.where(:entitytype => self.class.name).and(:entityid => self.id).order_by([:created_at, :asc])
  end
  
end

class Entity < ActiveRecord::Base

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

  def self.simple_location location
   #for some weird text which has no dot at the end of sentence.
   location = location.sub(" however", ". however")
   #we do expect to have at least one dot to match the end of a sentence
   #but some of the data doesn't contain it
   location = location.concat(".")
   location = "No location" unless location.blank?
   regexp = /^.*?[A-Z].*?([A-Z].*?)\./
   match = regexp.match(location)
   if match
  	  match = match[1]
  	else
  	  location
  	end
  end 
  
  def comments
	@comments = Comment.where(:entitytype => self.class.name).and(:entityid => self.id).order_by([:created_at, :asc])	
  end
  
  def tags
	@tags = Tag.where(:entitytype => self.class.name).and(:entityid => self.id).order_by([:created_at, :asc])
  end
  
  def dbg
   "#{self.class.name}-#{self.id}"
  end
end

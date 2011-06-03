class FixDb < ActiveRecord::Migration
  def self.up
    change_column "activities", "Activity_number", :integer
    change_column "activities", "Start_date", :date
    change_column "activities", "End_date", :date
    change_column "agencies", "Agency_number", :integer
    change_column "agencies", "Start_date", :date
    change_column "agencies", "End_date", :date
    change_column "functions", "Function_number", :integer
    change_column "functions", "Start_date", :date
    change_column "items", "ID", :integer
    change_column "items", "Series_number", :integer
    change_column "items", "Start_date", :date
    change_column "items", "End_date", :date
    change_column "items", "ImagesCount", :integer
    change_column "ministries", "Ministry_number", :integer
    change_column "ministries", "Start_date", :date
    change_column "ministries", "End_date", :date
    change_column "organisations", "Organisation_number", :integer
    change_column "organisations", "Start_date", :date
    change_column "organisations", "End_date", :date
    change_column "organisations", "Commonwealth_Organisation_CO_number", :integer
    change_column "persons", "Person_number", :integer
    change_column "persons", "Birth_date", :date
    change_column "persons", "Death_date", :date
    change_column "persons", "Minister", :boolean
    change_column "portfolios", "Portfolio_number", :integer
    change_column "portfolios", "Start_date", :date
    change_column "portfolios", "End_date", :date
    change_column "series", "Series_number", :integer
    change_column "series", "Start_date", :date
    change_column "series", "End_date", :date
    change_column "series", "Contents_start_date", :date
    change_column "series", "Contents_end_date", :date
  end

  def self.down
    raise ActiveRecord::IrreversibleMIgration
  end
end

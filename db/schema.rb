# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110330071710) do

  create_table "activities", :id => false, :force => true do |t|
    t.integer "Activity_number"
    t.text    "Activity_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "End_date_qualifier"
    t.date    "End_date"
    t.text    "Creation"
    t.text    "Abolition"
    t.text    "Descriptive_note"
  end

  create_table "agencies", :id => false, :force => true do |t|
    t.integer "Agency_number"
    t.text    "Agency_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "End_date_qualifier"
    t.date    "End_date"
    t.text    "Category"
    t.text    "Creation"
    t.text    "Abolition"
    t.text    "Administrative_history_note"
  end

  create_table "functions", :id => false, :force => true do |t|
    t.integer "Function_number"
    t.text    "Function_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "Descriptive_note"
  end

  create_table "items", :id => false, :force => true do |t|
    t.integer "ID"
    t.text    "SeriesType"
    t.integer "Series_number"
    t.text    "Item_number_or_control_symbol"
    t.text    "Item_title"
    t.text    "Descriptive_Note"
    t.date    "Start_date"
    t.date    "End_date"
    t.text    "AccessDirectionNo"
    t.integer "ImagesCount"
    t.text    "Availability"
  end

  create_table "ministries", :id => false, :force => true do |t|
    t.integer "Ministry_number"
    t.text    "Ministry_title"
    t.date    "Start_date"
    t.date    "End_date"
  end

  create_table "organisations", :id => false, :force => true do |t|
    t.integer "Organisation_number"
    t.text    "Organisation_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "End_date_qualifier"
    t.date    "End_date"
    t.text    "Creation"
    t.text    "Abolition"
    t.text    "Administrative_history_note"
    t.integer "Commonwealth_Organisation_CO_number"
  end

  create_table "persons", :id => false, :force => true do |t|
    t.integer "Person_number"
    t.text    "Surname"
    t.text    "Given_names"
    t.text    "Birth_date_qualifier"
    t.date    "Birth_date"
    t.text    "Death_date_qualifier"
    t.date    "Death_date"
    t.text    "Alternative_name"
    t.text    "Prenomial_honorifics"
    t.text    "Postnomial_honorifics"
    t.text    "Offices_held"
    t.text    "Biographical_note"
    t.boolean "Minister"
  end

  create_table "portfolios", :id => false, :force => true do |t|
    t.integer "Portfolio_number"
    t.text    "Portfolio_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "End_date_qualifier"
    t.date    "End_date"
    t.text    "Descriptive_note"
  end

  create_table "series", :id => false, :force => true do |t|
    t.integer "Series_number"
    t.text    "Series_title"
    t.text    "Start_date_qualifier"
    t.date    "Start_date"
    t.text    "End_date_qualifier"
    t.date    "End_date"
    t.text    "Contents_start_date_qualifier"
    t.date    "Contents_start_date"
    t.text    "Contents_end_date_qualifier"
    t.date    "Contents_end_date"
    t.text    "Descriptive_note"
    t.text    "Format"
    t.text    "Arrangement"
    t.text    "Copies"
    t.text    "Bridging_aids"
    t.text    "Series_control_status"
    t.text    "Repository"
  end

end

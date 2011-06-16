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

ActiveRecord::Schema.define(:version => 0) do

  create_table "AccessDirections", :id => false, :force => true do |t|
    t.integer  "ADNo",                               :null => false
    t.string   "FileNo",             :limit => 50
    t.integer  "ADJobNo",                            :null => false
    t.integer  "AgencyNo",                           :null => false
    t.string   "AgencyTitle"
    t.integer  "ResponsAgNo"
    t.text     "Scope"
    t.text     "FurtherDetails"
    t.string   "Location",           :limit => 20
    t.string   "Effect",             :limit => 5
    t.string   "TypeAccess",         :limit => 15
    t.string   "DurationCPA",        :limit => 50
    t.text     "ReasonsCPA"
    t.string   "ContactAgent",       :limit => 120
    t.string   "AuthAgent",          :limit => 120
    t.datetime "AuthorisationDate"
    t.datetime "NextReviewDate"
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",        :limit => 20
    t.string   "StaffNote",          :limit => 2000
    t.string   "Status",             :limit => 10
    t.string   "RegistrationStatus", :limit => 50,   :null => false
  end

  create_table "Activities", :id => false, :force => true do |t|
    t.integer  "Activity number",                    :null => false
    t.string   "Activity title",                     :null => false
    t.string   "Start date qualifier", :limit => 50, :null => false
    t.datetime "Start date"
    t.string   "End date qualifier",   :limit => 50, :null => false
    t.datetime "End date"
    t.text     "Creation",                           :null => false
    t.string   "Abolition",                          :null => false
    t.text     "Descriptive note",                   :null => false
    t.string   "Registered by",        :limit => 50, :null => false
    t.datetime "Registered date",                    :null => false
    t.text     "Amendments",                         :null => false
    t.datetime "Last amendment date"
    t.text     "Archives note",                      :null => false
    t.string   "Registration status",  :limit => 50, :null => false
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",          :limit => 20
  end

  create_table "ActivityLog", :primary_key => "ID", :force => true do |t|
    t.string   "ActivityType", :limit => 50,  :null => false
    t.integer  "ErrorCode",                   :null => false
    t.string   "Comments",     :limit => 500
    t.datetime "UpdatedDate",                 :null => false
  end

  create_table "Agencies", :id => false, :force => true do |t|
    t.integer  "Agency number",                                   :null => false
    t.string   "Agency title",                                    :null => false
    t.string   "Start date qualifier",              :limit => 50, :null => false
    t.datetime "Start date",                                      :null => false
    t.string   "End date qualifier",                :limit => 50, :null => false
    t.datetime "End date"
    t.string   "Category",                          :limit => 50, :null => false
    t.text     "Creation",                                        :null => false
    t.text     "Abolition"
    t.text     "Administrative history note",                     :null => false
    t.text     "Unregistered preceding agencies"
    t.text     "Unregistered succeeding agencies"
    t.text     "Unregistered superior agencies"
    t.text     "Unregistered subordinate agencies"
    t.text     "Unregistered related agencies"
    t.string   "Registered by",                     :limit => 50, :null => false
    t.datetime "Registered date",                                 :null => false
    t.string   "Amendments",                                      :null => false
    t.datetime "Last amendment date"
    t.text     "Archives note",                                   :null => false
    t.string   "Registration status",               :limit => 50, :null => false
    t.text     "Related Agencies",                                :null => false
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",                       :limit => 20
  end

  create_table "Classes", :id => false, :force => true do |t|
    t.integer "ID",                       :null => false
    t.string  "ClassDesc", :limit => 100, :null => false
    t.integer "Internal",  :limit => 1,   :null => false
  end

  create_table "Consignments", :id => false, :force => true do |t|
    t.integer  "Counter",                                            :null => false
    t.integer  "Consignment number",                                 :null => false
    t.integer  "Series number",                                      :null => false
    t.string   "Consignment type",                    :limit => 50,  :null => false
    t.integer  "Transferring agency"
    t.string   "Agency contact",                      :limit => 50,  :null => false
    t.integer  "Transferring person"
    t.string   "Unregistered transferor surname",     :limit => 50,  :null => false
    t.string   "Unregistered transferor given names", :limit => 50,  :null => false
    t.datetime "Transfer date"
    t.string   "Acquisition file number",             :limit => 50,  :null => false
    t.string   "Disposal status",                     :limit => 200, :null => false
    t.datetime "Destruction due date"
    t.string   "Destruction authorisation",           :limit => 50,  :null => false
    t.datetime "Destroyed date"
    t.float    "Quantity in metres",                  :limit => nil
    t.string   "Location start",                      :limit => 50,  :null => false
    t.string   "Location end",                        :limit => 50,  :null => false
    t.string   "Registered by",                       :limit => 50,  :null => false
    t.datetime "Registered date",                                    :null => false
    t.text     "Amendments",                                         :null => false
    t.datetime "Last amendment date"
    t.string   "Registration status",                 :limit => 50,  :null => false
    t.text     "Archives note",                                      :null => false
    t.string   "Transferred by",                      :limit => 50,  :null => false
    t.string   "Converted from",                      :limit => 50,  :null => false
    t.integer  "Repository"
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",                         :limit => 20
  end

  create_table "EntityImage", :id => false, :force => true do |t|
    t.integer "EntityType", :null => false
    t.integer "EntityID",   :null => false
    t.integer "ImageID",    :null => false
  end

  create_table "EntityRelationships", :id => false, :force => true do |t|
    t.integer "ID",                           :null => false
    t.integer "ParentType",                   :null => false
    t.integer "ParentID",                     :null => false
    t.integer "ChildType",                    :null => false
    t.integer "ChildID",                      :null => false
    t.integer "RelType",                      :null => false
    t.string  "SDateQualifier", :limit => 50, :null => false
    t.string  "SDate",          :limit => 20, :null => false
    t.string  "EDateQualifier", :limit => 50, :null => false
    t.string  "EDate",          :limit => 20, :null => false
    t.text    "Note",                         :null => false
  end

  create_table "Functions", :id => false, :force => true do |t|
    t.integer  "Function number",                    :null => false
    t.string   "Function title",                     :null => false
    t.string   "Start date qualifier", :limit => 50, :null => false
    t.datetime "Start date"
    t.string   "End date qualifier",   :limit => 50, :null => false
    t.datetime "End date"
    t.text     "Creation",                           :null => false
    t.text     "Abolition",                          :null => false
    t.text     "Descriptive note",                   :null => false
    t.string   "Registered by",        :limit => 50, :null => false
    t.datetime "Registered date",                    :null => false
    t.string   "Amendments",                         :null => false
    t.datetime "Last amendment date"
    t.text     "Archives note",                      :null => false
    t.string   "Registration status",  :limit => 50, :null => false
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",          :limit => 20
  end

  create_table "HelpContents", :id => false, :force => true do |t|
    t.integer  "ID",                        :null => false
    t.integer  "ParentID",                  :null => false
    t.string   "Title",      :limit => 100, :null => false
    t.text     "Contents"
    t.integer  "Enabled",                   :null => false
    t.datetime "UpdateDate",                :null => false
    t.string   "UpdateUser", :limit => 50,  :null => false
  end

  create_table "Images", :id => false, :force => true do |t|
    t.integer  "ImageID",                                   :null => false
    t.string   "ImageCaption",              :limit => 512,  :null => false
    t.string   "ImagePath",                 :limit => 200
    t.string   "ImageFileName",             :limit => 200
    t.integer  "Creating Agency Number"
    t.string   "Creating Agency"
    t.integer  "Controlling Agency Number"
    t.string   "Controlling Agency"
    t.integer  "Series Number"
    t.string   "Job Number",                :limit => 5
    t.string   "Date Qualifier",            :limit => 50
    t.datetime "Date"
    t.string   "Location",                  :limit => 50
    t.string   "Original Number",           :limit => 50
    t.string   "Format",                    :limit => 50
    t.string   "Size",                      :limit => 50
    t.string   "Publisher",                 :limit => 50
    t.string   "Language",                  :limit => 10
    t.string   "Source",                    :limit => 100
    t.string   "Relation",                  :limit => 1000
    t.string   "Coverage",                  :limit => 50
    t.string   "Rights",                    :limit => 50
    t.string   "Keywords"
    t.string   "People"
    t.string   "Creator"
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",               :limit => 20
  end

  create_table "Items", :id => false, :force => true do |t|
    t.integer  "ID",                                           :null => false
    t.string   "SeriesType",                    :limit => 20
    t.integer  "Series number"
    t.integer  "Consignment number"
    t.integer  "Accession number"
    t.integer  "Container number"
    t.string   "Item number or control symbol", :limit => 20,  :null => false
    t.string   "Item title",                    :limit => 500, :null => false
    t.text     "Descriptive Note"
    t.datetime "Start date"
    t.datetime "End date"
    t.string   "LENDing status",                :limit => 50,  :null => false
    t.string   "GRR number",                    :limit => 10,  :null => false
    t.string   "AccessDirectionNo",             :limit => 50,  :null => false
    t.string   "ColumnA",                       :limit => 50,  :null => false
    t.string   "ColumnB",                       :limit => 50,  :null => false
    t.string   "ColumnC",                       :limit => 50,  :null => false
    t.integer  "ImagesCount",                                  :null => false
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",                   :limit => 20
    t.string   "Prefix",                        :limit => 20
    t.integer  "Stroke"
    t.integer  "Number"
    t.integer  "Point"
    t.string   "Suffix",                        :limit => 20
    t.string   "Box",                           :limit => 20
    t.string   "Availability",                  :limit => 500
  end

  create_table "MSreplication_objects", :id => false, :force => true do |t|
    t.string "publisher",    :limit => 128
    t.string "publisher_db", :limit => 128
    t.string "publication",  :limit => 128
    t.string "object_name",  :limit => 128, :null => false
    t.string "object_type",  :limit => 2,   :null => false
    t.string "article",      :limit => 128
  end

  add_index "MSreplication_objects", ["object_name"], :name => "ucMSreplication_objects"

  create_table "MSreplication_subscriptions", :id => false, :force => true do |t|
    t.string   "publisher",             :limit => 128, :null => false
    t.string   "publisher_db",          :limit => 128
    t.string   "publication",           :limit => 128
    t.boolean  "independent_agent",                    :null => false
    t.integer  "subscription_type",                    :null => false
    t.string   "distribution_agent",    :limit => 128
    t.datetime "time",                                 :null => false
    t.string   "description"
    t.binary   "transaction_timestamp", :limit => 16,  :null => false
    t.integer  "update_mode",           :limit => 1,   :null => false
    t.binary   "agent_id"
    t.binary   "subscription_guid"
    t.binary   "subid"
    t.boolean  "immediate_sync",                       :null => false
  end

  add_index "MSreplication_subscriptions", ["publication", "publisher_db", "publisher", "subscription_type", "transaction_timestamp"], :name => "uc1MSReplication_subscriptions", :unique => true

  create_table "MSsavedforeignkeycolumns", :id => false, :force => true do |t|
    t.string   "program_name",            :limit => 128, :null => false
    t.string   "constraint_name",         :limit => 128, :null => false
    t.string   "parent_schema",           :limit => 128, :null => false
    t.integer  "constraint_column_id",                   :null => false
    t.string   "referencing_column_name", :limit => 128, :null => false
    t.string   "referenced_column_name",  :limit => 128, :null => false
    t.datetime "timestamp",                              :null => false
  end

  add_index "MSsavedforeignkeycolumns", ["program_name", "constraint_name", "parent_schema", "constraint_column_id"], :name => "ci_MSsavedforeignkeycolumns"
  add_index "MSsavedforeignkeycolumns", ["timestamp"], :name => "nci_MSsavedforeignkeycolumns_timestamp"

# Could not dump table "MSsavedforeignkeyextendedproperties" because of following StandardError
#   Unknown type 'sql_variant' for column 'property_value'

  create_table "MSsavedforeignkeys", :id => false, :force => true do |t|
    t.string   "program_name",              :limit => 128, :null => false
    t.string   "constraint_name",           :limit => 128, :null => false
    t.string   "parent_schema",             :limit => 128, :null => false
    t.string   "parent_name",               :limit => 128, :null => false
    t.string   "referenced_object_schema",  :limit => 128, :null => false
    t.string   "referenced_object_name",    :limit => 128, :null => false
    t.boolean  "is_disabled",                              :null => false
    t.boolean  "is_not_for_replication",                   :null => false
    t.boolean  "is_not_trusted",                           :null => false
    t.integer  "delete_referential_action", :limit => 1,   :null => false
    t.integer  "update_referential_action", :limit => 1,   :null => false
    t.datetime "timestamp",                                :null => false
  end

  add_index "MSsavedforeignkeys", ["program_name", "constraint_name", "parent_schema"], :name => "ci_MSsavedforeignkeys"
  add_index "MSsavedforeignkeys", ["timestamp"], :name => "nci_MSsavedforeignkeys_timestamp"

  create_table "MSsnapshotdeliveryprogress", :id => false, :force => true do |t|
    t.string   "session_token",       :limit => 260, :null => false
    t.integer  "progress_token_hash",                :null => false
    t.string   "progress_token",      :limit => 500, :null => false
    t.datetime "progress_timestamp"
  end

  add_index "MSsnapshotdeliveryprogress", ["progress_token_hash"], :name => "ci_MSsnapshotdeliveryprogress_progress_token_hash"
  add_index "MSsnapshotdeliveryprogress", ["session_token"], :name => "nci_MSsnapshotdeliveryprogress_session_token"

  create_table "MSsubscription_agents", :force => true do |t|
    t.string   "publisher",               :limit => 128, :null => false
    t.string   "publisher_db",            :limit => 128, :null => false
    t.string   "publication",             :limit => 128, :null => false
    t.integer  "subscription_type",                      :null => false
    t.string   "queue_id",                :limit => 128
    t.integer  "update_mode",             :limit => 1,   :null => false
    t.boolean  "failover_mode",                          :null => false
    t.integer  "spid",                                   :null => false
    t.datetime "login_time",                             :null => false
    t.boolean  "allow_subscription_copy",                :null => false
    t.integer  "attach_state",                           :null => false
    t.binary   "attach_version",                         :null => false
    t.integer  "last_sync_status"
    t.string   "last_sync_summary",       :limit => 128
    t.datetime "last_sync_time"
    t.string   "queue_server",            :limit => 128
  end

  add_index "MSsubscription_agents", ["id"], :name => "ucMSsubscription_agents_id"
  add_index "MSsubscription_agents", ["publication", "publisher_db", "publisher", "subscription_type"], :name => "ucMSsubscription_agents", :unique => true

  create_table "Ministries", :id => false, :force => true do |t|
    t.integer  "Ministry number",                   :null => false
    t.string   "Ministry title",      :limit => 50
    t.datetime "Start date"
    t.datetime "End date"
    t.string   "Registered by",       :limit => 50, :null => false
    t.datetime "Registered date",                   :null => false
    t.string   "Amendments"
    t.datetime "Last amendment date"
    t.text     "Archives note"
    t.string   "Registration status", :limit => 50
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",         :limit => 20
  end

  create_table "OrderSeriesFlags", :id => false, :force => true do |t|
    t.integer "SeriesNo",        :null => false
    t.boolean "Copy"
    t.boolean "PreOrder"
    t.integer "CustomItemPrice"
  end

  create_table "Orders", :id => false, :force => true do |t|
    t.integer  "OrderNo",                 :null => false
    t.integer  "CartType",                :null => false
    t.text     "ClientData",              :null => false
    t.datetime "RequestTimestamp",        :null => false
    t.integer  "Status",                  :null => false
    t.datetime "ResponseTimestamp"
    t.datetime "MailSentTimestamp"
    t.datetime "ClientMailSentTimestamp"
    t.integer  "PaymentNo"
    t.text     "Errors"
  end

  create_table "Organisations", :id => false, :force => true do |t|
    t.integer  "Organisation number",                                   :null => false
    t.string   "Organisation title",                                    :null => false
    t.string   "Start date qualifier",                   :limit => 50
    t.datetime "Start date",                                            :null => false
    t.string   "End date qualifier",                     :limit => 50
    t.datetime "End date"
    t.string   "Creation"
    t.string   "Abolition"
    t.text     "Administrative history note"
    t.text     "Unregistered preceding organisation"
    t.text     "Unregistered succeeding organisations"
    t.text     "Unregistered superior organisations"
    t.text     "Unregistered subordinate organisations"
    t.float    "Commonwealth Organisation (CO) number",  :limit => nil
    t.string   "Registered by",                          :limit => 50,  :null => false
    t.datetime "Registered date",                                       :null => false
    t.string   "Amendments"
    t.datetime "Last amendment date"
    t.text     "Archives note"
    t.string   "Registration status",                    :limit => 50
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",                            :limit => 20
  end

  create_table "Persons", :id => false, :force => true do |t|
    t.integer  "Person number",                       :null => false
    t.string   "Surname",               :limit => 50, :null => false
    t.string   "Given names",           :limit => 50, :null => false
    t.string   "Birth date qualifier",  :limit => 50, :null => false
    t.datetime "Birth date"
    t.string   "Death date qualifier",  :limit => 50, :null => false
    t.datetime "Death date"
    t.string   "Alternative name",      :limit => 50, :null => false
    t.string   "Prenomial honorifics",  :limit => 50, :null => false
    t.string   "Postnomial honorifics", :limit => 50, :null => false
    t.text     "Offices held",                        :null => false
    t.text     "Biographical note",                   :null => false
    t.string   "Registered by",         :limit => 50, :null => false
    t.datetime "Registered date",                     :null => false
    t.string   "Amendments",                          :null => false
    t.datetime "Last amendment date"
    t.text     "Archives note",                       :null => false
    t.string   "Registration status",   :limit => 50, :null => false
    t.boolean  "Minister"
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",           :limit => 20
  end

  create_table "Portfolios", :id => false, :force => true do |t|
    t.integer  "Portfolio number",                   :null => false
    t.string   "Portfolio title"
    t.string   "Start date qualifier", :limit => 50
    t.datetime "Start date"
    t.string   "End date qualifier",   :limit => 50
    t.datetime "End date"
    t.text     "Descriptive note"
    t.string   "Registered by",        :limit => 50, :null => false
    t.datetime "Registered date",                    :null => false
    t.string   "Amendments"
    t.datetime "Last amendment date"
    t.text     "Archives note"
    t.string   "Registration status",  :limit => 50
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",          :limit => 20
  end

  create_table "Reels", :primary_key => "ID", :force => true do |t|
    t.string  "Series", :limit => 50
    t.integer "Reel",   :limit => 2
    t.string  "Item"
    t.string  "Dates"
    t.text    "Ships"
    t.integer "Images", :limit => 2
  end

  create_table "Repositories", :id => false, :force => true do |t|
    t.integer  "No",                                     :null => false
    t.string   "Title",                   :limit => 30
    t.string   "Type",                    :limit => 5
    t.boolean  "Local Government",                       :null => false
    t.boolean  "State Government",                       :null => false
    t.boolean  "Public Health",                          :null => false
    t.boolean  "Cultural Institution",                   :null => false
    t.boolean  "Educational Institution",                :null => false
    t.string   "Description",             :limit => 100
    t.string   "Town",                    :limit => 20
    t.string   "Directions"
    t.datetime "Updated Date"
    t.string   "Updated User",            :limit => 20
    t.string   "ContactURL",              :limit => 500
  end

  create_table "Series", :id => false, :force => true do |t|
    t.integer  "Series number",                                  :null => false
    t.string   "Series title",                                   :null => false
    t.string   "Start date qualifier",            :limit => 50,  :null => false
    t.datetime "Start date",                                     :null => false
    t.string   "End date qualifier",              :limit => 50,  :null => false
    t.datetime "End date"
    t.string   "Contents start date qualifier",   :limit => 50,  :null => false
    t.datetime "Contents start date"
    t.string   "Contents end date qualifier",     :limit => 50,  :null => false
    t.datetime "Contents end date"
    t.text     "Descriptive note",                               :null => false
    t.string   "Format",                          :limit => 50,  :null => false
    t.text     "Arrangement",                                    :null => false
    t.text     "Unregistered preceding series",                  :null => false
    t.text     "Unregistered succeeding series",                 :null => false
    t.text     "Unregistered related series",                    :null => false
    t.text     "Unregistered controlling series",                :null => false
    t.text     "Unregistered controlled series",                 :null => false
    t.text     "Copies",                                         :null => false
    t.string   "Bridging aids",                   :limit => 500, :null => false
    t.string   "Disposal status",                 :limit => 500, :null => false
    t.string   "Other Disposal Instruments",      :limit => 500, :null => false
    t.string   "Access status",                                  :null => false
    t.string   "Restriction category",                           :null => false
    t.string   "Access note",                                    :null => false
    t.string   "Registered by",                   :limit => 50,  :null => false
    t.datetime "Registered date",                                :null => false
    t.string   "Amendments",                                     :null => false
    t.datetime "Last amendment date"
    t.text     "Archives note",                                  :null => false
    t.string   "Registration status",             :limit => 50,  :null => false
    t.string   "Series control status",                          :null => false
    t.string   "Repository",                      :limit => 500, :null => false
    t.datetime "UpdatedDate"
    t.string   "UpdatedUser",                     :limit => 20,  :null => false
  end

  create_table "Subjects", :primary_key => "ID", :force => true do |t|
    t.string "Subject"
  end

  create_table "Types", :id => false, :force => true do |t|
    t.integer "ClassID",                  :null => false
    t.integer "TypeID",                   :null => false
    t.string  "TypeCode",  :limit => 50,  :null => false
    t.string  "TypeDesc",  :limit => 200, :null => false
    t.string  "TypeValue", :limit => 100, :null => false
  end

  create_table "Variables", :id => false, :force => true do |t|
    t.integer "OrderNo",                                         :null => false
    t.decimal "StandardItemPrice", :precision => 5, :scale => 2, :null => false
  end

  create_table "sysdiagrams", :primary_key => "diagram_id", :force => true do |t|
    t.string  "name",         :limit => 128, :null => false
    t.integer "principal_id",                :null => false
    t.integer "version"
    t.binary  "definition"
  end

  add_index "sysdiagrams", ["principal_id", "name"], :name => "UK_principal_name", :unique => true

end

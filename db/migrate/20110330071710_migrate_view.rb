class MigrateView < ActiveRecord::Migration

 def self.up
   execute('CREATE VIEW activities_link_functions AS select 
		 ParentID as [activity_id], 
		 ChildID as [function_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where 
		 ChildType = 23 and
		 ParentType = 24')

    execute('CREATE VIEW activities_link_series AS select 
		 ParentID as [series_id], 
		 ChildID as [activity_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where  
		 Childtype = 24 and ParentType = 27')
 
    execute('CREATE VIEW activities_view AS select	Activities.[Activity number] as Activity_number,
			Activities.[Activity title] as Activity_title,
			NULLIF(Activities.[Start date qualifier],'') as Start_date_qualifier,
			Activities.[Start date] as Start_date,
			NULLIF(Activities.[End date qualifier],'') as End_date_qualifier,
			Activities.[End date] as End_date,
			NULLIF(CAST(Activities.[Creation] as varchar(max)),'') as Creation,
			NULLIF(Activities.[Abolition],'') as Abolition,
			Activities.[Descriptive note] as Descriptive_note,
			NULLIF(CAST(Activities.[Amendments] as varchar(max)),'') as Amendments, 
			Activities.[Last amendment date] as Last_amendment_date
		 from Activities')
 
   execute('CREATE VIEW agencies_link_functions AS select 
		 ParentID as [agency_id], 
		 ChildID as [function_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where
		ParentType = 25 and
		ChildType = 23
		and RelType = 271')
		
		
    execute('CREATE VIEW agencies_link_organisations AS select 
		 ParentID as [agency_id], 
		 ChildID as [organisation_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where
		ParentType = 25 and
		ChildType = 284
		and RelType = 271')
		
		execute('CREATE VIEW agencies_link_persons AS select 
		 ParentID as [person_id], 
		 ChildID as [agency_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where
		ParentType = 26 and
		ChildType = 25
		and RelType = 271')
		
		execute('CREATE VIEW agencies_link_preceding AS select 
		 ParentID as [agency_id], 
		 ChildID as [preceding_id],
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where
		ParentType = 25 and
		ChildType = 25 and
		RelType = 267')
		
		execute('CREATE VIEW agencies_link_related AS select 
		 related_id=convert(int, ChildID),
		 agency_id=convert(int, ParentID),
		 SDate,
		 SDateQualifier,
		 EDate,
		 EDateQualifier
		from 
		 EntityRelationships 
		where
		 ParentType = 25 and
		 ChildType = 25 and 
		 RelType = 271')
		
		execute('CREATE VIEW agencies_link_series_controlled AS select 
 ParentID as [series_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 27 and
ChildType = 25
and RelType = 264')

execute('CREATE VIEW agencies_link_series_created AS 
select 
 ParentID as [series_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 27 and
ChildType = 25
and RelType = 265')

execute('CREATE VIEW agencies_link_subordinates AS 
select 
 ParentID as [subordinate_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 25 and
ChildType = 25
and RelType = 269')

execute('CREATE VIEW agencies_link_succeeding AS 
select 
 ParentID as [succeeding_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 25 and
ChildType = 25
and RelType = 267')

execute('CREATE VIEW agencies_link_superiors AS 
select 
 ParentID as [agency_id], 
 ChildID as [superior_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 25 and
ChildType = 25
and RelType = 269')

execute('CREATE VIEW agencies_view AS 
select	[Agency number] as Agency_number,
	[Agency title] as Agency_title, 
	NULLIF([Start date qualifier],'') as Start_date_qualifier,
	[Start date] as Start_date, 
	NULLIF([End date qualifier],'') as End_date_qualifier,
	[End date] as End_date,
	[Category] as Category,
	NULLIF(CAST([Creation] as varchar(max)),'') as Creation, 
	NULLIF(CAST([Abolition] as varchar(max)),'')as Abolition,
	[Administrative history note] as Administrative_history_note,
	[Registered date] as Registered_date,
	[Last amendment date] as Last_amendment_date
from Agencies')

execute('CREATE VIEW functions_link_activities AS 
select 
 ParentID as [activity_id], 
 ChildID as [function_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 24 and
ChildType = 23')

execute('CREATE VIEW functions_link_agencies AS 
select 
 ParentID as [agency_id], 
 ChildID as [function_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 25 and
ChildType = 23')

execute('CREATE VIEW functions_link_persons AS 
select 
 ParentID as [person_id], 
 ChildID as [function_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 26 and
ChildType = 23')

execute('CREATE VIEW functions_view AS 
select [Function number] as Function_number,
[Function title] as Function_title, 
NULLIF([Start date qualifier],'') as Start_date_qualifier, 
[Start date] as Start_date,
NULLIF([End date qualifier],'') as End_date_qualifier, 
[End date] as End_date,
[Creation] as Creation, 
NULLIF(CAST([Abolition] as varchar(max)),'') as Abolition,
[Descriptive note] as Descriptive_note, 
[Registered date] as Registered_date,
[Last amendment date] as Last_amendment_date
from Functions')

execute('CREATE VIEW items_view AS 
select [ID] as ID,
[SeriesType] as SeriesType,
[Series number] as Series_number,
NULLIF([Item number or control symbol],'') as Item_number_or_control_symbol,
[Item title] as Item_title,
[Descriptive Note] as Descriptive_Note,
[Start date] as Start_date,
[End date] as End_date,
NULLIF([AccessDirectionNo],'') as AccessDirectionNo,
[ImagesCount] as ImagesCount,
[Availability] as Availability,
UpdatedDate as Last_amendment_date

from Items')

execute('CREATE VIEW ministries_link_portfolios AS 
select 
 ParentID as [portfolio_id], 
 ChildID as [ministry_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 283 and
ChildType = 285')

execute('CREATE VIEW ministries_view AS 
select   [Ministry number] as Ministry_number,
    [Ministry title] as Ministry_title,
    [Start date] as Start_date,
    [End date] as End_date,
    [Registered date] as Registered_date,
    [Last amendment date] as Last_amendment_date

from Ministries')

execute('CREATE VIEW organisations_link_agencies AS 
select 
 ParentID as [agency_id], 
 ChildID as [organisation_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 25 and ChildType = 284 and 
RelType = 271')

execute('CREATE VIEW organisations_link_preceding AS 
select 
 ParentID as [organisation_id], 
 ChildID as [preceding_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 284 and ChildType = 284 and 
RelType = 267')

execute('CREATE VIEW organisations_link_succeeding AS 
select 
 ParentID as [succeeding_id], 
 ChildID as [organisation_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 284 and ChildType = 284 and 
RelType = 267')

execute('CREATE VIEW organisations_view AS 
select    [Organisation number] as Organisation_number,
    [Organisation title] as Organisation_title,
    NULLIF([Start date qualifier],'') as Start_date_qualifier,
    [Start date] as Start_date,
    NULLIF([End date qualifier],'') as End_date_qualifier, 
    [End date] as End_date,
    [Creation] as Creation,
    NULLIF([Abolition],'') as Abolition,
    [Administrative history note] as Administrative_history_note,
    [Commonwealth Organisation (CO) number] as CO_number,
    [Registered date] as Registered_date,
    [Last amendment date] as Last_amendment_date
from Organisations')

execute('CREATE VIEW persons_link_agencies AS 
select 
 ParentID as [person_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 26 and
ChildType = 25')

execute('CREATE VIEW persons_link_functions AS 
select 
 ParentID as [person_id], 
 ChildID as [function_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 26 and
ChildType = 23')

execute('CREATE VIEW persons_link_ministries AS 
select 
 ParentID as [person_id], 
 ChildID as [ministry_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 26 and
ChildType = 285')

execute('CREATE VIEW persons_link_portfolios AS 
select 
 ParentID as [person_id], 
 ChildID as [portfolio_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 26 and
ChildType = 283')

execute('CREATE VIEW persons_link_series AS 
select 
 ParentID as [series_id], 
 ChildID as [person_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where 
ParentType = 27 and
ChildType = 26')

execute('CREATE VIEW persons_view AS 
select 
 [Person number] as Person_number, 
 [Surname] as Surname, 
 [Given names] as Given_names, 
 NULLIF([Birth date qualifier],'') as Birth_date_qualifier,  
 [Birth date] as Birth_date,
 NULLIF([Death date qualifier],'') as Death_date_qualifier,  
 [Death date] as Death_date,
 NULLIF([Alternative name],'') as Alternative_name,  
 NULLIF([Prenomial honorifics],'') as Prenomial_honorifics,  
 NULLIF([Postnomial honorifics],'') as Postnomial_honorifics, 
 [Offices held] as Offices_held,
 [Biographical note]as Biographical_note,
 [Registered date] as Registered_date, 
 [Last amendment date] as Last_amendment_date,
 [Registration status] as Registration_status, 
 [Minister] as Minister
 
 from Persons')
 
 execute('CREATE VIEW portfolios_link_agencies AS 
 select 
 ParentID as [agency_id], 
 ChildID as [portfolio_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 25 and
ChildType = 283')

execute('CREATE VIEW portfolios_link_ministries AS 
select 
 ParentID as [portfolio_id], 
 ChildID as [ministry_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 283 and
ChildType = 285')

execute('CREATE VIEW portfolios_link_persons AS 
select 
 ParentID as [person_id], 
 ChildID as [portfolio_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 26 and
ChildType = 283')

execute('CREATE VIEW portfolios_link_preceding AS 
select 
 ParentID as [portfolio_id], 
 ChildID as [preceding_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 283 and
ChildType = 283')

execute('CREATE VIEW portfolios_link_succeeding AS 
select 
 ParentID as [succeeding_id], 
 ChildID as [portfolio_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
ParentType = 283 and
ChildType = 283')

execute('CREATE VIEW portfolios_view AS 
select	[Portfolio number] as Portfolio_number,
    [Portfolio title] as Portfolio_title,
    NULLIF(CAST([Start date qualifier]as varchar(max)),'') as Start_date_qualifier,
    [Start date] as Start_date,
    NULLIF(CAST([End date qualifier]as varchar(max)),'') as End_date_qualifier,
    [End date] as End_date,
    NULLIF(CAST([Descriptive note]as varchar(max)),'') as Descriptive_note,
    [Registered date] as Registered_date,
    [Last amendment date] as Last_amendment_date

	from Portfolios')
	
execute('CREATE VIEW series_link_activities AS
	
	select 
 ParentID as [series_id], 
 ChildID as [activity_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 24 and 
RelType = 271')

execute('CREATE VIEW series_link_controlled_series AS 
select 
 ParentID as [controlled_id], 
 ChildID as [series_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 266')

execute('CREATE VIEW series_link_controlling_agencies AS 
select 
 ParentID as [series_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 25 and 
RelType = 264')

execute('CREATE VIEW series_link_controlling_series AS 
select 
 ParentID as [series_id], 
 ChildID as [controlling_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 266')

execute('CREATE VIEW series_link_creating_agencies AS 
select 
 ParentID as [series_id], 
 ChildID as [agency_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 25 and 
RelType = 265')

execute('CREATE VIEW series_link_persons AS 
select 
 ParentID as [series_id], 
 ChildID as [person_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 26 and 
RelType = 271')

execute('CREATE VIEW series_link_preceding_series AS 
select 
 ParentID as [preceding_id], 
 ChildID as [series_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 268')

execute('CREATE VIEW series_link_related_series AS 
select 
 related_id=convert(int, ParentID),
 series_id=convert(int, ChildID),
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 271

union

select 
 related_id=convert(int, ChildID),
 series_id=convert(int, ParentID),
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 271')

execute('CREATE VIEW series_link_succeeding_series AS 
select 
 ParentID as [series_id], 
 ChildID as [succeeding_id],
 SDate,
 SDateQualifier,
 EDate,
 EDateQualifier
from 
 EntityRelationships 
where
parenttype = 27 and ChildType = 27 and 
RelType = 268')

execute('CREATE VIEW series_view AS 
select	[Series number] as Series_number,
	[Series title] as Series_title,
	NULLIF(CAST([Start date qualifier]as varchar(max)),'') as Start_date_qualifier,
	[Start date] as Start_date,
	NULLIF(CAST([End date qualifier]as varchar(max)),'') as End_date_qualifier,
	[End date] as End_date,
	NULLIF(CAST([Contents start date qualifier]as varchar(max)),'') as Contents_start_date_qualifier,
    [Contents start date] as Contents_start_date,
    NULLIF(CAST([Contents end date qualifier]as varchar(max)),'') as  Contents_end_date_qualifier,
    [Contents end date] as Contents_end_date,
    NULLIF(CAST([Descriptive note]as varchar(max)),'') as Descriptive_note,
    NULLIF(CAST([Format]as varchar(max)),'') as Format,
    NULLIF(CAST([Arrangement]as varchar(max)),'') as Arrangement,
    NULLIF(CAST([Copies]as varchar(max)),'') as Copies,
    NULLIF(CAST([Bridging aids]as varchar(max)),'') as Bridging_aids,  
    NULLIF(CAST([Access note]as varchar(max)),'') as  Access_note,
    [Registered date] as Registered_date,
    [Last amendment date] as Last_amendment_date,
    NULLIF(CAST([Series control status]as varchar(max)),'') as Series_control_status,
    [Repository] as Repository
	  
from Series')
		
 end


 def self.down
  execute 'drop view activities_link_functions'
  execute 'drop view activities_link_series'
	execute 'drop view activities_view'
	
  execute 'drop view agencies_link_functions'
	execute 'drop view agencies_link_organisations'
  execute 'drop view agencies_link_persons'
	execute 'drop view agencies_link_preceding'
  execute 'drop view agencies_link_related'
	
	execute 'drop view agencies_link_series_controlled'
  execute 'drop view agencies_link_series_created'
	execute 'drop view agencies_link_subordinates'
  execute 'drop view agencies_link_succeeding'
	execute 'drop view agencies_link_superiors'
	execute 'drop view agencies_view'
	
	execute 'drop view functions_link_activities'
	execute 'drop view functions_link_agencies'
	execute 'drop view functions_link_persons'
	execute 'drop view functions_view'
	
	execute 'drop view items_view'
	
	execute 'drop view ministries_link_portfolios'
	execute 'drop view ministries_view'
	
	execute 'drop view organisations_link_agencies'
	execute 'drop view organisations_link_preceding'
	execute 'drop view organisations_link_succeeding'
	execute 'drop view organisations_view'
	
	execute 'drop view persons_link_agencies'
	execute 'drop view persons_link_functions'
	execute 'drop view persons_link_ministries'
	execute 'drop view persons_link_portfolios'
	execute 'drop view persons_link_series'
	execute 'drop view persons_view'
	
	execute 'drop view portfolios_link_agencies'
	execute 'drop view portfolios_link_ministries'
	execute 'drop view portfolios_link_persons'
	execute 'drop view portfolios_link_preceding'
	execute 'drop view portfolios_link_succeeding'
	execute 'drop view portfolios_view'
	
	execute 'drop view series_link_activities'
	execute 'drop view series_link_controlled_series'
	execute 'drop view series_link_controlling_agencies'
	execute 'drop view series_link_controlling_series'
	execute 'drop view series_link_creating_agencies'
	execute 'drop view series_link_persons'
	execute 'drop view series_link_preceding_series'
	execute 'drop view series_link_related_series'
	execute 'drop view series_link_succeeding_series'
	execute 'drop view series_view'

	
 end

end
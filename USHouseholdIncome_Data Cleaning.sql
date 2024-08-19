############ Data Cleaning

SELECT * FROM us_project.us_household_income;
SELECT * FROM us_project.us_household_income_statistics;

alter table us_project.us_household_income_statistics rename column `ï»¿id` to `id`;

select count(id)
FROM us_project.us_household_income;

select count(id)
from us_project.us_household_income_statistics;

select id, count(id)
from us_project.us_household_income
group by id
having count(id) > 1
;

select *
from ( 
select row_id,
id,
row_number() over(partition by id order by id) row_num
from us_project.us_household_income
) duplicates
where row_num > 1;

delete from us_household_income
where row_id in (
	select row_id
	from ( 
		select row_id,
		id,
		row_number() over(partition by id order by id) row_num
		from us_project.us_household_income
		) duplicates
	where row_num > 1);

select distinct State_Name
from us_project.us_household_income
order by 1
;

update us_project.us_household_income
set State_Name = 'Georgia'
where State_Name = 'georia'
;

select Type, count(Type)
from us_project.us_household_income
group by Type
;

select ALand, AWater
from us_project.us_household_income
where ALand = 0 or ALand = '' or ALand is null
;

-- 1 Select the top 20 rows of the deliveries table
select * 
from ipl_ball
limit 20;

-- select the top 20 rows of the match table
select *
from
ipl_matches
limit 20;

-- 3 Fetch data of all the matches played on 2nd May 2013
select *
from ipl_matches
where  date = '02-05-2013';

-- 4 fetch the data of all the matches where the margin of victory is more than 100
 select *
 from ipl_matches
 where result_margin >100;
 
 -- 5 Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date
 select *
 from ipl_matches
 where result='tie'
 order by date desc;
 
 -- 6 count of cities that have hosted an ipl match
 select count(distinct(city))
 from ipl_matches;
 
 -- 7 Create table deliveries_v02 with all the columns of deliveries and an additional column ball_result containing value boundary,
 -- dot or other depending on the total_run (boundary for >= 4, dot for 0 and other for any other number)
 create table deliveries_v02 (
 select *,
 case when total_runs>= 4 then 'boundary'
 when total_runs=0 then 'dot'
 else 'other'
 end ball_result
 from ipl_ball);
 select * from deliveries_v02;
 
 -- 8 write a query to fetch total no of boundary and dot balls
select ball_result,
count(*) as Total_no_of_boundary_dot_balls
from deliveries_v02
where ball_result in('dot','boundary') 
group by ball_result;


   

 -- 9 write a query to fetch total number of boundaries scored by each team
select batting_team,
count(*) as count_boundaries
from deliveries_v02
where  ball_result in ("boundary")
group by batting_team 
order by count_boundaries desc;
 
 -- 10 write a query to fetch total number of dot balls by each team
 select batting_team,
 count(ball_result) as total_dotballs
 from deliveries_v02
 where ball_result in ('dot')
 group by batting_team
 order by total_dotballs desc;
 
-- 11  Write a query to fetch the total number of dismissals by dismissal kinds
select dismissal_kind ,
count(dismissal_kind) as count_dismissal
from ipl_ball
where dismissal_kind not in ('NA')
group by dismissal_kind
order by count_dismissal ;

-- 12 Write a query to get the top 5 bowlers who conceded maximum extra runs
select bowler,
sum(extra_runs) as Total_extra_runs
from ipl_ball
group by bowler
order by Total_extra_runs desc
limit 5;

 -- 13 Write a query to create a table named deliveries_v03 with all the columns of deliveries_v02 table and two additional column 
 -- (named venue and match_date) of venue and date from table matches 
 
 create table delieveries_v03 as(
 select a.*,
 b.venue,
 b.date
 from deliveries_v02 a
 join ipl_matches b
 on a.id=b.id);
 
 -- to view the new table
 select* from delieveries_v03;
 
 -- 14 Write a query to fetch the total runs scored for each venue and order it in the descending order of total runs scored
 -- Method 1  By use of new table(delieveries_v03)
 select venue, 
 sum(total_runs) as Total_runs
 from delieveries_v03
 group by venue
 order by total_runs desc;
 -- Method 2 (By use of join with actual table)
 select a.venue,
 sum(b.total_runs) as Total_runs
 from ipl_matches a
 join ipl_ball b
 on a.id=b.id
 group by a.venue
 order by total_runs desc;
 
 -- 15 Write a query to fetch the year-wise total runs scored at Eden Gardens and order it in the descending order of total runs scored
 -- Method 1 using the new table(delieveries table)
select year(date) as ipl_year,
sum(total_runs) as total_runs
from delieveries_v03
where venue = 'Eden Gardens'
group by ipl_year
order by total_runs desc;
 -- Method 2 using the join with the actual table
 select year(a.date) as ipl_year,
 sum(b.total_runs) as total_runs
 from ipl_matches a
 join ipl_ball b
 on a.id-b.id
 where a.venue in('Eden Gardens')
 group by ipl_year
 order by total_runs desc;

 
 --
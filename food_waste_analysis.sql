-- Each restaurents surplus kg
select s.restaurent_id,r.restaurent_name,sum(s.surplus_kg) as surplus_kg from food_surplus s join restaurents r
on r.restaurent_id=s.restaurent_id group by s.restaurent_id,r.restaurent_name order by surplus_kg desc;

-- Each category surplus kg
select c.category_id,f.category_name,sum(c.surplus_kg) as total_surplus_kg from food_surplus c join 
food_categories f  on c.category_id=f.category_id group by c.category_id,f.category_name order by total_surplus_kg desc;


-- each restaurents surplus percentage 
select r.restaurent_name,f.restaurent_id,sum(prepared_kg) as total_prepared_kg,sum(surplus_kg) as total_surplus_kg,
round(sum(f.surplus_kg)*100.0/sum(f.prepared_kg),2) as surplus_percentage from
restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_name,f.restaurent_id
order by surplus_percentage desc limit 1;

-- each restaurents surplus percentage 
select r.restaurent_name,f.restaurent_id,sum(prepared_kg) as total_prepared_kg,sum(surplus_kg) as total_surplus_kg,
round(sum(f.surplus_kg)*100.0/sum(f.prepared_kg),2) as surplus_percentage from
restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_name,f.restaurent_id
having total_surplus_kg>30 order by surplus_percentage desc limit 1;

-- Restaurents whose total_surplus is greater than 30   
select r.restaurent_name,f.restaurent_id,sum(prepared_kg) as total_prepared_kg,sum(surplus_kg) as total_surplus_kg,
round(sum(f.surplus_kg)*100.0/sum(f.prepared_kg),2) as surplus_percentage from
restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_name,f.restaurent_id
having total_surplus_kg>30;

-- Restaurents which the total surplus kg is greater than tha avg surplus kg of all restaurents.
select r2.restaurent_id,r.restaurent_name,sum(r2.surplus_kg) as total_surplus_kg from restaurents r join food_surplus r2 on r.restaurent_id=r2.restaurent_id
group by r.restaurent_name,r2.restaurent_id,r.restaurent_id having total_surplus_kg>(select avg(kg) from(select sum(surplus_kg) as kg from food_surplus group
 by restaurent_id) as r);
 
 -- Worst food category
 select f.category_id,c.category_name,sum(f.surplus_kg) as total_surplus_kg 
 from food_surplus f join food_categories c on c.category_id=f.category_id
 group by f.category_id,c.category_id order by total_surplus_kg desc limit 1;
 
--  Make the null surplus kg as o 
 select r.restaurent_id,r.restaurent_name,coalesce(sum(f.surplus_kg),0) as total_surplus_kg from restaurents r left join food_surplus f  
on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name;

-- highest second surplus restaurent 
select r.restaurent_id,r.restaurent_name,sum(f.surplus_kg) as total_surplus_kg from restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id
group by f.restaurent_id order by total_surplus_kg desc limit 1 offset 1;

-- Find Restaurants with Above-Average Surplus Percentage
select r.restaurent_id,r.restaurent_name,round(sum(f.surplus_kg)*100/sum(f.prepared_kg),2)as total_surplus_percentage from restaurents r join
 food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,f.restaurent_id,r.restaurent_name
 having total_surplus_percentage>(select avg(kg) from(select round(sum(surplus_kg)*100/sum(prepared_kg),2) as kg from food_surplus group by restaurent_id) as t);

-- Find the Most Wasted Food Category for Each Restaurants.
select r.restaurent_id,c.category_id,r.restaurent_name,c.category_name,sum(surplus_kg) as total_surplus_kg from restaurents r join
 food_surplus f on f.restaurent_id=r.restaurent_id join food_categories c on c.category_id=f.category_id group by 
 r.restaurent_id,r.restaurent_name,c.category_name,c.category_id having total_surplus_kg>=all(select sum(f2.surplus_kg) from food_surplus f2
 where f2.restaurent_id=r.restaurent_id group by f2.category_id);
 
-- Find Restaurants That Waste More Than 20% of Prepared Food
select r.restaurent_id,r.restaurent_name,sum(prepared_kg) as prepared_kg,sum(surplus_kg) as total_surplus,sum(surplus_kg)*100/sum(prepared_kg) as total_surplus_percentage from restaurents r join
 food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name having total_surplus_percentage>20;

--  Find Each Restaurant's Contribution to Total Food Waste 
select restaurent_id,restaurent_name,round(total_surplus*100.0/(select sum(surplus_kg) from food_surplus),2) as total_food_waste_percentage
 from(select r.restaurent_id,r.restaurent_name,sum(surplus_kg) as total_surplus from restaurents r join
 food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name) as t;
 
-- Find Daily Food Waste Trends 
select food_date,sum(surplus_kg) as total_surplus_kg from food_surplus group by food_date order by total_surplus_kg desc;

-- Identify restaurants whose daily total food surplus exceeds 20 kg, displaying the restaurant name, date, and total surplus.
select r.restaurent_id,r.restaurent_name,f.food_date,sum(f.surplus_kg) as total_surplus_kg from
 food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by r.restaurent_id,r.restaurent_name,f.food_date having total_surplus_kg>20;

-- Identify Restaurants with the Highest Surplus on Each Day
select restaurent_id,restaurent_name,food_date,highest_surplus_kg from (select r.restaurent_id,r.restaurent_name,f.food_date,sum(f.surplus_kg)as Highest_surplus_kg ,rank() over(partition by f.food_date
 order by sum(f.surplus_kg )desc) as rnk from
 food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by r.restaurent_id,
 r.restaurent_name,f.food_date) t
 where rnk=1;
 
 -- Identify Restaurants with the Highest Surplus on Each Day
 select r.restaurent_id,r.restaurent_name,f.food_date,sum(surplus_kg) as total_surplus from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id
 group by r.restaurent_id,restaurent_name,f.food_date
 having total_surplus>=all(select sum(f2.surplus_kg) from food_surplus f2 where f2.food_date=f.food_date group by f2.restaurent_id);
 
-- Find Restaurants Whose Surplus Increased Compared to the Previous Day
select * from (select r.restaurent_name,r.restaurent_id,f.food_date,sum(f.surplus_kg) as total_surplus_kg,
lag(sum(f.surplus_kg)) over(partition by f.restaurent_id order by f.food_date) as previous_surplus_kg
from restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id
group by r.restaurent_name,r.restaurent_id,f.food_date) as t
where total_surplus_kg>previous_surplus_kg;

-- Calculate Cumulative Food Surplus for Each Restaurant
select restaurent_id,food_date,total ,sum(total) over(partition by restaurent_id order by food_date) as running_total from 
(select restaurent_id,food_date,sum(surplus_kg) as total from food_surplus group by restaurent_id,food_date) as y;

-- Find Each Restaurant's Highest Daily Surplus
select f.restaurent_id,f.food_date,sum(f.surplus_kg) as total_surplus_kg from food_surplus f group by f.food_date,f.restaurent_id
having total_surplus_kg>=(select max(o) from (select sum(f2.surplus_kg) as o from food_surplus f2 where f2.restaurent_id=f.restaurent_id 
group by f2.restaurent_id,f2.food_date) as t order by restaurent_id); 
select * from food_surplus order by restaurent_id,food_date;
 
--  Find Restaurants Whose Surplus Is Increasing for 3 Consecutive Recorded Dates
select r.restaurent_id,r.restaurent_name,food_date,total_surplus,prev1,prev2 from(select restaurent_id,food_date,sum(surplus_kg) as total_surplus ,lag(sum(surplus_kg))  over(partition by restaurent_id order by 
 food_date) as prev1, lag(sum(surplus_kg),2)  over(partition by restaurent_id order by 
 food_date) as prev2 from food_surplus group by restaurent_id,food_date) as t join restaurents r on r.restaurent_id=t.restaurent_id
 where total_surplus>prev1 and total_surplus>prev2 and prev1>prev2;
 
--  Find Each Restaurant's Surplus Growth Percentage
select restaurent_id,restaurent_name,food_date,round(((total_surplus-prev)/prev)*100,2) as growth from (select r.restaurent_id,
r.restaurent_name,sum(f.surplus_kg) as total_surplus,lag(sum(f.surplus_kg)) 
over(partition by r.restaurent_id order by f.food_date) as prev,f.food_date       
from restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name,f.food_date) as t;

-- Find the top 2 highest food surplus dates for each restaurant.
select * from(select r.restaurent_id,r.restaurent_name,f.food_date,sum(f.surplus_kg),rank() over (partition by restaurent_id order by sum(f.surplus_kg) desc)
 as rnk
from restaurents r join food_surplus f on r.restaurent_id=f.restaurent_id group by r.restaurent_id,r.restaurent_name,f.food_date) as t 
where rnk in(1,2);

-- Find restaurants whose total food surplus is greater than the average total surplus across all restaurants. 
select r.restaurent_id,r.restaurent_name,sum(surplus_kg) as total from restaurents r 
join food_surplus f on f.restaurent_id=r.restaurent_id
group by r.restaurent_id,r.restaurent_name having total>(select avg(total) from(select sum(surplus_kg) as total from restaurents r 
join food_surplus f on f.restaurent_id=r.restaurent_id
group by r.restaurent_id)as r);

-- For each restaurant, calculate the cumulative food surplus over time.
select restaurent_id,restaurent_name,total,sum(total) over (partition by restaurent_id order by food_date) as
 cummulative_total  from(select r.restaurent_id,r.restaurent_name,f.food_date,sum(f.surplus_kg) as total from restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id
group by r.restaurent_id,r.restaurent_name,f.food_date) as t;

-- Find each restaurant's highest surplus day and its surplus amount.
select r.restaurent_id,r.restaurent_name,f.food_date,f.surplus_kg from restaurents r join food_surplus f on 
f.restaurent_id=r.restaurent_id where f.surplus_kg=(select max(f2.surplus_kg)from  food_surplus f2 where f2.restaurent_id=f.restaurent_id);

-- Find restaurants that have never recorded a daily food surplus greater than 30 kg.
select distinct r.restaurent_name,r.restaurent_id from restaurents r 
 where not exists(select 1 from food_surplus f2 where r.restaurent_id=f2.restaurent_id  group by 
 f2.restaurent_id,f2.food_date having sum(f2.surplus_kg)>30);
 
--  Find restaurants whose daily food surplus increased for 3 consecutive recorded dates.
select restaurent_id,food_date,tot,prev,prev1 from(select restaurent_id,food_date,tot,lag( tot)
 over(partition by restaurent_id order by food_date) 
as prev,lag(tot,2) over(partition by restaurent_id order by food_date) as prev1 from 
(select f.restaurent_id,f.food_date,sum(f.surplus_kg) as tot from food_surplus f group by
 f.restaurent_id,f.food_date) as t order by restaurent_id) as t where tot>prev and tot>prev1 and prev>prev1;
 
--  Find the top 3 restaurants with the highest food surplus percentage.
select r.restaurent_id,r.restaurent_name,round((sum(f.surplus_kg)/sum(f.prepared_kg))*100,2)as tot 
from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by restaurent_id ,r.restaurent_name order by tot desc limit 3;

-- Find restaurants whose food surplus percentage is higher than the overall surplus percentage across all restaurants.
select r.restaurent_id,r.restaurent_name,round((sum(f.surplus_kg)/sum(f.prepared_kg))*100,2)as tot 
from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by restaurent_id,restaurent_name having tot>(
select round((sum(surplus_kg)/sum(prepared_kg)*100),2) as tot from food_surplus);

-- Find the top 3 restaurants with the highest total food surplus, along with 
-- their percentage contribution to the overall food surplus.

with a as(select restaurent_id,sum(surplus_kg) as tot from food_surplus group by restaurent_id),
b as(select sum(surplus_kg) as tott from food_surplus)
select r.restaurent_name,a.restaurent_id,a.tot,(a.tot/b.tott)*100 as con from a cross join b join restaurents r on r.restaurent_id=a.restaurent_id
order by tot desc limit 3;

-- Calculate the weekly total food surplus for each restaurant and compare it with the
--  previous week's surplus. Find the percentage change in surplus from the previous week.
with a as(select restaurent_id,sum(surplus_kg) as tot,date_sub(food_date,interval weekday(food_date) day) as
 wek from food_surplus group by restaurent_id,wek)
 select t.restaurent_id,t.tot,prev,(t.tot-t.prev)/nullif(t.prev,0)*100 as chang from 
 (select a.restaurent_id,a.wek,a.tot,lag(a.tot)over(partition  by a.restaurent_id order by a.wek) 
 as prev from a) as t;

-- For each restaurant, compare the current week's total food surplus with the previous
--  recorded week's surplus. Calculate the percentage change and classify the trend as Increased, 
--  Decreased, or Unchanged.
with a as(select restaurent_id,sum(surplus_kg) as tot,date_sub(food_date,interval weekday(food_date) day) as
 wek from food_surplus group by restaurent_id,wek)
 select t.restaurent_id,t.tot,prev,(t.tot-t.prev)/nullif(t.prev,0)*100 as chang,case when t.prev is null then 'No previous data' when (t.tot-t.prev)/nullif(t.prev,0)*100>0 then 'Incresed' when (t.tot-t.prev)/nullif(t.prev,0)*100<0 then 'Decreased' else 'nothinig' end as label from 
 (select a.restaurent_id,a.wek,a.tot,lag(a.tot)over(partition  by a.restaurent_id order by a.wek) as prev from a) as t;


-- Find each restaurant's food waste efficiency percentage and classify
--  restaurants into three categories based on their surplus percentage.

with a as(select r.restaurent_id,r.restaurent_name,coalesce(round((sum(f.surplus_kg)/sum(f.prepared_kg))*100,2),0) as growth from
 restaurents r left join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name)
 select a.restaurent_id,a.restaurent_name,a.growth  as effi,case when a.growth between 30 and 35 then 'high' when a.growth between 20 and 30 then 'mid' when a.growth<20 then 'low' end as label from a;
  
-- Rank restaurants based on their total surplus food (kg), from highest to lowest. 
-- Show the restaurant name,total surplus, and rank. Include restaurants with no surplus records too.

with a as(select r.restaurent_id,r.restaurent_name,coalesce(sum(f.surplus_kg),0)as tot ,rank() over(
order by sum(f.surplus_kg) desc) as rnk from
 restaurents r left join food_surplus f on f.restaurent_id=r.restaurent_id
 group by r.restaurent_id,r.restaurent_name)
select * from a;
  
  
-- Find the top 3 restaurants with the highest total surplus food.
--  Display restaurant name, total surplus, and rank.

select * from(select restaurent_name,tot,rank() over (order by tot desc) as ra from
 (select f.restaurent_id,
r.restaurent_name,sum(f.surplus_kg) as tot from restaurents r 
join food_surplus f on f.restaurent_id=r.restaurent_id group by  f.restaurent_id,r.restaurent_name) as a) as l 
where ra in (1,2,3);

-- Identify restaurants that show an unusual increase in food waste.
-- For each restaurant, calculate its daily total surplus and compare it with 
-- the average daily surplus of that same restaurant across all available dates.
-- Flag a date as an anomaly when:
--      The daily surplus is greater than 1.5 times the restaurant's average daily surplus.
--      The restaurant has at least 3 dates of recorded surplus data.
with a as (select r.restaurent_id,r.restaurent_name,f.food_date,sum(f.surplus_kg) as tot from restaurents r left join food_surplus f on
 f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name,f.food_date ),
 b as (select restaurent_id,avg(tot) as v,count(*) as days from(select restaurent_id,food_date,sum(surplus_kg)
as tot from food_surplus group by food_date,restaurent_id) as t group by restaurent_id)
 select distinct a.restaurent_id,a.food_date,a.tot,b.v as avg_surplus,case when a.tot>1.5*b.v 
 and b.days>=3 then 'Anomaly' else 'Normal' end as label from a  join b on a.restaurent_id=b.restaurent_id;


-- Identify restaurants whose daily surplus is greater than their previous day's 
-- surplus by at least 50%. Consider only restaurants with records on both dates.
with a as(select restaurent_id,food_date,tot,lag(tot)over(partition by restaurent_id order by food_date) 
as prev from 
(select restaurent_id,food_date,sum(surplus_kg) as tot  from food_surplus group by restaurent_id,food_date) as t)
select a.restaurent_id,r.restaurent_name,a.food_date,a.tot,a.prev,round(((a.tot-a.prev)/a.prev) *100,2) as perc from a join restaurents r on r.restaurent_id=a.restaurent_id
 where a.tot>1.5*a.prev and a.prev is not null;

--  For each restaurant, calculate the percentage of prepared food that was sold and the percentage 
--  that became surplus. Rank restaurants by their food-selling efficiency from highest to lowest.

select * from food_surplus;
select r.restaurent_name,r.restaurent_id,sum(f.prepared_kg) as prepared_kg,sum(f.sold_kg) as sold_kg,sum(f.surplus_kg) as surplus_kg,round((sum(f.sold_kg)/sum(f.prepared_kg))*100,2) as sold_perc,round((sum(f.surplus_kg)/sum(f.prepared_kg))*100,2)
 as sur_perc,rank() over(order by round((sum(f.sold_kg)/sum(f.prepared_kg))*100,2) desc) as rnk from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by r.restaurent_id,r.restaurent_name;
 
 
-- Identify restaurants whose total surplus is higher than their city's  restaurant surplus.
--  Display the restaurant name, city, total surplus, city average surplus, and the difference
--  between the restaurant's surplus and the city average.

with a as(select r.restaurent_id,r.restaurent_name,r.city,sum(f.surplus_kg) as tot from 
food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by 
r.restaurent_id,r.restaurent_name,r.city),
b as (select city,avg(tot) as av from(select r.restaurent_id,r.city,sum(f.surplus_kg)
 as tot from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by r.city,
 r.restaurent_id) as g group by city)
select a.restaurent_id,a.restaurent_name,a.city,a.tot,b.av,round(a.tot-b.av,2) as diff from a join b on a.city=b.city where a.tot>b.av;


-- Find each restaurant's total surplus and rank the restaurants within each city, from highest 
-- to lowest surplus. Display restaurant name, city, total surplus, and rank.

select r.restaurent_id,r.restaurent_name,r.city,sum(f.surplus_kg) as tot,rank()over(partition by city 
order by sum(f.surplus_kg) desc) as rak from food_surplus f join 
restaurents r on r.restaurent_id=f.restaurent_id group by r.restaurent_id,r.restaurent_name,r.city;


-- Find restaurants whose total surplus is greater than the second-highest total surplus restaurant
--  in their city. Display restaurant name, city, total surplus, and rank.
select * from (select r.restaurent_id,r.restaurent_name,r.city ,sum(f.surplus_kg) as tot,dense_rank() 
over(partition by r.city order by sum(f.surplus_kg) desc) as rnk from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id
group by restaurent_id,r.city,r.restaurent_name) as t where rnk<2;


-- Identify restaurants whose total surplus is greater than the average total surplus of their city,
--  but only if their surplus also exceeds the second-highest distinct restaurant surplus in that city by at least 20%.

with a as(select r.restaurent_id,r.restaurent_name,r.city,sum(f.surplus_kg) as tot from restaurents r left join food_surplus f
on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name,r.city),
b as (select city,avg(tot) as av from a group by city),
c as (select a.city,max(a.tot) as s from a where a.tot< (select max(a2.tot) from a a2 where a2.city=a.city) group by a.city)
select a.restaurent_id,a.city,a.tot from a join b on a.city=b.city join c on c.city=a.city where a.tot>b.av and a.tot>=1.2*c.s;


-- Identify restaurants whose monthly surplus increased compared with the previous month, but whose monthly sales
--  efficiency decreased. Display restaurant name, month, current surplus, previous month surplus, current sales 
--  efficiency, and previous month sales efficiency.
select * from food_surplus;
select * from(select restaurent_id,restaurent_name,month,tot,stot,lag(tot)over(partition by restaurent_id order by month) 
as prev,ptot,lag(ptot)over(partition by restaurent_id order by month) as prev1,round((stot/ptot)*100,2)  as eff,lag(round((stot/ptot)*100,2) ) over(partition by restaurent_id order by month) as prevef from
(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m") as
 month,sum(f.surplus_kg) as tot,sum(f.sold_kg) as stot,sum(f.prepared_kg) as ptot from 
restaurents r left join food_surplus f on f.restaurent_id=r.restaurent_id group by month,r.restaurent_id,r.restaurent_name) as t) as m
where m.tot>m.prev and eff<prevef and prev is not null and prev1 is not null and prevef is not null;


-- Find restaurants whose sales efficiency improved for 2 consecutive recorded months,
--  but whose total surplus also increased in the latest month compared with the previous month.
select * from(select restaurent_id,restaurent_name,month,tot,lag(tot) over(partition by restaurent_id order by month) as prev,
round((stot/ptot)*100,2) as eff,LEAD(ROUND((stot / ptot) * 100, 2), 1) over(partition by restaurent_id order by month) as eff1
,lead(round((stot/ptot)*100,2),2) over(partition by restaurent_id order by month) as eff2 from(select r.restaurent_id,
r.restaurent_name,date_format(f.food_date,"%Y-%m") as month,
sum(f.surplus_kg) as tot,sum(f.sold_kg) as stot,sum(f.prepared_kg) as ptot
from food_surplus f
join restaurents r on r.restaurent_id=f.restaurent_id group by month,r.restaurent_name,r.restaurent_id) as t)as m where
 prev is not null and eff1 is not null and eff2 is not null
and eff<eff1 and eff1<eff2 and tot>prev;


-- Find restaurants whose surplus decreased for 3 consecutive recorded months, but whose sales efficiency 
-- did not decrease in any of those months.
with a as(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m") as month,sum(f.surplus_kg) as tot,
sum(sold_kg) as stot,sum(prepared_kg) as ptot from restaurents r join food_surplus f  on f.restaurent_id=r.restaurent_id 
group by month,r.restaurent_id,r.restaurent_name),
b as (select round((stot/ptot)*100,2) as eff,restaurent_id,month,lead(tot) over(partition by restaurent_id order by month) as aft,lead(tot,2) over(partition by
 restaurent_id order by month) as aft2 from a),
 c as (select month,restaurent_id,lead(eff) over(partition by restaurent_id order by month) as eff1,lead(eff,2) 
 over(partition by restaurent_id order by month) as eff2 from b)
select a.restaurent_id,a.restaurent_name,a.month,a.tot,b.aft,b.aft2,b.eff,c.eff1,c.eff2 from a join b on a.restaurent_id=b.restaurent_id and a.month=b.month join c on c.restaurent_id=a.restaurent_id and a.month=c.month
where a.tot>b.aft and b.aft>b.aft2 and b.aft is not null and b.aft2 is not null and b.eff<=c.eff1 and c.eff1<=c.eff2 and c.eff1 is not null and c.eff2 is not null;

-- For each restaurant, identify months where:
-- Monthly surplus is greater than the previous 2 recorded months' surplus.
-- Monthly sales efficiency is lower than both the previous 2 recorded months' efficiency.
-- The restaurant's monthly surplus is also greater than the average monthly surplus across all restaurants for that month.
-- Consider only months where the restaurant has at least 2 previous recorded month
with a as(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m") as month,sum(f.surplus_kg) as tot,sum(f.sold_kg) as
 stot,sum(f.prepared_kg) as ptot from restaurents r join food_surplus f on r.restaurent_id=f.restaurent_id group by r.restaurent_id,
 r.restaurent_name,month),b as (select restaurent_id,month,round((stot/ptot)*100,2) as eff,lag(round((stot/ptot)*100,2))over(partition
 by restaurent_id order by month) as eff1,lag(round((stot/ptot)*100,2),2)over(partition by restaurent_id order by month) as eff2,lag(tot)
 over(partition by restaurent_id order by month) as tot1,lag(tot,2)over(partition by restaurent_id order by month) as tot2 from a),
 c as (select month,avg(tot) as av from a group by month)
 select a.restaurent_id,a.restaurent_name,a.month,a.tot,b.tot1,b.tot2,b.eff,b.eff1,b.eff2 from a join b on a.restaurent_id=b.restaurent_id and a.month=b.month
 join c on c.month =a.month where b.tot1 is not null and b.tot2 is not null and a.tot>c.av and a.tot>b.tot1 and a.tot>b.tot2 and b.eff<b.eff1 and b.eff<b.eff2;


--  Find restaurants that have at least 3 recorded months and whose monthly surplus was greater than their own average monthly surplus 
--  in every recorded month of the latest 3 recorded months.Additionally, exclude restaurants that had any month with zero sales 
--  efficiency during those latest 3 recorded months.
with a as(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m") as month,sum(f.surplus_kg) as tot,sum(f.sold_kg)
 as stot,sum(f.prepared_kg) as ptot from food_surplus f join restaurents r on r.restaurent_id=f.restaurent_id group by 
r.restaurent_id,r.restaurent_name, month),
b as (select * from(select a.*,rank()over(partition by restaurent_id order by month desc) as rnk,round((stot/ptot)*100,2) 
as eff from a) as m where rnk<=3),
c as (select restaurent_id,avg(tot) as av from a group by restaurent_id)
select * from b join c on b.restaurent_id=c.restaurent_id  where not exists(select 1 from b x where b.restaurent_id=
x.restaurent_id and x.eff=0) and b.tot>c.av;


-- Find restaurants whose monthly surplus decreased in each of the latest 3 recorded months compared with the previous 
-- month. Display the restaurant name, month, monthly surplus, previous month's surplus, and the percentage decrease.
--  Consider only restaurants with at least 4 recorded months.
with a as(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m") as month,sum(f.surplus_kg) as tot
from restaurents r join food_surplus f on f.restaurent_id=r.restaurent_id group by r.restaurent_id,r.restaurent_name,month),
b as (select restaurent_id,month,lag(tot) over(partition  by restaurent_id order by month) as prev1,lag(tot,2) over
(partition  by restaurent_id order by month) as prev2 ,lag(tot,3) over(partition  by restaurent_id order by month) as prev3 ,
lag(tot,4) over(partition  by restaurent_id order by month) as prev4 from a)
select a.restaurent_id,a.restaurent_name,a.month,a.tot,b.prev1,b.prev2,b.prev3 from a join b on a.restaurent_id=b.restaurent_id and a.month=b.month where prev1 is not null and prev2 is not null and prev3 is not null and prev4 is not null
and a.tot<b.prev1 and b.prev1<b.prev2 and b.prev2<b.prev3 and b.prev3<b.prev4;


-- Find restaurants whose monthly surplus is higher than the previous month's surplus, but lower than the month before that.
with a as(select r.restaurent_id,r.restaurent_name,date_format(f.food_date,"%Y-%m")as month,sum(surplus_kg) as tot from restaurents r 
join food_surplus f on f.restaurent_id=r.restaurent_id group by month,r.restaurent_id,r.restaurent_name)
select a1.restaurent_name, a1.month, a1.tot AS current_surplus, a2.tot AS previous_surplus, a3.tot AS two_months_ago_surplus
from a a1 join a a2 on a1.restaurent_id=a2.restaurent_id join a a3 on a1.restaurent_id=a3.restaurent_id
where a1.month>a2.month and a2.month>a3.month and a1.tot>a2.tot and a1.tot<a3.tot;


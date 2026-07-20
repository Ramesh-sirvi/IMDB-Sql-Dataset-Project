use imdb;

-- 1. Rank movies within each year by avg_rating.

select m.year, m.title, sum(r.avg_rating) as avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.year, m.title;

select m.year, sum(r.avg_rating) as avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.year;



-- 2. Find top 3 movies per genre based on total_votes.

with new_t as(
select g.genre, m.title, r.total_votes, row_number() over (partition by g.genre order by r.total_votes desc) as row_n
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
)
select genre, title, total_votes
from new_t 
where row_n <=3;




-- 3. Rank directors within each year by average movie rating.

select  m.year, n.name as dir_name, r.avg_rating, dense_rank() over (partition by m.year order by r.avg_rating desc) as dir_rank
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 4. Find the lowest-rated movie per production_company.

select m.production_company, m.title, min(r.avg_rating) over(partition by m.production_company) as avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.production_company, m.title;

select m.production_company, min(r.avg_rating) as lowest_m
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.production_company;




-- 5. Rank actors per genre by number of movies acted.

with new_t as (
select g.genre, n.name as actor_name, count(m.id) as no_of_movies, dense_rank() over(partition by g.genre order by count(m.id) desc) as rank_act
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by  actor_name, g.genre
)
select genre, actor_name, no_of_movies
from new_t;





-- 6. Top 5 highest-grossing movies per country.

with new_t as (
select m.country, m.title, m.worlwide_gross_income, row_number() over(partition by m.country order by cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2)) desc) as income_rank
from movie as m
)
select country, title, worlwide_gross_income
from new_t
where income_rank <= 5 and country is not null and worlwide_gross_income is not null;






-- 7. Rank movies within each language by worldwide income.

with new_t as (
select languages, title, cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)) as income
from movie
where languages is not null
)
select languages, title, income, rank() over(partition by languages order by income desc) as lang_rank
from new_t 
where income is not null
order by languages, lang_rank;






-- 8. Find 2nd highest-rated movie per year.

with new_t as (
select m.year, m.title, r.avg_rating, dense_rank() over ( partition by m.year order by r.avg_rating desc) as year_rank
from movie as m
inner join ratings as r on m.id=r.movie_id
)
select year, title, avg_rating
from new_t
where year_rank=2;






-- 9. Find movies that tie for highest rating within each genre.

with new_t as (
select g.genre, m.title, r.avg_rating, dense_rank() over(partition by g.genre order by r.avg_rating desc) as gen_rank
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
)
select genre, title, avg_rating
from new_t
where gen_rank=1;






-- 10. Rank production companies by total revenue per year.

select production_company, year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as total_revenue, rank() over(partition by year order by sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) desc) as rank_prod
from movie
group by production_company, year 
having production_company is not null and total_revenue is not null
order by year asc, rank_prod asc;







-- 11. Rank actors by average rating within each year.

select m.year, n.name as actor_name, r.avg_rating, rank() over(partition by year order by r.avg_rating desc) as rating_rank
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;






-- 12. Dense rank movies per country by duration.

select country, title, duration, dense_rank() over(partition by country order by duration desc) as rank_dur
from movie
where country is not null
order by country asc, rank_dur asc;







-- 13. Find top director per genre by average rating.

with new_t as (
select g.genre, n.name as dir_name, r.avg_rating, rank() over (partition by g.genre order by r.avg_rating desc) as rank_gen
from genre as g
inner join ratings as r on g.movie_id=r.movie_id
inner join director_mapping as d on g.movie_id=d.movie_id
inner join names as n on n.id=d.name_id
)
select genre, dir_name, avg_rating 
from new_t
where rank_gen=1;





-- 14. Rank movies by votes within each production company.

select m.production_company, r.total_votes, rank() over(partition by m.production_company order by r.total_votes desc) as rank_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null and r.total_votes is not null
order by m.production_company asc, rank_votes asc;







-- 15. Find bottom 3 movies per genre by rating.

with new_t as(
select genre, r.avg_rating, dense_rank() over (partition by g.genre order by r.avg_rating asc) as rank_rate
from genre as g
inner join ratings as r on g.movie_id=r.movie_id
)
select genre, avg_rating, rank_rate
from new_t
where rank_rate <= 3;





-- 16. Rank actors per country by total_votes of their movies.

select m.country, n.name as actor_name, r.total_votes, rank() over (partition by m.country order by r.total_votes desc) as rank_actor
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
where m.country is not null and n.name is not null;






-- 17. Rank movies per director by rating.

select n.name as dir_name, m.title, r.avg_rating, rank() over(partition by n.name order by r.avg_rating desc) as rank_dir
from names as n
inner join director_mapping as d on n.id=d.name_id
inner join ratings as r on d.movie_id=r.movie_id
inner join movie as m on m.id=r.movie_id;








-- 18. Find highest grossing movie per language per year.

with new_t as (
select year, languages, worlwide_gross_income, rank() over (partition by year, languages order by cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)) desc) as rank_income
from movie as m
where languages is not null and worlwide_gross_income is not null
)
select year, languages, worlwide_gross_income
from new_t
where rank_income = 1;







-- 19. Rank genres per year by average movie rating.

select g.genre, m.year, m.title, r.avg_rating, rank() over(partition by g.genre, m.year order by r.avg_rating desc) as rank_movie
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;







-- 20. Identify movies whose rank changed compared to previous year (based on rating).

with new_t1 as(
select m.year, m.title, r.avg_rating, rank() over(partition by m.year order by r.avg_rating desc) as rank_movie
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.year, m.title, r.avg_rating
),
RankComparison as(
select year, title, avg_rating, rank_movie, lag(rank_movie) over(partition by title order by year) as prev_rank
from new_t1
order by year desc, rank_movie asc
)
select year, title, avg_rating, rank_movie, prev_rank
from RankComparison
where prev_rank is not Null and rank_movie<>prev_rank;






-- 21. Calculate cumulative worldwide income per year.

select year, total_income, sum(total_income) over(order by year) as cumulative_income
from
(
select year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie
group by year
)
as yearly_total
order by year;






-- 22. Running total of votes per genre ordered by year.

select g.genre, m.year, sum(r.total_votes) as total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by m.year, g.genre;







-- 23. Cumulative movie count per director.

select dir_name, movie_count, sum(movie_count) over(order by dir_name) as cumulative_dir
from(
select n.name as dir_name, count(d.movie_id) as movie_count
from director_mapping as d
inner join names as n on n.id=d.name_id
group by n.name
)
as count_dir
order by dir_name;






-- 24. Running average rating per production company.

select m.production_company, r.avg_rating, avg(r.avg_rating) over (partition by m.production_company) as running_avg
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null;







-- 25. Cumulative income per country ordered by year.

select country, year, income, sum(income) over(partition by country order by country,year) as cumulative_income
from (
select country, year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as income
from movie
where country is not null
group by country, year
)
as income_count
order by country, year;






-- 26. Running total of movies per actor.

select n.name as actor_name, m.title, m.year, count(m.id) over(partition by n.name order by m.year, m.title) as running_total
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
order by n.name, m.year;






-- 27. Cumulative votes per language per year.

select languages, year, total_votess, sum(total_votess) over ( partition by languages order by year) as cumulative_votes
from (
select m.languages, m.year, sum(r.total_votes) as total_votess
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.languages is not null and r.total_votes is not null
group by m.languages, m.year
) as cumu_votes
order by languages, year;






-- 28. Running average duration per genre.

select g.genre, m.duration, avg(m.duration) over(partition by g.genre order by m.year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_d
from movie as m
inner join genre as g on m.id=g.movie_id;


SELECT 
    g.genre,
    m.year,
    m.duration,
    AVG(m.duration) OVER (
        PARTITION BY g.genre 
        ORDER BY m.year
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as running_avg_duration
FROM movie as m
inner join genre as g on m.id=g.movie_id;






-- 29. Cumulative median rating per director.

select n.name as dir_name, r.median_rating, sum(r.median_rating) over(partition by n.name order by n.name ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as cumulative_rate
from director_mapping as d
inner join names as n on n.id=d.name_id
inner join ratings as r on d.movie_id=r.movie_id
order by n.name;






-- 30. Running count of movies per year.

select year, count_of_movies, sum(count_of_movies) over(order by year) as running_total
from (
select year, count(id) as count_of_movies
from movie
group by year
) as yearlyCount
order by year;







-- 31. Cumulative income per genre.

select genre, total_income, sum(total_income) over(order by genre) as cumulative_income
from (
select g.genre, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie as m
inner join genre as g on m.id=g.movie_id
group by g.genre
) as total_inc
order by genre;






-- 32. Running total of votes per production company.

select m.production_company, r.total_votes, sum(r.total_votes) over(partition by m.production_company order by m.year) as running_total
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null
order by m.production_company, m.year;






-- 33. Cumulative average rating per actor.

select n.name as actor_name, r.avg_rating, avg(r.avg_rating) over(partition by n.name order by m.year) as cumulative_average
from ratings as r
inner join role_mapping as rm on r.movie_id=rm.movie_id
inner join names as n on n.id=rm.name_id
inner join movie as m on m.id=r.movie_id
order by n.name, m.year;







-- 34. Running total movies per country.

select country, year, count(id) as total_movies, sum(count(id)) over(partition by country order by year) as running_movies
from movie
where country is not null
group by country, year
order by country, year;





-- 35. Cumulative income per director.

select n.name as dir_name, m.worlwide_gross_income, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) over(partition by n.name order by m.year) as c_income
from movie as m
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
where m.worlwide_gross_income is not null
order by n.name, m.year;





-- 36. Running median rating per year.

select m.year, r.median_rating, sum(r.median_rating) over(partition by m.year order by m.year ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) as median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id;





-- 37. Cumulative total_votes per actor ordered by year.

select n.name as actor_name, m.year, r.total_votes, sum(r.total_votes) over(partition by n.name order by m.year rows between unbounded preceding and current row) as cumulative_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 38. Running total duration per genre.

select g.genre, m.year, m.duration, sum(m.duration) over (partition by g.genre order by m.year rows between unbounded preceding and current row) as running_total
from movie as m
inner join genre as g on m.id=g.movie_id;





-- 39. Cumulative movie count per language.

select languages, movie_count, sum(movie_count) over(order by movie_count desc) as c_movie_count
from (
select languages, count(*) as movie_count
from movie
where languages is not null
group by languages
) as language_count
order by c_movie_count;





-- 40. Running total income per production company per year.

select production_company, year, worlwide_gross_income, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) over(partition by production_company, year order by year rows between unbounded preceding and current row) as running_income
from movie
where production_company is not null and worlwide_gross_income is not null
order by production_company, year;




-- 41. Compare each movie’s rating with previous movie of same director.

select n.name as dir_name, r.avg_rating, lag(r.avg_rating,1,0) over(partition by n.name order by m.year) as prev_movie
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
order by n.name, m.year;





-- 42. Find year-over-year rating growth per genre.

with genreRatings as (
select g.genre, m.year, sum(r.avg_rating) as total_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre, m.year
),
prev_cal as (
select genre, year, total_rating, lag(total_rating,1,0) over(partition by genre order by year) as prev_rating
from genreRatings
)
select genre, year, total_rating, prev_rating, ((total_rating - prev_rating) / prev_rating) * 100 as yoy_growth_rate
from prev_cal;





-- 43. Calculate income difference between consecutive movies of same actor.

with income_table as(
select n.name as actor_name, m.year, m.title, cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2)) as income, lag(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) over(partition by n.name order by m.year) as prev_income
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
where m.worlwide_gross_income is not null
order by n.name, m.year
)
select actor_name, year, title, income, prev_income, (income-prev_income) as income_diff
from income_table;





-- 44. Find movies where rating dropped compared to previous movie of same director.

with rate_diff_t as (
select n.name as dir_name, m.year, m.title, r.avg_rating, lag(r.avg_rating) over(partition by n.name order by m.year) as prev_rating, (r.avg_rating - lag(r.avg_rating) over(partition by n.name order by m.year)) as rate_diff
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
)
select * from rate_diff_t
where rate_diff is not null and rate_diff < 0;





-- 45. Calculate gap in years between consecutive movies per actor.

select n.name as actor_name, m.title, m.year, lag(m.year) over(partition by n.name order by m.year) as prev_year, (m.year - lag(m.year) over(partition by n.name order by m.year)) as year_gap
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 46. Compare each movie’s duration with previous movie in same genre.

select g.genre, m.title, m.year, m.duration, lag(m.duration) over(partition by g.genre order by m.year) as prev_dur
from movie as m
inner join genre as g on m.id=g.movie_id;






-- 47. Find rating improvement trend per production company.

with total_avg as(
select m.production_company, m.year, sum(r.avg_rating) as avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null
group by m.production_company, m.year
), trendCalculation as(
select production_company, year, avg_rating, lag(avg_rating) over(partition by production_company order by year) as prev_avg
from total_avg
)
select production_company, year, avg_rating, prev_avg, (avg_rating-prev_avg) as improvement_score
from trendCalculation
where prev_avg is not null
order by production_company, year;





-- 48. Detect first movie per director.

with dir_table as (
select n.name as dir_name, m.year, m.title, row_number() over(partition by n.name order by m.year) as row_num
from movie as m
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
)
select dir_name, year, title 
from dir_table
where row_num=1;







-- 49. Detect last movie per actor.

with actor_table as (
select n.name as actor_name, m.year, m.title, row_number() over (partition by n.name order by m.year desc) as row_num
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
)
select actor_name, year, title
from actor_table






-- 50. Compare income change per country year-over-year.

with total_income as (
select country, year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as income
from movie
where country is not null
group by country, year
order by country, year
), prev_total as(
select country, year, income, lag(income) over (partition by country order by year) as prev_income
from total_income
where income is not null
)
select country, year, income, prev_income, (income-prev_income) as income_diff
from prev_total;






-- 51. Find movies whose votes doubled compared to previous year.

with votes_table as(
select m.title, m.year, r.total_votes, lag(r.total_votes) over(partition by m.title order by m.year) as prev_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
order by m.title, m.year
)
select title, year, total_votes, prev_votes, (total_votes/prev_votes) as division
from votes_table
where prev_votes is not null and (total_votes/prev_votes) > 2;






-- 52. Identify rating spike (>1 increase) compared to previous movie.

with new_t as (
select m.title, m.year, r.median_rating, lag(r.median_rating) over(partition by m.title order by m.year) as prev_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
order by m.title, m.year
)
select title, year, median_rating, prev_rating, (median_rating - prev_rating) as rating_increases 
from new_t
where prev_rating is not null and (median_rating - prev_rating) > 1;





-- 53. Find movies released after more than 3-year gap per director.

select year
from movie
group by year;
#no three years gap found.




-- 54. Detect production companies with declining ratings trend.

with YearlyCompanyRatings as(
select m.production_company, m.year, avg(r.avg_rating) as yearly_avg_r
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null
group by m.production_company, m.year
order by m.production_company, m.year
), RatingTrends as (
select production_company, year, yearly_avg_r, lag(yearly_avg_r) over(partition by production_company order by year) as prev_year_rating
from YearlyCompanyRatings
)
select production_company
from RatingTrends
where yearly_avg_r < prev_year_rating
group by production_company
having count(*) >= 2;





-- 55. Compare genre average rating current vs previous year.

with genre_rating as(
select g.genre, m.year, avg(r.avg_rating) as avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre, m.year
), prev_genre as(
select genre, year, avg_rating, lag(avg_rating) over(partition by genre order by year) as prev_rating
from genre_rating
)
select genre, year, avg_rating, prev_rating, (avg_rating-prev_rating) as rating_diff
from prev_genre
where prev_rating is not null;





-- 56. Find actors whose movie rating decreased 3 times consecutively.

with actor_rating as (
select n.name as actor_name, m.year, r.avg_rating, lag(r.avg_rating) over(partition by n.name order by m.year) as prev_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
)
select actor_name
from actor_rating
where avg_rating < prev_rating
group by actor_name
having count(*) >= 3;





-- 57. Calculate rolling income difference for each genre.

with yearly_income as(
select g.genre, m.year, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie as m
inner join genre as g on m.id=g.movie_id
group by g.genre, m.year
)
select genre, year, total_income, (total_income-lag(total_income) over(partition by genre order by year)) as income_diff
from yearly_income;




-- 58. Compare each movie’s votes with next movie in same language.

with RankedMovies as(
select m.languages, r.total_votes, lead(r.total_votes) over(partition by m.languages order by r.total_votes desc) as next_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.languages is not null
)
select languages, total_votes, next_votes, (total_votes-next_votes) as vote_diff
from RankedMovies
where next_votes is not null
order by languages, total_votes desc;





-- 59. Identify comeback movies (rating improved after 2 declines).

with RankedRatings as (
select m.title, m.year, r.avg_rating, lag(r.avg_rating,1) over(partition by m.id order by m.year) as prev_rating1,
									  lag(r.avg_rating,2) over(partition by m.id order by m.year) as prev_rating2
from movie as m
inner join ratings as r on m.id=r.movie_id
)
select title, year, avg_rating, prev_rating1, prev_rating2
from RankedRatings
where avg_rating > prev_rating1 and prev_rating1 < prev_rating2;





-- 60. Detect longest gap between movies per director.

with movie_gap as(
select n.name as dir_name, m.title, m.year, lag(m.year) over(partition by n.name order by m.year) as prev_year
from movie as m
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
)
select dir_name, max(year-prev_year) as longest_gap
from movie_gap
where prev_year is not null
group by dir_name
order by longest_gap desc;





-- 61. 3-year moving average rating per genre.

with new_t as(
select g.genre, m.year, avg(r.avg_rating) as annual_avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre, m.year
)
select genre, year, annual_avg_rating, avg(annual_avg_rating) over(partition by genre order by year rows between 2 preceding and current row) as moving_3yr_avg
from new_t
order by genre, year;





-- 62. 5-movie rolling average rating per director.

select n.name as dir_name, m.year, r.avg_rating, avg(r.avg_rating) over(partition by n.name order by m.year rows between 4 preceding and current row) as moving5_avg
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 63. 3-movie moving average income per actor.

select n.name as actor_name, m.year, m.worlwide_gross_income, avg(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) over(partition by n.name order by m.year rows between 2 preceding and current row) as moving3_income
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
where m.worlwide_gross_income is not null;





-- 64. Rolling total votes (last 3 movies) per production company.

select m.production_company, m.year, r.total_votes, sum(r.total_votes) over(partition by m.production_company order by m.year rows between 2 preceding and current row) as moving3_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null;





-- 65. 2-year rolling median rating per country.

select m.country, m.year, r.median_rating, sum(r.median_rating) over(partition by m.country order by m.year rows between 2 preceding and current row) as moving2_median
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.country is not null;





-- 66. 4-movie rolling duration average per genre.

select g.genre, m.year, m.duration, avg(m.duration) over(partition by g.genre order by m.year rows between 3 preceding and current row) as rolling_avg
from movie as m
inner join genre as g on m.id=g.movie_id;





-- 67. Rolling income growth rate per language.

with income_table as(
select languages, year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie
group by languages, year
), prev_income_table as(
select languages, year, total_income, lag(total_income) over(partition by languages order by year) as prev_income
from income_table
where languages is not null and total_income is not null
)
select languages, year, total_income, prev_income, (total_income-prev_income) / prev_income * 100 as growth_rate_percentage
from prev_income_table
where prev_income is not null
order by languages,year;





-- 68. 3-year rolling movie count per director.

with movie_count as(
select n.name as dir_name, m.year, count(m.id) as movie_count
from movie as m
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by n.name, m.year
)
select dir_name, year, movie_count, sum(movie_count) over(partition by dir_name order by year rows between 2 preceding and current row) as rolling_count
from movie_count
order by dir_name, year;





-- 69. Rolling avg votes per actor (last 5 movies).

select n.name as actor_name, m.year, m.title, r.total_votes, avg(r.total_votes) over(partition by n.name order by m.year rows between 4 preceding and current row) rolling_avg
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
order by n.name, year;





-- 70. 2-movie rolling rating change per genre.

with genre_ratings as(
select g.genre, m.year, r.avg_rating, avg(r.avg_rating) over(partition by g.genre order by m.year rows between 1 preceding and current row) as rolling_avg_2movie
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
)
select genre, year, avg_rating, rolling_avg_2movie, rolling_avg_2movie - lag(rolling_avg_2movie) over(partition by genre order by year) as rolling_change
from genre_ratings
order by genre, year;





-- 71. Rolling total revenue per country (3-year window).

select country, year, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as current_year_revenue, sum(sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)))) over(partition by country order by year rows between 2 preceding and current row) as rolling_3yrs_revenue
from movie
where country is not null and worlwide_gross_income is not null
group by country, year; 





-- 72. 5-movie rolling rank of movies per director.

with movie_rating as(
select n.name as dir_name, m.year, r.avg_rating, row_number() over(partition by n.name order by m.year desc) as rn
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
), last_five_movies as(
select dir_name, year, avg_rating
from movie_rating
where rn <= 5
)
select dir_name, avg(avg_rating) as rolling_5avg_rating
from last_five_movies
group by dir_name;




-- 73. Rolling cumulative votes per year.

select m.year, r.total_votes, sum(r.total_votes) over (partition by m.year order by m.id,m.year) as cumulative_votes
from movie as m
inner join ratings as r on m.id=r.movie_id;





-- 74. Moving average duration per production company.

select production_company, year, duration, avg(duration) over(partition by production_company order by id, year) as rolling_avg_duration
from movie
where production_company is not null
order by production_company, year, id;





-- 75. Rolling avg rating per language ordered by date.

select m.languages, m.year, r.avg_rating, avg(r.avg_rating) over(partition by m.languages order by m.year) as rolling_avg
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.languages is not null;





-- 76. Divide movies into 4 quartiles per year based on rating.

select m.title, m.year, r.avg_rating, NTILE(4) over(partition by m.year order by r.avg_rating desc) as quartile
from movie as m
inner join ratings as r on m.id=r.movie_id;





-- 77. Assign movies into deciles per genre based on votes.

select g.genre, m.title, r.total_votes, NTILE(10) over(partition by g.genre order by r.total_votes desc) as vote_decile
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;





-- 78. Find top 10% movies per country.

with ranked_movies as(
select m.country, m.title, r.avg_rating, percent_rank() over(partition by m.country order by r.avg_rating desc) as rank_of_percent
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.country is not null
)
select country, title, avg_rating, rank_of_percent
from ranked_movies
where rank_of_percent <= 0.1
order by country, avg_rating desc;




-- 79. Calculate percentile rank of movies per production company.

select production_company, title, worlwide_gross_income, percent_rank() over(partition by production_company order by cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)) desc) as percent_rank1
from movie
where production_company is not null and worlwide_gross_income is not null
order by production_company, cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)) desc;





-- 80. Identify movies above 90th percentile rating per language.

with ranked_movies as(
select m.languages, m.title, r.avg_rating, percent_rank() over(partition by m.languages order by r.avg_rating desc) as rank_of_percent
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.languages is not null
)
select languages, title, avg_rating
from ranked_movies
where rank_of_percent <= 0.10
order by languages, avg_rating desc;





-- 81. Bucket directors into 5 groups based on average rating.

with director_avg as (
select n.name as dir_name, avg(r.avg_rating) as avg_rating
from director_mapping as d
inner join names as n on n.id=d.name_id
inner join ratings as r on d.movie_id=r.movie_id
group by n.name
)
select dir_name, avg_rating, NTILE(5) over(order by avg_rating desc) as rating_bucket
from director_avg;





-- 82. Assign actors into quartiles based on total movies acted.

with total_movies_acted as(
select n.name as actor_name, count(m.id) as total_movies
from movie as m 
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by n.name
)
select actor_name, total_movies, NTILE(4) over(order by total_movies desc) as quartile
from total_movies_acted;




-- 83. Divide genres into tertiles by avg rating per year.

with genre_avg as (
select g.genre, m.year, avg(r.avg_rating) as avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre, m.year
)
select genre, year, avg_rating, NTILE(3) over(partition by year order by avg_rating desc) as tertile
from genre_avg;





-- 84. Identify top 25% revenue movies per production company.

with ranked_movies as(
select production_company, title, worlwide_gross_income, NTILE(4) over(partition by production_company order by cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2)) desc) as revenue_quartile
from movie
where production_company is not null and worlwide_gross_income is not null
)
select production_company, title, worlwide_gross_income
from ranked_movies
where revenue_quartile=1;





-- 85. Percentile distribution of votes per year.

select m.year, r.total_votes, percent_rank() over(partition by m.year order by r.total_votes desc) as rank_of_percent
from movie as m
inner join ratings as r on m.id=r.movie_id;





-- 86. Rank movies per genre and also compute cumulative income.

select g.genre, r.total_votes, m.worlwide_gross_income, rank() over(partition by g.genre order by r.total_votes desc) as rank_movie, SUM(cast(replace(m.worlwide_gross_income,'$ ','') as float)) over(partition by g.genre order by r.total_votes desc) as cumulative_income
from genre as g
inner join ratings as r on g.movie_id=r.movie_id
inner join movie as m on m.id=g.movie_id
where m.worlwide_gross_income is not null
order by g.genre, r.total_votes desc;





-- 87. Find top actor per genre per year using window rank.

with actor_rank as(
select g.genre, m.year, n.name as actor_name, r.avg_rating, r.total_votes, rank() over (partition by g.genre, m.year order by r.avg_rating desc ,r.total_votes desc) as rank_actor
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
order by r.avg_rating desc, r.total_votes desc
)
select genre, year, actor_name, avg_rating, total_votes 
from actor_rank
where rank_actor = 1;





-- 88. Identify director whose movie has highest deviation from genre average.

with genre_avg as(
select g.genre, avg(r.avg_rating) as genre_avg_rating
from genre as g
inner join ratings as r on g.movie_id=r.movie_id
group by g.genre),
movie_deviation as(
select n.name as dir_name, m.id, r.avg_rating, ga.genre_avg_rating, abs(r.avg_rating - ga.genre_avg_rating) as deviation
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join genre_avg as ga on g.genre=ga.genre
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
)
select dir_name, id as movie_id, deviation
from movie_deviation 
order by deviation desc
limit 1;







-- 89. Find movies contributing to 80% of revenue per country (Pareto).

with total_revenue as(
select country, id, sum(cast(replace(worlwide_gross_income,'$ ','') as decimal(10,2))) as revenue
from movie
where worlwide_gross_income is not null and country is not null
group by country, id
),
cumulative_revenue as(
select country, id, revenue, sum(revenue) over(partition by country order by revenue desc) as running_revenue, sum(revenue) over(partition by country) as total_country_revenue
from total_revenue
)
select country, id, revenue, round((running_revenue * 100.0 / total_country_revenue),2) as cumulative_percentage
from cumulative_revenue
where (running_revenue * 100.0 / total_country_revenue) <= 80
order by country, revenue desc;




-- 90. Detect actors with consistent top 10 rank for 3 consecutive years.

with yearly_ranking as(
select n.name as actor_name, m.year, r.total_votes, dense_rank() over(partition by year order by r.total_votes desc) as rank_actor
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
),
top10 as(
select actor_name, year, rank_actor
from yearly_ranking 
where rank_actor <= 10
)
select distinct actor_name, year
from top10;




-- 91. Find production companies with 3-year continuous rating growth.

with total_ratings as(
select m.production_company, m.year, round(avg(r.avg_rating),2) as ratings
from movie as m
inner join ratings as r on m.id=r.movie_id
where m.production_company is not null
group by m.production_company, m.year
order by m.production_company, m.year
), yearly_rating as(
select production_company, year, ratings, lag(ratings,1) over(partition by production_company order by year) as prev_rating,
										  lag(ratings,2) over(partition by production_company order by year) as prev_prev_rating
from total_ratings
)
select production_company
from yearly_rating
where ratings > prev_rating
and prev_rating > prev_prev_rating
and prev_prev_rating is not null;




-- 92. Compare movie rating with genre average and overall yearly average.

with movie_avg as(
select m.title, m.year, g.genre, r.avg_rating, avg(r.avg_rating) over(partition by g.genre) as genre_avg_rating, avg(r.avg_rating) over(partition by m.year) as yearly_avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
)
select title, year, genre, avg_rating, round(genre_avg_rating,2) as genre_avg, round(yearly_avg_rating,2) as yearly_avg, round(avg_rating-genre_avg_rating,2) as diff_from_genre, round(avg_rating-yearly_avg_rating,2) as diff_from_yearly
from movie_avg
order by title, year, genre;




-- 93. Find movies whose income is above rolling 3-year genre average.

with YearlyGenreIncome as(
select m.year, g.genre, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) as yearly_genre_income, count(m.id) as movie_count
from movie as m
inner join genre as g on m.id=g.movie_id
group by g.genre, m.year
), RollingAvg as(
select year, genre, yearly_genre_income, movie_count, avg(yearly_genre_income) over(partition by genre order by year rows between 2 preceding and current row) as rolling_3yr_avg
from YearlyGenreIncome
)
select m.title, m.year, g.genre, m.worlwide_gross_income, ra.rolling_3yr_avg
from movie as m
inner join genre as g on m.id=g.movie_id
inner join RollingAvg as ra on ra.genre=g.genre
where cast(replace(m.worlwide_gross_incme,'$ ','') as decimal(10,2)) > ra.rolling_3yr_avg;
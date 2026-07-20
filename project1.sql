use imdb;

-- 1. List movie title, year, genre, avg_rating, director name.

show tables;

select * from director_mapping;
select * from genre;
select * from movie;
select * from names;
select * from ratings;
select * from role_mapping;



-- 1. List movie title, year, genre, avg_rating, director name.

select M.title, M.year, G.genre, R.avg_rating, N.name as dir_name
from movie as M
inner join genre as G on M.id=G.movie_id
inner join ratings as R on M.id=R.movie_id
inner join director_mapping as D on D.movie_id=M.id
inner join names as N on N.id=D.name_id;





-- 2. Show title, duration, total_votes, actor name, category.

select M.title, M.duration, R.total_votes, N.name, RM.category
from movie as M
inner join ratings as R on M.id=R.movie_id
inner join role_mapping as RM on M.id=RM.movie_id
inner join names as N on N.id=RM.name_id;




-- 3. Get title, country, worldwide income, avg_rating, production_company.

select M.title, M.country, M.worlwide_gross_income, R.avg_rating, M.production_company
from movie as M
inner join ratings as R on M.id=R.movie_id;



-- 4. List movies with title, date_published, genre, median_rating, director name.

select M.title, M.date_published, G.genre, R.median_rating, N.name
from movie as M
inner join genre as G on M.id=G.movie_id
inner join ratings as R on M.id=R.movie_id
inner join director_mapping as D on M.id=D.movie_id
inner join names as N on D.name_id=N.id;




-- 5. Show title, year, actor name, total_votes, avg_rating.

select m.title, m.year, n.name, r.total_votes, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;



-- 6. List title, duration, language, director name, avg_rating.

select m.title, m.duration, m.languages, n.name, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;




-- 7. Show title, genre, actor name, director name, median_rating.

select m.title, g.genre, n.name, r.median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;



-- 8. List title, production_company, actor name, total_votes, median_rating.

select m.title, m.production_company, n.name, r.total_votes, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on rm.name_id=n.id;




-- 9. Show title, country, genre, total_votes, avg_rating.

select m.title, m.country, g.genre, r.total_votes, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on r.movie_id=m.id;





-- 10. List title, year, director name, worldwide income, total_votes.

select m.title, n.name as dir_name, m.worlwide_gross_income, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;




-- 11. Show title, duration, actor name, height, avg_rating.

select m.title, m.duration, n.name, n.height, r.avg_rating
from movie as m
inner join ratings as r on r.movie_id=m.id
inner join role_mapping as rm on rm.movie_id=m.id
inner join names as n on n.id=rm.name_id;





-- 12. List title, year, genre, director name, production_company.

select m.title, m.year, g.genre, n.name, m.production_company
from movie as m
inner join genre as g on m.id=g.movie_id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;





-- 13. Show title, country, language, actor name, avg_rating.

select m.title, m.country, m.languages, n.name, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on rm.movie_id=m.id
inner join names as n on n.id=rm.name_id;





-- 14. List title, date_published, director name, median_rating, total_votes.

select m.title, m.date_published, n.name, r.median_rating, r.total_votes
from movie as m
inner join ratings as r on r.movie_id=m.id
inner join director_mapping as d on d.movie_id=m.id
inner join names as n on n.id=d.name_id;





-- 15. Show title, year, actor name, production_company, avg_rating.

select m.title, m.year, n.name, m.production_company, r.avg_rating
from movie as m
inner join ratings as r on r.movie_id=m.id
inner join role_mapping as rm on rm.movie_id=m.id
inner join names as n on n.id=rm.name_id;





-- 16. List title, genre, actor name, country, worldwide income.

select m.title, g.genre, n.name, m.country, m.worlwide_gross_income
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 17. Show title, year, director name, total_votes, median_rating.

select m.title, m.year, n.name, r.total_votes, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 18. List title, duration, genre, avg_rating, production_company.

select m.title, m.duration, g.genre, r.avg_rating, m.production_company
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;





-- 19. Show title, year, actor name, total_votes, worldwide income.

select m.title, m.year, n.name, r.total_votes, m.worlwide_gross_income
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 20. List title, date_published, genre, director name, avg_rating.

select m.title, m.date_published, g.genre, n.name, r.avg_rating
from movie as m 
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 21. Show title, country, director name, production_company, median_rating.

select m.title, m.country, n.name, m.production_company, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 22. List title, duration, actor name, genre, avg_rating.

select m.title, m.duration, n.name, g.genre, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 23. Show title, language, director name, total_votes, worldwide income.

 select m.title, m.languages, n.name, r.total_votes, m.worlwide_gross_income
 from movie as m
 inner join ratings as r on m.id=r.movie_id
 inner join director_mapping as d on m.id=d.movie_id
 inner join names as n on n.id=d.name_id;
 
 
 
 
 
--  24. List title, genre, actor name, director name, avg_rating.

select m.title, g.genre, act.name, dir.name, r.avg_rating
from movie as m 
inner join ratings as r on m.id=r.movie_id
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;






-- 25. Show title, year, duration, production_company, median_rating.

select m.title, m.year, m.duration, m.production_company, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id;



-- 26. List all movies with title, genre, avg_rating, director name (include movies without ratings).

select m.title, g.genre, r.avg_rating, n.name
from movie as m
left join ratings as r on m.id=r.movie_id
inner join genre as g on m.id=g.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;

-- select count(*) as total 
-- from (
-- select m.id, m.title, r.movie_id, r.avg_rating
-- from movie as m
-- right join ratings as r on m.id=r.movie_id
-- ) as new_table;





-- 27. Show title, year, actor name, total_votes, avg_rating (include movies without actors).

select m.title, m.year, n.name, r.total_votes, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
left join role_mapping as rm on m.id=rm.movie_id
left join names as n on n.id=rm.name_id;





-- 28. List title, production_company, director name, median_rating, total_votes.

select m.title, m.production_company, n.name, r.median_rating, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 29. Show title, duration, genre, avg_rating, worldwide income.

select m.title, m.duration, g.genre, r.avg_rating, m.worlwide_gross_income
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;





-- 30. List title, language, actor name, total_votes, median_rating.

select m.title, m.languages, n.name, r.total_votes, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 31. Show title, year, director name, avg_rating, country.

select m.title, m.year, n.name, r.avg_rating, m.country
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;






-- 32. List title, genre, director name, total_votes, worldwide income.

select m.title, g.genre, n.name, r.total_votes, m.worlwide_gross_income
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;






-- 33. Show title, duration, actor name, production_company, avg_rating.

select m.title, m.duration, n.name, m.production_company, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 34. List title, date_published, genre, median_rating, director name.

select m.title, m.date_published, g.genre, r.median_rating, n.name
from movie as m 
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 35. Show title, country, actor name, avg_rating, total_votes.

select m.title, m.country, n.name, r.avg_rating, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 36. List title, year, genre, director name, median_rating.

select m.title, m.year, g.genre, n.name, r.median_rating
from movie as m 
inner join ratings as r on m.id=r.movie_id
inner join genre as g on m.id=g.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 37. Show title, production_company, director name, total_votes, avg_rating.

select m.title, m.production_company, n.name, r.total_votes, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 38. List title, language, genre, director name, worldwide income.

select m.title, m.languages, g.genre, n.name, m.worlwide_gross_income
from movie as m 
inner join genre as g on m.id=g.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;



-- 39. Show title, duration, actor name, avg_rating, median_rating.

select m.title, m.duration, n.name, r.avg_rating, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 40. List title, year, genre, total_votes, production_company.

select m.title, m.year, g.genre, r.total_votes, m.production_company
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;




-- 41. Show title, country, director name, median_rating, avg_rating.

select m.title, m.country, n.name, r.median_rating, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 42. List title, genre, actor name, worldwide income, total_votes.

select m.title, g.genre, n.name, m.worlwide_gross_income, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 43. Show title, year, director name, production_company, avg_rating.

select m.title, m.year, n.name, m.production_company, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 44. List title, duration, genre, director name, median_rating.

select m.title, m.duration, g.genre, n.name, r.median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=g.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 45. Show title, country, actor name, avg_rating, total_votes.

select m.title, m.country, n.name, r.avg_rating, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 46. List title, year, genre, director name, worldwide income.

select m.title, m.year, g.genre, n.name, m.worlwide_gross_income
from movie as m
inner join genre as g on m.id=g.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 47. Show title, production_company, actor name, avg_rating, median_rating.

select m.title, m.production_company, n.name, r.avg_rating, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 48. List title, language, director name, total_votes, avg_rating.

select m.title, m.languages, n.name, r.total_votes, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 49. Show title, duration, genre, actor name, production_company.

select m.title, g.genre, n.name, m.production_company
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 50. List title, year, director name, median_rating, total_votes.

select m.title, m.year, n.name, r.median_rating, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 51. List title, year, genre, actor name, director name.

select m.title, m.year, g.genre, act.name, dir.name
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;





-- 52. Show title, duration, actor name, director name, avg_rating.

select m.title, m.duration, act.name, dir.name, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;




-- 53. List title, country, genre, production_company, avg_rating.

select m.title, m.country, g.genre, m.production_company, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;




-- 54. Show title, year, actor name, height, director name.

select m.title, m.year, act.name, act.height, dir.name
from movie as m
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;





-- 55. List title, date_published, genre, actor name, median_rating.

select m.title, m.date_published, g.genre, n.name, r.median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 56. Show title, production_company, director name, worldwide income, avg_rating.

select m.title, m.production_company, n.name, m.worlwide_gross_income, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 57. List title, duration, genre, actor name, total_votes.

select m.title, m.duration, g.genre, n.name, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as  n on n.id=rm.name_id;




-- 58. Show title, language, director name, avg_rating, total_votes.

select m.title, m.languages, n.name, r.avg_rating, r.total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 59. List title, year, genre, actor name, production_company.

select m.title, m.year, g.genre, n.name, m.production_company
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 60. Show title, country, director name, total_votes, median_rating.

select m.title, m.country, n.name, r.total_votes, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 61. List title, year, duration, genre, actor name.

select m.title, m.year, m.duration, g.genre, n.name
from movie as m
inner join genre as g on m.id=g.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 62. Show title, production_company, actor name, director name, avg_rating.

select m.title, m.production_company, act.name as actor_name, dir.name as director_name, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;




-- 63. List title, genre, actor name, height, total_votes.

select m.title, g.genre, n.name as actor_name, n.height, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 64. Show title, language, genre, director name, avg_rating.

select m.title, m.languages, g.genre, n.name as dir_name, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 65. List title, country, actor name, production_company, median_rating.

select m.title, m.country, n.name as actor_name, m.production_company, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 66. Show title, duration, director name, total_votes, worldwide income.

select m.title, m.duration, n.name as dir_name, r.total_votes, m.worlwide_gross_income
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 67. List title, year, genre, actor name, avg_rating.

select m.title, m.year, g.genre, n.name as actor_name, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on  m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 68. Show title, country, genre, director name, total_votes.

select m.title, m.country, g.genre, n.name as dir_name, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;




-- 69. List title, date_published, actor name, director name, median_rating.

select m.title, m.date_published, act.name as actor_name, dir.name as director_name, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as act on act.id=rm.name_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as dir on dir.id=d.name_id;




-- 70. Show title, language, actor name, total_votes, avg_rating.

select m.title, m.languages, n.name as actor_name, r.total_votes, r.avg_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 71. List title, production_company, genre, director name, avg_rating.

select m.title, m.production_company, g.genre, n.name, r.avg_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id;





-- 72. Show title, year, actor name, height, median_rating.

select m.title, m.year, n.name as actor_name, n.height, r.median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;




-- 73. List title, duration, genre, production_company, total_votes.

select m.title, m.duration, g.genre, m.production_company, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id;





-- 74. Show title, country, director name, avg_rating, worldwide income.

 select m.title, m.country, n.name, r.avg_rating, m.worlwide_gross_income
 from movie as m
 inner join ratings as r on m.id=r.movie_id
 inner join director_mapping as d on m.id=d.movie_id
 inner join names as n on n.id=d.name_id;
 
 
 
 
--  75. List title, language, genre, actor name, total_votes.

select m.title, m.languages, g.genre, n.name, r.total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id;





-- 76. List genre, count of movies, avg_rating, total_votes, earliest year.

select g.genre, count(m.id) as count_of_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes, min(m.year) as earliest_year
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre;




-- 77. Show director name, number of movies, avg_rating, total_votes, latest year.

select n.name as director_name, count(m.id) as no_of_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes, max(m.year) as latest_year
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by director_name;




-- 78. List actor name, total movies acted, avg_rating, median_rating, total_votes.

select n.name as actor_name, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name;





-- 79. Show production_company, total movies, avg_rating, total income, total_votes.

select m.production_company, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.production_company;





-- 80. List country, number of movies, avg_rating, total_votes, median_rating.

select m.country, count(m.id) as no_of_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes, sum(r.median_rating) as median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.country;





-- 81. Show year, total movies, avg_rating, total_votes, total income.

select m.year, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.year;





-- 82. List genre, director name, count of movies, avg_rating, total_votes.

select g.genre, n.name as dir_name, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by g.genre,dir_name;





-- 83. Show actor name, genre, count of movies, avg_rating, median_rating.

select n.name as actor_name, g.genre, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name, g.genre;





-- 84. List production_company, year, count of movies, avg_rating, total_votes.

select m.production_company, m.year, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.production_company, m.year;




-- 85. Show country, genre, count of movies, avg_rating, total_votes.

select m.country, g.genre, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by m.country, g.genre;




-- 86. List language, total movies, avg_rating, total_votes, median_rating.

select m.languages, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes, sum(r.median_rating) as median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.languages;





-- 87. Show director name, genre, count of movies, avg_rating, total_votes.

select n.name as director_name, g.genre, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by director_name, g.genre;




-- 88. List actor name, year, count of movies, avg_rating, total_votes.

select n.name as actor_name, m.year, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name, m.year;




-- 89. Show production_company, country, count of movies, avg_rating, total_votes.

select m.production_company, m.country, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
group by m.production_company, m.country;




-- 90. List year, genre, total movies, avg_rating, median_rating.

select m.year, g.genre, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by m.year, g.genre;




-- 91. Show actor name, production_company, total movies, avg_rating, total_votes.

select n.name as actor_name, m.production_company, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name, m.production_company;




-- 92. List director name, year, count of movies, avg_rating, median_rating.

select n.name as dir_name, m.year, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by dir_name, m.year;





-- 93. Show genre, production_company, total movies, avg_rating, total income.

select g.genre, m.production_company, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(cast(replace(m.worlwide_gross_income,'$ ','') as decimal(10,2))) as total_income
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by g.genre, m.production_company;




-- 94. List language, director name, count of movies, avg_rating, total_votes.

select m.languages, n.name as dir_name, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by m.languages, dir_name;





-- 95. Show actor name, country, total movies, avg_rating, median_rating.

select n.name as actor_name, m.country, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name, m.country;





-- 96. List year, director name, total movies, avg_rating, total_votes.

select m.year, n.name as dir_name, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by m.year, dir_name;




-- 97. Show production_company, genre, total movies, avg_rating, median_rating.

select m.production_company, g.genre, sum(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.median_rating) as median_rating
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
group by m.production_company, g.genre;




-- 98. List actor name, language, total movies, avg_rating, total_votes.

select n.name as actor_name, m.languages, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by actor_name, m.languages;




-- 99. Show country, director name, total movies, avg_rating, total_votes.

select m.country, n.name as dir_name, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join ratings as r on m.id=r.movie_id
inner join director_mapping as d on m.id=d.movie_id
inner join names as n on n.id=d.name_id
group by m.country, dir_name;




-- 100. List genre, actor name, total movies, avg_rating, total_votes.

select g.genre, n.name as actor_name, count(m.id) as total_movies, sum(r.avg_rating) as avg_rating, sum(r.total_votes) as total_votes
from movie as m
inner join genre as g on m.id=g.movie_id
inner join ratings as r on m.id=r.movie_id
inner join role_mapping as rm on m.id=rm.movie_id
inner join names as n on n.id=rm.name_id
group by g.genre, actor_name;




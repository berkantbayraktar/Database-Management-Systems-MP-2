select * 
from
(select (p.year/10)*10 || '-' || (p.year/10)*10+10 as decade, count(*) as total
from "publication" p 
group by p.year/10
union
select ((p.year-1)/10)*10 + 1 || '-' || ((p.year-1)/10)*10+10 + 1 as decade, count(*) as total
from "publication" p 
group by (p.year-1)/10
union
select ((p.year-2)/10)*10 + 2 || '-' || ((p.year-2)/10)*10+10 + 2 as decade, count(*) as total
from "publication" p 
group by (p.year-2)/10
union
select ((p.year-3)/10)*10 + 3 || '-' || ((p.year-3)/10)*10+10 + 3 as decade, count(*) as total
from "publication" p 
group by (p.year-3)/10
union
select ((p.year-4)/10)*10 + 4 || '-' || ((p.year-4)/10)*10+10 + 4 as decade, count(*) as total
from "publication" p 
group by (p.year-4)/10
union
select ((p.year-5)/10)*10 + 5 || '-' || ((p.year-5)/10)*10+10 + 5 as decade, count(*) as total
from "publication" p 
group by (p.year-5)/10
union
select ((p.year-6)/10)*10 + 6 || '-' || ((p.year-6)/10)*10+10 + 6 as decade, count(*) as total
from "publication" p 
group by (p.year-6)/10
union
select ((p.year-7)/10)*10 + 7 || '-' || ((p.year-7)/10)*10+10 + 7 as decade, count(*) as total
from "publication" p 
group by (p.year-7)/10
union
select ((p.year-8)/10)*10 + 8 || '-' || ((p.year-8)/10)*10+10 + 8 as decade, count(*) as total
from "publication" p 
group by (p.year-8)/10
union
select ((p.year-9)/10)*10 + 9 || '-' || ((p.year-9)/10)*10+10 + 9 as decade, count(*) as total
from "publication" p 
group by (p.year-9)/10) as allof
where decade >= '1940-1950'
order by allof.decade


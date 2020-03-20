select *
from 
(select '1940-1950' as decade,  count(*) as total
from "publication" p 
where p."year" between 1940 and 1949
union 
select '1941-1951' as decade,  count(*) as total
from "publication" p 
where p."year" between 1941 and 1950
union 
select '1942-1952' as decade,  count(*) as total
from "publication" p 
where p."year" between 1942 and 1951
union 
select '1943-1953' as decade,  count(*) as total
from "publication" p 
where p."year" between 1943 and 1952
union 
select '1944-1954' as decade,  count(*) as total
from "publication" p 
where p."year" between 1944 and 1953) as t
order by t.decade
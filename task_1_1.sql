select p.pub_type , count(*)
from pub p
group by p.pub_type 
order by count(*) DESC
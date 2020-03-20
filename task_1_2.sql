select pkey_field.field_name
from
(select distinct p.pub_type , f.field_name 
from pub p, field f
where p.pub_key  = f.pub_key 
group by pub_type , f.field_name) as pkey_field 
group by pkey_field.field_name
having count(*) = 7
order by pkey_field.field_name
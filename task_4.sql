create table if not exists ActiveAuthors (name text);

insert into activeauthors(name)
select distinct a.name
from author a, authored a2 , publication p
where a.author_id  = a2.author_id  and p.pub_id = a2.pub_id and p.year >= '2018' and p.year <= '2020';

create or replace function insertactiveauthor() returns trigger as $activeauthors$
begin 
	insert into activeauthors(name) 
	select a.name
	from author a , publication p 
	where a.author_id = new.author_id and p.pub_id = new.pub_id and p.year >= '2018' and p.year <= '2020';
	return new;
end;
$activeauthors$ language plpgsql;

CREATE TRIGGER activeauthorstrigger after insert ON authored 
FOR each row EXECUTE PROCEDURE insertactiveauthor();



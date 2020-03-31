alter table pub add primary key (pub_key);
create index pub_i on pub(pub_key); 
alter table field add foreign key (pub_key) references pub(pub_key);
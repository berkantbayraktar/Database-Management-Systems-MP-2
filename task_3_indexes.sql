alter table publication add foreign key (pub_key) references pub(pub_key);
alter table authored add foreign key (author_id) references author(author_id);
alter table authored add foreign key (pub_id) references publication(pub_id);
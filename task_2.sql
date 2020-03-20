INSERT INTO author
            (name)
SELECT DISTINCT f.field_value
FROM   field f
WHERE  f.field_name = 'author'  

INSERT INTO publication
            (pub_key,
             title,
             year)
SELECT pkey_title.pub_key,
       pkey_title.field_value,
       cast (pkey_year.field_value as integer) 
FROM   (SELECT p.pub_key,
               f.field_value
        FROM   pub p,
               field f
        WHERE  p.pub_key = f.pub_key
               AND f.field_name = 'title') AS pkey_title,
       (SELECT p.pub_key,
               f.field_value
        FROM   pub p,
               field f
        WHERE  p.pub_key = f.pub_key
               AND f.field_name = 'year') AS pkey_year
WHERE  pkey_title.pub_key = pkey_year.pub_key 

INSERT INTO article
            (pub_id,
             journal,
             "month",
             volume,
             "number")
SELECT p2.pub_id                AS pub_id,
       pubk_journal.field_value AS journal,
       pubk_month.field_value   AS month,
       pubk_volume.field_value  AS volume,
       pubk_number.field_value  AS number
FROM   pub p
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'article'
                         AND f.field_name = 'journal') AS pubk_journal
              ON p.pub_key = pubk_journal.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'article'
                         AND f.field_name = 'month') AS pubk_month
              ON p.pub_key = pubk_month.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'article'
                         AND f.field_name = 'volume') AS pubk_volume
              ON p.pub_key = pubk_volume.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'article'
                         AND f.field_name = 'number') AS pubk_number
              ON p.pub_key = pubk_number.pub_key
       LEFT JOIN "publication" AS p2
              ON p.pub_key = p2.pub_key
WHERE  p.pub_type = 'article'


INSERT INTO book
            (pub_id,
             publisher,
             isbn)
SELECT p2.pub_id                  AS pub_id,
       pkey_publisher.field_value AS publisher,
       pkey_isbn.field_value      AS isbn
FROM   pub p
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'book'
                         AND f.field_name = 'publisher') AS pkey_publisher
              ON p.pub_key = pkey_publisher.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         Max(f.field_value) AS field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'book'
                         AND f.field_name = 'isbn'
                  GROUP  BY p.pub_key) AS pkey_isbn
              ON p.pub_key = pkey_isbn.pub_key
       LEFT JOIN "publication" AS p2
              ON p.pub_key = p2.pub_key
WHERE  p.pub_type = 'book' 

INSERT INTO incollection
            (pub_id,
             book_title,
             publisher,
             isbn)
SELECT p2.pub_id                   AS pub_id,
       pkey_book_title.field_value AS book_title,
       pkey_publisher.field_value  AS publisher,
       pkey_isbn.field_value       AS isbn
FROM   pub p
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'incollection'
                         AND f.field_name = 'booktitle') AS pkey_book_title
              ON p.pub_key = pkey_book_title.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'incollection'
                         AND f.field_name = 'publisher') AS pkey_publisher
              ON p.pub_key = pkey_publisher.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         Max(f.field_value) AS field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'incollection'
                         AND f.field_name = 'isbn'
                  GROUP  BY p.pub_key) AS pkey_isbn
              ON p.pub_key = pkey_isbn.pub_key
       LEFT JOIN "publication" AS p2
              ON p.pub_key = p2.pub_key
WHERE  p.pub_type = 'incollection'


INSERT INTO inproceedings
            (pub_id,
             book_title,
             editor)
SELECT p2.pub_id                   AS pub_id,
       pkey_book_title.field_value AS book_title,
       pkey_editor.field_value     AS editor
FROM   pub p
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'inproceedings'
                         AND f.field_name = 'booktitle') AS pkey_book_title
              ON p.pub_key = pkey_book_title.pub_key
       LEFT JOIN (SELECT p.pub_key,
                         f.field_value
                  FROM   pub p,
                         field f
                  WHERE  p.pub_key = f.pub_key
                         AND p.pub_type = 'inproceedings'
                         AND f.field_name = 'editor') AS pkey_editor
              ON p.pub_key = pkey_editor.pub_key
       LEFT JOIN "publication" AS p2
              ON p.pub_key = p2.pub_key
WHERE  p.pub_type = 'inproceedings'  

INSERT INTO authored
            (author_id,
             pub_id)
SELECT a2.author_id AS author_id,
       p2.pub_id    AS pub_id
FROM   (SELECT p.pub_key,
               f.field_value,
               Count(*)
        FROM   pub p,
               field f
        WHERE  p.pub_key = f.pub_key
               AND f.field_name = 'author'
        GROUP  BY p.pub_key,
                  f.field_value) AS pkey_author
       LEFT JOIN "publication" AS p2
              ON p2.pub_key = pkey_author.pub_key
       LEFT JOIN author AS a2
              ON a2."name" = pkey_author.field_value  
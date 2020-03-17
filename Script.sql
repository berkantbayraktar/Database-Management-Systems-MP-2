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
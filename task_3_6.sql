SELECT t3.year,
       t3.NAME,
       t3.pub_count AS count
FROM   (SELECT p.year,
               a."name",
               Count(*) AS pub_count
        FROM   "publication" p,
               author a,
               authored a2
        WHERE  p.pub_id = a2.pub_id
               AND a2.author_id = a.author_id
        GROUP  BY p."year",
                  a.author_id,
                  a."name"
        HAVING p."year" >= '1940'
               AND p."year" <= '1990'
        EXCEPT
        SELECT DISTINCT t1.year,
                        t1.NAME,
                        t1.pub_count
        FROM   (SELECT p.year,
                       a.author_id,
                       a."name",
                       Count(*) AS pub_count
                FROM   "publication" p,
                       author a,
                       authored a2
                WHERE  p.pub_id = a2.pub_id
                       AND a2.author_id = a.author_id
                GROUP  BY p."year",
                          a.author_id,
                          a."name"
                HAVING p."year" >= '1940'
                       AND p."year" <= '1990') AS t1,
               (SELECT p.year,
                       a.author_id,
                       a."name",
                       Count(*) AS pub_count
                FROM   "publication" p,
                       author a,
                       authored a2
                WHERE  p.pub_id = a2.pub_id
                       AND a2.author_id = a.author_id
                GROUP  BY p."year",
                          a.author_id,
                          a."name"
                HAVING p."year" >= '1940'
                       AND p."year" <= '1990') AS t2
        WHERE  t1.author_id <> t2.author_id
               AND t1.year = t2.year
               AND t1.NAME <> t2.NAME
               AND t1.pub_count < t2.pub_count) AS t3
ORDER  BY t3.year,
          t3.NAME
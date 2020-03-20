 SELECT a."name" AS NAME,
       Count(*) AS pub_count
FROM   (SELECT f.pub_key,
               f.field_value
        FROM   field f
        WHERE  f.field_name = 'journal'
               AND f.field_value = 'IEEE Trans. Wireless Communications') AS
       pkey_ieeetwc,
       publication p,
       author a,
       authored a2
WHERE  p.pub_key = pkey_ieeetwc.pub_key
       AND a.author_id = a2.author_id
       AND p.pub_id = a2.pub_id
       AND a.author_id NOT IN (SELECT a.author_id
                               FROM
           (SELECT f.pub_key,
                   f.field_value
            FROM   field f
            WHERE  f.field_name = 'journal'
                   AND f.field_value =
                       'IEEE Wireless Commun. Letters') AS
           pkey_ieeewcl,
           publication p,
           author a,
           authored a2
                               WHERE  p.pub_key = pkey_ieeewcl.pub_key
                                      AND a.author_id = a2.author_id
                                      AND p.pub_id = a2.pub_id
                               GROUP  BY a.author_id)
GROUP  BY a.author_id,
          a."name"
HAVING Count(*) > 9
ORDER  BY Count(*) DESC,
          a."name"  
 SELECT a."name" AS author_name,
       Count(*) AS pub_count
FROM   field f,
       publication p,
       author a,
       authored a2
WHERE  f.field_name = 'journal'
       AND f.field_value LIKE '%IEEE%'
       AND p.pub_key = f.pub_key
       AND p.pub_id = a2.pub_id
       AND a2.author_id = a.author_id
GROUP  BY a.author_id,
          a."name"
ORDER  BY Count(*) DESC,
          a."name"
LIMIT  50  
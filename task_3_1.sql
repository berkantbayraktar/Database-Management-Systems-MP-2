 SELECT a2."name" as author_name ,
       Count(*) AS pub_count
FROM   author a2,
       authored a
WHERE  a.author_id = a2.author_id
GROUP  BY a2.author_id, a2."name" 
HAVING Count(*) > 149
       AND Count(*) < 200
ORDER  BY pub_count,
          a2."name"
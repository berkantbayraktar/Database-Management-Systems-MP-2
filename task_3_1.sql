 SELECT a2."name" ,
       Count(*) AS publications_count
FROM   author a2,
       authored a
WHERE  a.author_id = a2.author_id
GROUP  BY a2.author_id, a2."name" 
HAVING Count(*) > 149
       AND Count(*) < 200
ORDER  BY publications_count,
          a2."name"  
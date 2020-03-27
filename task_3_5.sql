 SELECT a3."name",
       Count(DISTINCT a2.author_id) AS collab_count
FROM   authored a,
       authored a2,
       author a3
WHERE  a.pub_id = a2.pub_id
       AND a.author_id <> a2.author_id
       AND a.author_id = a3.author_id
GROUP  BY a3.author_id,
          a3."name"
ORDER  BY Count(DISTINCT a2.author_id) DESC,
          a3."name"
LIMIT  1000  
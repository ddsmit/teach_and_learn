CREATE VIEW members_approved_for_voucher AS  
SELECT*
FROM
(
SELECT
  members.id AS id,
  members.name as name,
  members.email as email,
  sum(products.price) as total_spending

FROM
  ((sales
   LEFT JOIN members
   ON sales.member_id = members.id)
     INNER JOIN products
     ON sales.product_id = products.id)
       INNER JOIN
        (
        SELECT 
          departments.id as id,
          SUM(products.price) as price
        FROM 
        ((sales
        LEFT JOIN members
        ON sales.member_id = members.id)
          INNER JOIN products
          ON sales.product_id = products.id)
            INNER JOIN departments
            ON sales.department_id = departments.id
        GROUP BY departments.id
       ) DEPT
       ON sales.department_id = DEPT.id
   
WHERE 
  DEPT.price > 10000 
  
 GROUP BY members.id
 
) as PRICE
WHERE
 PRICE.total_spending > 1000
 
ORDER BY PRICE.id




  

  
  
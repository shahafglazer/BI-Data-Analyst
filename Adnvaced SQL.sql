/* number of purchases per customer per date to customer that have more
than 1 purchase*/
SELECT CustomerID,DATE(OrderDate) ,count(*)
from msft.Sales_SalesOrderHeader ssoh
group by CustomerID,DATE(OrderDate)
HAVING count(*) > 1

/* what is the average product price per sub-category */
select pps.Name ,AVG(ListPrice)
from msft.Production_Product pp
inner join msft.Production_ProductSubcategory pps on
pp.ProductSubcategoryID = pps.ProductSubcategoryID
group by pps.Name

/*what is the totaldue (gross_revenue) per date */
select DATE(OrderDate),sum(TotalDue) as gross_revenue
from msft.Sales_SalesOrderHeader ssoh
group by DATE(OrderDate)

/*select min/max/avg age per gender */
select Gender ,max(TIMESTAMPDIFF(year,BirthDate , now()
)),min(TIMESTAMPDIFF(year,BirthDate , now()
)),AVG(TIMESTAMPDIFF(year,BirthDate , now() ))
from msft.HumanResources_Employee hre
group by Gender

/*select all products that their price is bigger than the average price*/
select *
from msft.Production_Product pp
where ListPrice >
(select AVG(listprice) from msft.Production_Product pp) 

--As part of the course, i gained hands-on experience connecting to a remote MySQL database and performing various operations under the guidance of the course instructors. To connect to the database, we used a software tool called DBeaver.

--1.Find the employee jobtitle, and hire date from the "Employee" table where the hire date is before January 1, 2015.
select JobTitle ,HireDate
from msft.HumanResources_Employee hre
where HireDate < '2015-01-01'

-- 2.List the sales order number, order date, and total due from the "SalesOrderHeader" table where the total_due is greater than $1000 and the order date was in 2011-07-02
select SalesOrderNumber ,OrderDate ,TotalDue
from msft.Sales_SalesOrderHeader ssoh
where TotalDue >1000
and OrderDate = '2011-07-02'
select SalesOrderNumber ,OrderDate ,TotalDue
from msft.Sales_SalesOrderHeader ssoh
where TotalDue >1000
and OrderDate > '2011-07-02' and OrderDate < '2011-07-03'
select SalesOrderNumber ,OrderDate ,TotalDue
from msft.Sales_SalesOrderHeader ssoh
where TotalDue >1000
and OrderDate like '%2011-07-02%'

-- 3.Retrieve the product name, product number, and quantity on hand from the "Product" and "ProductInventory" tables where the product is in stock.
select pp.name,pp.ProductNumber ,ppi.Quantity
from msft.Production_Product pp
inner join msft.Production_ProductInventory ppi on pp.ProductID = ppi.ProductID
where ppi.Quantity > 0

-- 4.Select the top 10 youngest male employees (age, job title)
SELECT TIMESTAMPDIFF(year,BirthDate , now() ) as age,JobTitle
FROM msft.HumanResources_Employee hre
WHERE Gender = 'M'
ORDER BY age asc
limit 10

-- 5. list the product name,rating, and review description of the product that received a rating greater than 3
select pp.Name , ppr.Rating , ppr.Comments
from msft.Production_Product pp
inner join msft.Production_ProductReview ppr on pp.ProductID = ppr.ProductID
where ppr.Rating > 3

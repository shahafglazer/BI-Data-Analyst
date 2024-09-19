--1. create tables:
create table mta_course.shahaf_etl like mta_course.mtn_etl_test;
create table mta_course.shahaf_etl_stg like mta_course.mtn_etl_test;

--2. truncate stage table:
TRUNCATE TABLE mta_course.shahaf_etl_stg;

--3. Insert into stage table:
INSERT INTO mta_course.shahaf_etl_stg
SELECT ppoh.OrderDate,
       pv.Name,
       SUM(ppod.OrderQty) AS total_order_quantity,
       SUM(ppod.UnitPrice * ppod.ReceivedQty) AS total_order_revenue,
       SUM(ppoh.TaxAmt) AS total_tax,
       SUM(ppoh.Freight) AS total_freight  
FROM Purchasing_Vendor pv
JOIN Purchasing_ProductVendor ppv ON pv.BusinessEntityID = ppv.BusinessEntityID
JOIN Purchasing_PurchaseOrderDetail ppod ON ppv.ProductID = ppod.ProductID 
JOIN Purchasing_PurchaseOrderHeader ppoh ON ppod.PurchaseOrderID = ppoh.PurchaseOrderID 
WHERE date(ppoh.OrderDate) = '2012-01-07'
GROUP BY date(ppoh.OrderDate), pv.Name
order by date(ppoh.OrderDate) ;

--4. delete from main etl table:
DELETE FROM mta_course.shahaf_etl WHERE Order_Date = '2012-01-07';

--5. insert into main etl table from stg table:
INSERT INTO mta_course.shahaf_etl
select * from mta_course.shahaf_etl_stg;

--whole code:
create table mta_course.shahaf_etl like mta_course.mtn_etl_test;
create table mta_course.shahaf_etl_stg like mta_course.mtn_etl_test;

TRUNCATE TABLE mta_course.shahaf_etl_stg;

INSERT INTO mta_course.shahaf_etl_stg
SELECT ppoh.OrderDate,
       pv.Name,
       SUM(ppod.OrderQty) AS total_order_quantity,
       SUM(ppod.UnitPrice * ppod.ReceivedQty) AS total_order_revenue,
       SUM(ppoh.TaxAmt) AS total_tax,
       SUM(ppoh.Freight) AS total_freight  
FROM Purchasing_Vendor pv
JOIN Purchasing_ProductVendor ppv ON pv.BusinessEntityID = ppv.BusinessEntityID
JOIN Purchasing_PurchaseOrderDetail ppod ON ppv.ProductID = ppod.ProductID 
JOIN Purchasing_PurchaseOrderHeader ppoh ON ppod.PurchaseOrderID = ppoh.PurchaseOrderID 
WHERE date(ppoh.OrderDate) = '2012-01-07'
GROUP BY date(ppoh.OrderDate), pv.Name
order by date(ppoh.OrderDate) ;

DELETE FROM mta_course.shahaf_etl WHERE Order_Date = '2012-01-07';

INSERT INTO mta_course.shahaf_etl
select * from mta_course.shahaf_etl_stg;



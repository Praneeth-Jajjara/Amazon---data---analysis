#DATA EXTRACTION
SELECT * FROM amazon_db.data_set;

#DATA CLEANING & TRANSFORMATION
#checking for null values
SELECT * FROM amazon_db.data_set
Where coalesce(ProductID, OrderDate, DeliveryDate, Quantity, Price,  Supplier, Location) is null;

#changing format for order and delivery date
desc amazon_db.data_set;
UPDATE amazon_db.data_set
SET OrderDate = STR_TO_DATE(OrderDate, '%d-%m-%Y'),
    DeliveryDate = STR_TO_DATE(DeliveryDate, '%d-%m-%Y');


#FEATURE ENGINEERING
#add a new column = fullfillment days
alter table amazon_db.data_set add column (fullfillment_days INT);
update amazon_db.data_set
set fullfillment_days = datediff( DeliveryDate,Orderdate );
desc amazon_db.data_set;

select * from amazon_db.data_set;

#FILTERING DATA
#Counting the number of orders with a quantity greater than 1
SELECT COUNT(*) AS CountRows
FROM amazon_db.data_set
WHERE Quantity > 1;

#AGGREGATE FUNCTION
#Calculate the Total Quantity of Items Supplied by Each Supplier
SELECT Supplier, SUM(Quantity) AS TotalQuantity
FROM amazon_db.data_set
GROUP BY Supplier;

#GROUPING DATA
#Calculate the Average Price of Products in Each Location
SELECT Location, AVG(Price) AS AvgPrice
FROM amazon_db.data_set
GROUP BY Location;

#Subqueries
#determine the Count of High-Value Orders (CONSIDERING MORE THAN 1000RUPEES)
SELECT  COUNT(*) AS COUNTROWS
FROM amazon_db.data_set
WHERE Price > 1000;

#Conditional Logic
#Add a new column named 'volume' to the 'amazon_db.data_set' table
alter table amazon_db.data_set add column(volume Varchar(50));
update amazon_db.data_set
set volume =
  CASE 
    WHEN Quantity = 5 THEN 'HIGH'
    WHEN Quantity > 2 THEN 'MEDIUM'
    ELSE 'LOW'
END;

select * from amazon_db.data_set

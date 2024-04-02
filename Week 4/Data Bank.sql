-- How many unique nodes are there on the Data Bank system?
SELECT COUNT(DISTINCT NODE_ID)
FROM CUSTOMER_NODES
-- What is the number of nodes per region?
SELECT 
	REGION_NAME,
	COUNT(DISTINCT NODE_ID)
FROM 
	CUSTOMER_NODES AS CN JOIN REGIONS AS R 
	ON CN.REGION_ID = R.REGION_ID
GROUP BY 1
-- How many customers are allocated to each region?\
SELECT 
	REGION_NAME,
	COUNT(DISTINCT CUSTOMER_ID) NUMBER_OF_CUSTOMERS
FROM 
	CUSTOMER_NODES AS CN JOIN REGIONS AS R 
	ON CN.REGION_ID = R.REGION_ID
GROUP BY 1
-- How many days on average are customers reallocated to a different node?
WITH CTE_1 AS
(SELECT 
	CUSTOMER_ID,
	NODE_ID,
	END_DATE-START_DATE AS DAYS_IN_NODES
FROM CUSTOMER_NODES
WHERE END_DATE <> '9999-12-31'),
CTE_2 AS
(SELECT
	CUSTOMER_ID,
 	NODE_ID,
 	SUM(DAYS_IN_NODES) AS TOTAL_DAYS_IN_NODES
 FROM CTE_1
 GROUP BY 1, 2
)
SELECT
	AVG(TOTAL)
FROM CTE_2

-- What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

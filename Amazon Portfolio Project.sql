--Andrew Ng's Amazon Analysis--
--Data source :https://www.kaggle.com/annpastushko/amazon-top-100-best-sellers-in-electronics-2021/metadata


--Order By Top Sale Ranking 
SELECT *
FROM DBO.Amazon_Tech
ORDER BY 2

--Trim '$' From Price
--Saved into new file 
SELECT date, number , NAME , rating , n_reviews
,REPLACE(price,'$','') AS [PRICE$]
INTO [Amazon_Tech1]
FROM DBO.Amazon_Tech
ORDER BY 2

--Deleting items where price is not available 
DELETE FROM DBO.Amazon_Tech1
WHERE PRICE$ = 'Not available'

--Removing ',' in price
SELECT DATE, NUMBER,NAME,Rating , n_reviews ,REPLACE (PRICE$,',','') AS [PRICE$]
INTO [Amazon_Tech2]
FROM DBO.Amazon_Tech1

--Converting data type for price column
SELECT*
	,CAST ([PRICE$] AS decimal(18,2)) AS [PRICE]
	INTO [Amazon_Tech3]
FROM DBO.Amazon_Tech2

--MAX, MIN PRICING FOR TOP PRODUCTS & Group By PRODUCT NAME 

SELECT NAME
	,MAX([PRICE]) AS [MAX PRICE]
	,MIN([PRICE]) AS [MIN PRICE]
	,(MAX([PRICE])-MIN([PRICE])) AS [Pay Range]
	INTO [Amazon_Tech4]
FROM DBO.Amazon_Tech3
Group by NAME


--FINAL REPORT
SELECT*
FROM DBO.Amazon_Tech4
ORDER BY [Pay Range] DESC







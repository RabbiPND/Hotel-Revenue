
SELECT *
INTO #Hotels
FROM (
	SELECT *
    FROM [Hotel Revenue Project].dbo.['2018$']
    UNION
    SELECT *
    FROM [Hotel Revenue Project].dbo.['2019$']
    UNION
    SELECT *
    FROM [Hotel Revenue Project].dbo.['2020$']	
) AS Hotels

SELECT *
FROM #hotels AS h
LEFT JOIN dbo.market_segment AS m
ON h.market_segment = m.market_segment
LEFT JOIN dbo.meal_cost AS c
ON h.meal = c.meal

/*
ANALYSIS
*/

SELECT *
FROM #Hotels

SELECT
    h.arrival_date_year, 
    h.hotel,
    ROUND(SUM((h.stays_in_week_nights + h.stays_in_weekend_nights) * (h.adr - (h.adr * m.Discount))), 2) AS "Total Revenue"
FROM 
    #Hotels AS h
LEFT JOIN 
    dbo.market_segment AS m ON h.market_segment = m.market_segment
GROUP BY 
    h.arrival_date_year, h.hotel
ORDER BY 
    h.arrival_date_year;

SELECT ROUND(AVG(adr),2) AS "Average adr"
FROM #Hotels

SELECT ROUND(AVG(m.Discount),2) AS "Average discount"
FROM #Hotels AS h
LEFT JOIN 
dbo.market_segment AS m ON h.market_segment = m.market_segment

SELECT SUM(stays_in_week_nights + stays_in_weekend_nights) AS "Total nights"
FROM #Hotels


------------------------------------------------------------------------
--STANDARDIZED DATE

SELECT CONVERT(date, reservation_status_date) AS standardized_reservation_status_date
FROM #Hotels

ALTER TABLE #Hotels
ADD standardized_reservation_status_date DATE;

UPDATE #Hotels
SET standardized_reservation_status_date = CONVERT(DATE, reservation_status_date, 126)


SELECT reservation_status_date, standardized_reservation_status_date
FROM #Hotels;


SELECT h.standardized_reservation_status_date, ROUND(SUM((h.stays_in_week_nights + h.stays_in_weekend_nights) * (h.adr - (h.adr * m.Discount))), 2) AS "Total Revenue"
FROM #Hotels AS h
LEFT JOIN 
dbo.market_segment AS m ON h.market_segment = m.market_segment
GROUP BY h.standardized_reservation_status_date






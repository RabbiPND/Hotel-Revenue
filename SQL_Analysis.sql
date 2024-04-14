
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
QUESTIONS

1.Is the hotel revenue growing?, break down by hotel type
*/

--1.
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





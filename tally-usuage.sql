/*
 * Tally Tables Exercise
 
 * The temporary table, #PatientAdmission, has values for dates between the 1st and 8th January inclusive
 * But not all dates are present
 */
 
DROP TABLE IF EXISTS #PatientAdmission;
CREATE TABLE #PatientAdmission (AdmittedDate DATE, NumAdmissions INT);
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-01', 5)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-02', 6)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-03', 4)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-05', 2)
INSERT INTO #PatientAdmission (AdmittedDate, NumAdmissions) VALUES ('2024-01-08', 2)
SELECT * FROM #PatientAdmission
 
/*
 * Exercise: create a resultset that has a row for all dates in that period
 * of 8 days with NumAdmissions set to 0 for missing dates.
 You may wish to use the SQL statements below to set the start and end dates
 */
 
DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

DECLARE @NumDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1
 
-- write your answer here
 
 SELECT *
    ,DATEADD(DAY, N-1, @StartDate) AS AdmittedDate
    FROM 
        Tally
    where N <= @NumDays
    ORDER BY N;
       



/*
 * Exercise: list the dates that have no patient admissions
*/
DROP TABLE IF EXISTS #Dates;
DROP TABLE IF EXISTS #MissingDates;

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);
 
 DECLARE @NumDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1

-- write your answer here

SELECT 
    DATEADD(DAY, N - 1, @StartDate) AS AdmittedDate
INTO #Dates
FROM Tally
WHERE N <= @NumDays;

-- Create empty #MissingDates table
CREATE TABLE #MissingDates (AdmittedDate DATE);

-- Insert missing dates using NOT EXISTS
INSERT INTO #MissingDates (AdmittedDate)
SELECT d.AdmittedDate
FROM #Dates d
WHERE NOT EXISTS (
    SELECT 1 
    FROM #PatientAdmission p
    WHERE p.AdmittedDate = d.AdmittedDate
);

-- Select missing dates
SELECT * FROM #MissingDates ORDER BY AdmittedDate;





DROP TABLE IF EXISTS #AllDates;
DROP TABLE IF EXISTS #MissingDates;

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
SELECT @StartDate = DATEFROMPARTS(2024, 1, 1);
SELECT @EndDate = DATEFROMPARTS(2024, 1, 8);

DECLARE @NumDays INT = DATEDIFF(DAY, @StartDate, @EndDate) + 1

   SELECT 
    DATEADD(DAY, N - 1, @StartDate) AS AdmittedDate
INTO #AllDates
FROM Tally
WHERE N <= @NumDays;

-- Find dates in #AllDates not in #PatientAdmission and store in #MissingDates
SELECT a.AdmittedDate
INTO #MissingDates
FROM #AllDates a
LEFT JOIN #PatientAdmission p
    ON a.AdmittedDate = p.AdmittedDate
WHERE p.AdmittedDate IS NULL;

-- Select missing dates
SELECT * FROM #MissingDates ORDER BY AdmittedDate;
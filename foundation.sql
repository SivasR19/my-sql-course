SELECT 
ps.PatientId
,ps.Hospital
,ps.AdmittedDate
,ps.DischargeDate
,DATEDIFF(day, AdmittedDate, DischargeDate) as lenghtOfStay
,DATEADD(DAY, -14, AdmittedDate) as reminder
 FROM [PatientStay] ps
 WHERE Hospital IN ('kINGSTON', 'PRUH')
 AND ps.Ward like '%Surgery%'
 and ps.AdmittedDate between '2024-02-27'  and '2024-03-01'
 AND ps.Tariff > 5
 ORDER BY 
    ps.AdmittedDate desc, 
    ps.PatientId DESC

SELECT 
   ps.Hospital
   ,ps.Ward
    ,COUNT(ps.patientID) as nu_of_paients
    ,avg(ps.Tariff) as avg_tariff
    ,SUM(ps.Tariff) as TotTariff  
FROM PatientStay ps
GROUP BY ps.Hospital, ps.Ward
ORDER BY nu_of_paients desc

SELECT
    PatientId
,AdmittedDate
,ps.Hospital
,h.Hospital
,HospitalSize
FROM
    PatientStay ps
    LEFT JOIN DimHospitalBad h
    ON ps.Hospital = h.Hospital
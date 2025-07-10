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
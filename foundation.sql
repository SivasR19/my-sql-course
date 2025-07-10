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
 ORDER BY 
    ps.AdmittedDate desc, 
    ps.PatientId DESC
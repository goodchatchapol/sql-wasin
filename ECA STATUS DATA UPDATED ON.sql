--ECA
SELECT
    statuscode
    ,alternis_amountcollected
    ,alternis_ecaid
    ,alternis_ecaoutsorcingid 
    ,alternis_statusremark
    ,alternis_statusfromeca
	,alternis_ecadataupdatedon
,new_ecastatusdataupdatedon as 'ECA STATUS DATA UPDATED ON',
datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) as 'Last Touch Day',
CASE WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >40000 then 'No Activity'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >120 then '07. More than 4 Months'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >90 then '06. 3 Monhts to 4 Months'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >60 then '05. 2 Months to 3 Months'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >30 then '04. 1 Month to 2 Months'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >21 then '03. 3 Weeks to 1 Months'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >14 then '02. 2 Weeks to 3 Weeks'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >7 then '01. 1 Week to 2 Weeks'
WHEN datediff(day,floor(cast(new_ecastatusdataupdatedon as float)),CAST( GETDATE() AS Date )) >=0 then '00. Less Than 1 Week'
else 'No Activity'
end as 'Last_Touch'
FROM alternis_ecaoutsorcing
WHERE statuscode = '993920004'
AND new_ecastatusdataupdatedon >= '2022-11-01 00:00:00'
AND new_ecastatusdataupdatedon <= '2022-11-30 13:00:00'
ORDER BY new_ecastatusdataupdatedon DESC

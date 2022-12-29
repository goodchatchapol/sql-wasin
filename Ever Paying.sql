--RUN IN DWH

IF OBJECT_ID(N'tempdb..#Ever_Paying') IS NOT NULL DROP TABLE #Ever_Paying
IF OBJECT_ID(N'tempdb..#Paying_LXM') IS NOT NULL DROP TABLE #Paying_LXM

---------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @StartDate AS VARCHAR(50) = '2022-07-01';
DECLARE @EndDate AS VARCHAR(50) = GETDATE();
DECLARE @countryAlpha2 CHAR(2)
DECLARE @country NVARCHAR(100)

SET @countryAlpha2 = 'TH'
SET @country = 'Thailand'
---------------------------------------------------------------------------------------------------------------------------------------------------------------------


/*PART 1: GET EVER PAYING*/
SELECT DISTINCT
@country  AS [Country]
,Account_ID = AC.alternis_accountid
,Portfolio = PO.alternis_reportingname
,Business = IIF(ISNULL(PO.alternis_reportingname, PO.Alternis_Name) LIKE '%SVC%' OR PO.alternis_isservicingname = 'Yes' , 'Debt Servicing','Debt Purchase')
,Stage = AC.alternis_processstagename
,Outstanding_Balance = AC.alternis_outstandingbalance
,Outstanding_Princiapl = AC.alternis_outstandingprincipal 
,Strategy_Flag = 'Ever Paying'


INTO #Ever_Paying

FROM [stage].[alternis_transaction] TR 
	LEFT JOIN [stage].[alternis_paymentallocation] PA
		ON TR.alternis_transactionid = PA.alternis_transactionid
			AND PA.CreatedOn =  (SELECT MIN(pa1.CreatedOn) FROM [stage].[alternis_paymentallocation] pa1 WHERE pa1.alternis_transactionid = PA.alternis_transactionid)
	LEFT JOIN [stage].[alternis_account] AC
		ON PA.alternis_accountid = AC.alternis_accountid
	LEFT JOIN stage.alternis_portfolio PO
		ON AC.alternis_portfolioid = PO.alternis_portfolioid

WHERE CAST(DATEADD(HOUR,8,TR.createdon) AS DATE) <= @EndDate AND ISNULL(PO.alternis_reportingname, PO.Alternis_Name) NOT LIKE '%SVC%' AND AC.alternis_processstagename NOT IN ('Closed','Pending Close Review','Pending Paid Review')


/*PART 2: GET PAYING LAST X MONTHS TO EXCLUDE*/
SELECT DISTINCT
@country  AS [Country]
,Account_ID = AC.alternis_accountid
,Portfolio = PO.alternis_reportingname
,Business = IIF(ISNULL(PO.alternis_reportingname, PO.Alternis_Name) LIKE '%SVC%' OR PO.alternis_isservicingname = 'Yes' , 'Debt Servicing','Debt Purchase')
,Stage = AC.alternis_processstagename




INTO #Paying_LXM

FROM [stage].[alternis_transaction] TR 
	LEFT JOIN [stage].[alternis_paymentallocation] PA
		ON TR.alternis_transactionid = PA.alternis_transactionid
			AND PA.CreatedOn =  (SELECT MIN(pa1.CreatedOn) FROM [stage].[alternis_paymentallocation] pa1 WHERE pa1.alternis_transactionid = PA.alternis_transactionid)
	LEFT JOIN [stage].[alternis_account] AC
		ON PA.alternis_accountid = AC.alternis_accountid
	LEFT JOIN stage.alternis_portfolio PO
		ON AC.alternis_portfolioid = PO.alternis_portfolioid

WHERE CAST(DATEADD(HOUR,8,TR.createdon) AS DATE) BETWEEN @StartDate AND @EndDate AND ISNULL(PO.alternis_reportingname, PO.Alternis_Name) NOT LIKE '%SVC%' AND AC.alternis_processstagename NOT IN ('Closed','Pending Close Review','Pending Paid Review')


/*PART 3: CONSOLIDATE*/


SELECT * FROM #Ever_Paying WHERE Account_ID NOT IN (SELECT Account_ID FROM #Paying_LXM)

AND Portfolio IS NOT NULL 

ORDER BY
Portfolio
,Stage
,Account_ID
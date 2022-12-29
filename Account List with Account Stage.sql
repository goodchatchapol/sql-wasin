--Accounts List With Stage
SELECT
	cast(a.alternis_portfolioidname as text) as 'Portfolio'
    ,cast(a.alternis_number as text) as 'Account Number'
    ,cast(a.alternis_idnumber as text) as 'ID Number'
	,a.alternis_contactidname as 'Customer Name'
	,format(a.alternis_amountpaid, 'N') as 'Amount Paid'
	,format(dateadd(hour, 07, a.alternis_amountpaid_date), 'MM/dd/yyyy HH:mm') as 'Amount Paid Date'
	,format(a.alternis_debtamount, 'N')as 'Debt Amount'
	,format(a.alternis_feesaddeduntiltakeover, 'N')as 'Interest Added Until Takeover'
	,format(a.alternis_outstandingamount, 'N')as 'Outstanding Amount'
	,format(a.alternis_outstandingbalance, 'N') as 'Outstanding Balance'
	,format(a.alternis_principaldept, 'N') as 'Principal Dept'
	,format(a.alternis_outstandingcollectionfees, 'N') as 'Outstanding Collection Fees'
	,format(a.alternis_outstandinginterestamount, 'N') as 'Outstanding Interest Amount'
	,format(a.alternis_outstandingotherfeesandinterest, 'N') as 'Outstanding Other Fees and Interest'
	,format(a.alternis_outstandingprincipal, 'N') as 'Outstanding Principal'
	,a.alternis_processstagename as 'Account Stage'
	,a.alternis_producttype as 'Product Type'
--	,format(a.createdon, 'MM/dd/yyyy HH:mm') as 'Accounts Created On'
FROM stage.alternis_account a
--	Change Port 
WHERE a.alternis_portfolioidname IN ('AEON1 TH','AEON2 TH','AEON3 TH','AEON4 TH','AEON5 TH','TMB1 TH','TMB2 TH','SME1 TH','SME2 TH','KKP1 TH','BMW1 TH','GRAB R2 1 TH')
--	Change Date
AND a.alternis_amountpaid_date  >= '12-20-2022 00:00'
--AND alternis_amountpaid_date <= '12-31-2022 20:00'
ORDER BY a.alternis_portfolioidname, alternis_amountpaid_date DESC
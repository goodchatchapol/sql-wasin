--- on dynamics se
SELECT DISTINCT
b.alternis_portfolioidname  AS 'Port Name',
b.alternis_accountid AS 'UUID',
a.alternis_phoneid AS 'Phone ID',
REPLACE(a.alternis_number,'*','')AS 'Phone Number',
a.alternis_phonetypename AS 'Phone Typer',
b.alternis_number AS 'Account Number' ,
b.alternis_invoicenumber AS 'CardNumber/Invoice/bill id',
a.alternis_contactidname AS 'DebtorName'
FROM alternis_phone a
JOIN alternis_account b
ON a.alternis_contactid = b.alternis_contactid
WHERE alternis_portfolioidname IN ('Seamoney SPL SVC TH','Seamoney BCL SVC TH')
--WHERE alternis_portfolioidname IN ('MINOR SVC TH','ULITE SVC TH')
GROUP BY b.alternis_portfolioidname, b.alternis_accountid , a.alternis_phoneid, a.alternis_number, a.alternis_phonetypename, b.alternis_number, b.alternis_invoicenumber, a.alternis_contactidname
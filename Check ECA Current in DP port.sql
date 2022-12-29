/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
a.alternis_portfolioidname as 'Portfolio',
a.alternis_number as 'Account Number',
a.alternis_invoicenumber as 'Invoice Number',
a.alternis_accountid as 'UUID',
a.alternis_processstagename as 'Process Stage',
a.alternis_currentecaidname as 'ECA Name',
a.alternis_ecaoutsorcingid as 'ECA ID'

FROM alternis_account a
WHERE a.alternis_portfolioidname IN ('AEON1 TH','AEON2 TH','AEON3 TH','GRAB R2 1 TH','KKP1 TH','BMW1 TH','SME1 TH','SME2 TH','TMB1 TH','TMB2 TH') 
AND a.alternis_processstagename NOT IN ('Outsourcing')
AND a.alternis_currentecaidname IS NOT NULL
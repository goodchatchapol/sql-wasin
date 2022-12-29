select
a.alternis_number as 'account',
a.alternis_invoicenumber as 'invoice',
phone.alternis_number as 'phone',
alternis_portfolioidname as 'portfolio',
alternis_batchidname as 'batch'
from alternis_account a
left join alternis_phone phone on phone.alternis_contactid = a.alternis_contactid
where alternis_portfolioidname in ('SHELL SVC TH') and phone.alternis_number is null
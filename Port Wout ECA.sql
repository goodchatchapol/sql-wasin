/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
a.alternis_portfolioidname as "Portfolio",
a.alternis_processstagename as "Process Stage",
a.alternis_currentecaidname as "ECA",
a.alternis_number as "Account Number",
a.alternis_invoicenumber as "Invoice Number",
a.alternis_accountid as 'uuid',
phone.alternis_number as "Phone Number",
a.alternis_contactidname as "Debtor Name",
a.alternis_idnumber as "ID Card"

FROM stage.alternis_account a
    join stage.contact c on c.contactid = a.alternis_contactid
    left join stage.alternis_phone phone on phone.alternis_contactid = a.alternis_contactid
    left join stage.phonecall phone_call on phone_call.phonenumber = phone.alternis_number and phone_call.regardingobjectid = a.alternis_accountid and phone_call.activityid = (SELECT TOP(1)
            activityid
        FROM [stage].[phonecall] phoneCall
        where phoneCall.phonenumber = phone.alternis_number and phoneCall.regardingobjectid = a.alternis_accountid
        ORDER BY phoneCall.createdon DESC)
    left join stage.task on task.regardingobjectid = a.alternis_accountid and task.activityid = (select top(1)
            activityid
        FROM stage.task tas
        where tas.regardingobjectid = a.alternis_accountid
        ORDER BY tas.createdon DESC)
where a.alternis_portfolioidname IN ('AEON1 TH','AEON2 TH','AEON3 TH','GRAB R2 1 TH','KKP1 TH','BMW1 TH','SME1 TH','SME2 TH','TMB1 TH','TMB2 TH') 
AND a.alternis_processstagename IN ('Outsourcing')
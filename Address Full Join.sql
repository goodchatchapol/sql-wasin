SELECT *
FROM stage.alternis_account b
    FULL JOIN stage.alternis_phone a
    ON a.alternis_contactid = b.alternis_contactid
    FULL JOIN stage.alternis_address c
    ON b.alternis_contactid = c.alternis_contactid
    FULL JOIN stage.alternis_contactemployer d
    ON b.alternis_contactid = d.alternis_contactid
WHERE alternis_portfolioidname IN ('KKP1 TH')

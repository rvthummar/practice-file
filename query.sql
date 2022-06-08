
-- scheme Wise
SELECT `data`,sm.name AS schemeId, COUNT(`scheme_id`) schemeCount
 FROM agri p INNER JOIN scheme_master sm ON sm.id = p.scheme_id  AND sm.is_active = TRUE  GROUP BY `scheme_id` 
UNION ALL
SELECT `data`,sm.name AS schemeId, COUNT(`scheme_id`) schemeCount 
FROM edu p INNER JOIN scheme_master sm ON sm.id = p.scheme_id AND sm.is_active = TRUE GROUP BY `scheme_id` 

-- loan wise
SELECT COUNT(*), lm.name AS loanName FROM edu p
INNER JOIN scheme_master sm ON sm.id = p.scheme_id AND sm.is_active = TRUE 
INNER JOIN loan_master lm ON lm.id = sm.loan_id
UNION ALL
SELECT COUNT(*), lm.name AS loanName FROM agri p
INNER JOIN scheme_master sm ON sm.id = p.scheme_id AND sm.is_active = TRUE 
INNER JOIN loan_master lm ON lm.id = sm.loan_id

--  org wise
SELECT tmp.orgId,bm.name, SUM(tmp.orgCount) AS orgCount FROM(
SELECT org_id AS orgId, COUNT(org_id) AS orgCount FROM edu GROUP BY org_id
UNION ALL
SELECT org_id AS orgId, COUNT(org_id)  AS orgCount FROM agri GROUP BY org_id ) tmp 
INNER JOIN bank_master bm ON bm.id= tmp.orgId GROUP BY tmp.orgId


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

-- day month
SELECT  tmp.gbday, SUM(tmp.approvedCount) AS approvedCount, SUM(tmp.sanctionCount) AS sanctionCount FROM(
	SELECT 
	DAY(j_date) gbday,
	SUM(CASE WHEN proposal_id =1 THEN 1 ELSE 0 END) approvedCount,
	0 AS sanctionCount
	FROM `practice`.`agri` GROUP BY DAY(j_date) 
	UNION ALL
	SELECT 
	DAY(m_date) gbday,
	0 AS approvedCount,
	SUM(CASE WHEN proposal_id =2 THEN 1 ELSE 0 END) AS sanctionCount
	FROM `practice`.`agri` GROUP BY DAY(m_date)
) tmp GROUP BY tmp.gbday ORDER BY tmp.gbday;
--- or query
SELECT 
IF(proposal_id =1, DAY(j_date), DAY(m_date)) gbday,
SUM(CASE WHEN proposal_id =1 THEN 1 ELSE 0 END) approvedCount,
SUM(CASE WHEN proposal_id = 2 THEN 1 ELSE 0 END) AS sanctionCount
FROM `practice`.`agri` GROUP BY DAY(IF(proposal_id =1,j_date,m_date)) ORDER BY gbday

https://www.w3schools.com/mysql/mysql_ref_functions.asp

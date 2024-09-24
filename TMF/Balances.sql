ALTER VIEW PBI.Balances
AS
WITH allBalances AS(
	SELECT 
		[accbal_account_seq]	 AS [AccountSeq]
	   ,dateadd(month, accbal_period-1, CONCAT(accbal_year, '-01-01')) as [DT]
	   ,[accbal_opening_balance] AS [OpeningBalance]
	   ,[accbal_debits]			 AS [Debits]
	   ,[accbal_credits]		 AS [Credits]
	   ,isnull(accbal_opening_balance,0) + isnull(accbal_debits,0) - isnull(accbal_credits,0) as CloseBalance
	   ,LEAD(dateadd(month, accbal_period-1, CONCAT(accbal_year, '-01-01'))) OVER (PARTITION BY [accbal_account_seq] ORDER BY accbal_year,accbal_period) AS NextMonth
	FROM [esoft].[dbo].[accbalances] AS b
	INNER JOIN [dbo].[accaccounts] AS a
	   ON b.accbal_account_seq = a.[account_seq]
	WHERE account_comp = 'TMF'
), allMonths AS(
	SELECT DISTINCT [DT] 
	FROM allBalances
)
SELECT 
	 [AccountSeq]
	,COALESCE(am.DT, a.DT) AS DT
	,CASE WHEN am.DT IS NOT NULL AND a.DT <> am.DT THEN CloseBalance ELSE [OpeningBalance] END AS [OpeningBalance]
	,CASE WHEN am.DT IS NOT NULL AND a.DT <> am.DT THEN 0 ELSE [Debits] END					   AS [Debits]
	,CASE WHEN am.DT IS NOT NULL AND a.DT <> am.DT THEN 0 ELSE [Credits] END				   AS [Credits]
	,CloseBalance
	,CASE WHEN am.DT IS NOT NULL AND a.DT <> am.DT THEN 1 ELSE 0 END AS ExtraRecord
FROM allBalances AS a
LEFT JOIN allMonths AS am
   ON  (a.DT <= am.DT  and ISNULL(a.NextMonth, a.DT) > am.DT)
   OR  (CloseBalance <> 0 AND a.NextMonth IS NULL AND a.DT <= am.DT)




 
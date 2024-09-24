CREATE VIEW PBI.REPORT_TrialBalance
AS
SELECT 
	 a.AccountCode
	,a.Mapping1
	,a.Mapping2
	,b.DT
	,b.OpeningBalance
	,b.Credits
	,b.Debits
	,b.CloseBalance
FROM [PBI].[Accounts] AS a
INNER JOIN PBI.Balances AS b
   ON a.[AccountSeq] = b.AccountSeq
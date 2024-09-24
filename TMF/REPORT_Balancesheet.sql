CREATE VIEW PBI.REPORT_Balansheet
AS
SELECT 
	 a.AccountCode
	,bs.Level1
	,bs.Level2
	,bs.Ord
	,b.DT
	,b.OpeningBalance
	,b.Credits
	,b.Debits
	,b.CloseBalance
FROM [PBI].[Accounts] AS a
INNER JOIN [PBI].[BalanceSheetStructure] AS bs
   ON a.Mapping1 = bs.Level2
INNER JOIN PBI.Balances AS b
   ON a.[AccountSeq] = b.AccountSeq
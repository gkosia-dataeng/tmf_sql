SELECT 
 a.[account_code]
,a.[account_name1]
, accbal_year	
,accbal_period
,SUM(accbal_debits - accbal_credits) AS Movement
FROM [dbo].[accaccounts] as a
INNER JOIN [dbo].[accbalances] as b
   ON a.account_seq = b.[accbal_account_seq]
WHERE [account_comp] = 'tmf'
and account_code in (910050,
910051,
910097)
GROUP BY  a.[account_code]
,a.[account_name1]
, accbal_year	
,accbal_period
ORDER BY a.[account_code], accbal_year	
,accbal_period
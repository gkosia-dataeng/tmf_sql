USE [esoft]
GO

/****** Object:  View [PBI].[accounts]    Script Date: 8/26/2024 2:21:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [PBI].[Accounts_FULL]
as

/*

Accounts in file but not in db

420287
420288
420289
420290
450825
450826
450827
450828

*/


SELECT 
     a.account_seq				AS AccountSeq
	,a.account_code				AS AccountCode
	,a.account_comp				AS AccountCompany
	,a.account_name1			AS AccountName
	,a.account_short			AS AccountShortName
	,a.account_type				AS AccountTypeCode
	,t.acctype_desc1			AS AccountTypeName
	,t.acctype_ledger			AS LedgerAccountType
	,addr.add_name				AS AccountAddress
	,a.[account_date_added]		AS CreatedAt
	,a.account_date_modified	AS UpdatedAt
	,CASE WHEN a.account_code < 1000 THEN 1 ELSE 0 END  AS IsLedgerAccount
	,l.account_name1									AS LedgerAccountName
	,CASE WHEN a.account_type = '700' 
		   and (
				       a.account_name1 like '%Commission%'
					OR a.account_name1 like '%Commision%'
				)
			THEN 'Commission'
		  WHEN a.account_type = '700' 
		   and (
				       a.account_name1 like '%Interest%'
					OR a.account_name1 like '%Intetest%'
					OR a.account_name1 like '%Intrerest%'
					OR a.account_name1 like '%Inerest%'
					OR a.account_name1 like '%interst%'
				)
			THEN 'Interest'
		  ELSE NULL 
	 END  AS AccountMap
FROM [dbo].[accaccounts] as a
inner join [dbo].[acctypes] as t 
   on a.account_comp = t.acctype_comp  and a.account_type  = t.acctype_code 
LEFT OUTER JOIN addaddress as addr WITH (NOLOCK) ON a.account_address_code = addr.add_seq
LEFT JOIN [dbo].[accaccounts] AS l
  ON  a.account_type = l.account_code 
  AND a.account_comp = l.account_comp
WHERE a.account_comp = 'TMF'
GO




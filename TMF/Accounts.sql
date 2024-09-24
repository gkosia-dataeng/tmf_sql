ALTER VIEW [PBI].[Accounts]
AS

SELECT 
     a.account_seq				AS AccountSeq
	,a.account_code				AS AccountCode
	,a.account_name1			AS AccountName
	,a.account_short			AS AccountShortName
	,a.account_type				AS AccountTypeCode
	,t.acctype_desc1			AS AccountTypeName
	,a.[account_date_added]		AS CreatedAt
	,a.account_date_modified	AS UpdatedAt
	,a.account_text10			AS AccountMapping
	,COALESCE(CASE WHEN m.Mapping1 = '' then null ELSE m.Mapping1 END, CASE WHEN CHARINDEX('/',a.account_text10) > 1 THEN LEFT(a.account_text10,CHARINDEX('/',a.account_text10)-1) ELSE NULL END) AS Mapping1
	,COALESCE(CASE WHEN m.Mapping2 = '' then null ELSE m.Mapping2 END, CASE WHEN CHARINDEX('/',a.account_text10) > 1 THEN RIGHT(a.account_text10,LEN(a.account_text10) - CHARINDEX('/',a.account_text10)) ELSE NULL END) AS Mapping2
FROM [dbo].[accaccounts] as a WITH(NOLOCK)
inner join [dbo].[acctypes] as t WITH(NOLOCK)
   ON a.account_comp = t.acctype_comp  and a.account_type  = t.acctype_code 
LEFT JOIN [PBI].[AccountMappings] AS m
  ON a.account_code = m.[AccountCode]
WHERE a.account_comp = 'TMF'
GO
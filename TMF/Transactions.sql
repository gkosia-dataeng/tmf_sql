
USE [esoft]
GO

/****** Object:  View [PBI].[Transactions]    Script Date: 8/26/2024 2:06:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER VIEW [PBI].[Transactions]
AS
SELECT 
	 tran_line							AS TransactionId
	,tran_account_seq					AS AccountSeq
	,DATEADD(mm, DATEDIFF(m,0,tran_document_date ),0) AS [DT]
	,tran_account_refer					AS AccountSeqRef
	,acctrantype_desc1					AS TransactionType
	,tran_posted_date					AS PostDate
	,tran_entry_date					AS EntryDate
	,tran_document_date					AS DocumentDate
	,tran_duedate						AS DueDate
	,tran_entered_by					AS EnterBy
	,tran_approved_by					AS ApprovedBy
	,tran_currency						AS Currency
	,tran_currency_rate					AS CurrencyRate
	,tran_sign * tran_foreign_amount    AS ForeignAmount
	,tran_sign * tran_base_amount 		AS   BaseAmount
	,tran_details						AS TransactionDescription
	,tran_foreign_outstanding			AS foreign_outstanding
	,tran_base_outstanding				AS base_outstanding
	,flag								AS Flag
FROM [dbo].[acctrans_savelines] AS tr
INNER JOIN [dbo].[acctrantypes] AS ty
   ON  tr.tran_transaction_type = ty.[acctrantype_code]
   AND tr.tran_comp = ty.acctrantype_comp
WHERE tr.tran_comp = 'TMF'
AND tran_document_date < '2024-07-01'
GO



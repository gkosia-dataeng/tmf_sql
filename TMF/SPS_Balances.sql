
-- amount =   open + debit + credit
EXEC  [dbo].[ENQ_TrialBalance]  
@Company = 'TMF',
@Year = 2024,
	@SL = 'S/L',
	@PL = 'P/L' ,
	@BS = 'B/S',
	@PAL= 'P&L',
	@AccountFrom = '0',
	@AccountTo = '9999999999',
	@IncludeSaved =1
	
-- amount = open + debit - credit
EXEC [dbo].[ENQ_MonthlyAccBces]  
@Company = 'TMF',
@Year = 2024,
	@SL = 'S/L',
	@PL = 'P/L' ,
	@BS = 'B/S',
	@PAL= 'P&L',
	@AccountFrom = '0',
	@AccountTo = '9999999999',
	@IncludeSaved =1
	
-- amount = debit - credit
exec [dbo].[ENQ_MonthlyAccBcesMovement] 
	@Company = 'TMF',
	@Year = 2024,
	@SL = 'S/L',
	@PL = 'P/L' ,
	@BS = 'B/S',
	@PAL= 'P&L',
	@AccountFrom = '0',
	@AccountTo = '9999999999',
	@IncludeSaved =1,
	@IgnoreAccountsWithNoMovement = 0
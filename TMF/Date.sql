CREATE TABLE PBI.Date (
	 DT DATE
	,[Year] SMALLINT
)


DECLARE @DT DATE = '2022-01-01'

WHILE @DT < '2024-12-31'
BEGIN

	INSERT INTO PBI.Date
	SELECT @DT, YEAR(@DT)
	SET @DT = DATEADD(DAY, 1,@DT)
END 
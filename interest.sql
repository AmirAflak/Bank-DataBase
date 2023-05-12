CREATE PROCEDURE interest_payment

AS
BEGIN
    DECLARE @AccountNumber char(16);
	DECLARE @Interest_amount int;

	SELECT @AccountNumber = accountNumber from account where username IN 
	(SELECT top 1 username FROM login_log ORDER BY login_time DESC);

	SELECT @Interest_amount = interest_rate from account where accountNumber = @AccountNumber;
 
    INSERT INTO Transactions(to_destination, type, amount, transaction_time)
    VALUES (@AccountNumber, 'interest', @Interest_amount, Default);

END;


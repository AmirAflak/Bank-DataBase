CREATE PROCEDURE deposit
    @amount float
AS
BEGIN
    DECLARE @AccountNumber char(16);

	SELECT @AccountNumber = AccountNumber from account where username IN 
	(SELECT top 1 username FROM login_log ORDER BY login_time DESC);
 
    INSERT INTO Transactions (to_destination, type, amount, transaction_time)
    VALUES (@AccountNumber, 'deposit', @amount, Default);
END


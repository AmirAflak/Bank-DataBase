CREATE PROCEDURE transfer
	
    @amount float,
	@AccountNumber_destination char(16)
AS
BEGIN
    DECLARE @AccountNumber_source char(16);

	IF EXISTS (SELECT * FROM account WHERE accountNumber = @AccountNumber_destination)
	begin 
	SELECT @AccountNumber_source = AccountNumber from account where username IN 
	(SELECT top 1 username FROM login_log ORDER BY login_time DESC);
 
    INSERT INTO Transactions (from_source, to_destination, type, amount, transaction_time)
    VALUES (@AccountNumber_source, @AccountNumber_destination, 'transfer', @amount, Default);
	END;
END;

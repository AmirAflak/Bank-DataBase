CREATE PROCEDURE check_balance
AS
BEGIN
    DECLARE @AccountNumber char(16);
	DECLARE @amount float;

	SELECT @AccountNumber = accountNumber from account where username IN 
	(SELECT top 1 username FROM login_log ORDER BY login_time DESC);
	
	 IF EXISTS (SELECT * FROM latest_balances WHERE accountNumber = @AccountNumber)
	 BEGIN
		 select @amount=amount from latest_balances where accountNumber = @AccountNumber;
		 print @amount;
	 END
	 ELSE
	 BEGIN
		print 'Account not Exists';
	 END
END


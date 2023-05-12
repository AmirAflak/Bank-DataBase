CREATE PROCEDURE Register
    @accountNumber char(16),
	@pass VARCHAR(10),
    @firstName VARCHAR(10),
    @lastName VARCHAR(10),
    @national_id char(10),
    @date_of_birth date,
    @type varchar(10),
    @interest_rate int
AS
BEGIN
	DECLARE @hashedPass VARCHAR(256)
	SET @hashedPass = HASHBYTES('SHA2_512', @pass)
	DECLARE @age INT
	SET @age = DATEDIFF(YEAR,@date_of_birth,GETDATE())
	IF @age >= 13
	BEGIN 
    INSERT INTO account(accountNumber, first_name, last_name, national_id, date_of_birth, type, interest_rate, pass)
    VALUES (@accountNumber, @firstName, @lastName, @national_id, @date_of_birth, @type, @interest_rate, @hashedPass);
	INSERT INTO latest_balances(accountNumber, amount)
    VALUES (@accountNumber, 0);
	PRINT 'Account successfully registered';
	END;
END;




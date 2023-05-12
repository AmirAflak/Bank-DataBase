
CREATE PROCEDURE Update_Latest_Balances
AS
BEGIN
    DECLARE @from_source char(16); 
    DECLARE @to_destination char(16);
	DECLARE @type varchar(10);
	DECLARE @amount float;

    DECLARE cur_transactions CURSOR 
    FOR
        SELECT from_source, to_destination, type, amount 
        FROM transactions

    OPEN cur_transactions

    FETCH NEXT FROM cur_transactions
    INTO @from_source, @to_destination, @type, @amount

    WHILE @@FETCH_STATUS = 0 
    BEGIN
        DECLARE @Current_Balance money

		IF @type in ('deposit', 'interest')
		begin 
        SELECT 
            @Current_Balance = amount 
        FROM 
            latest_balances 
        WHERE 
            accountNumber = @to_destination    
        UPDATE latest_balances 
        SET amount = @Current_Balance + @amount 
        WHERE accountNumber = @to_destination
		END

		IF @type = 'withdraw'
		begin 
        SELECT 
            @Current_Balance = amount 
        FROM 
            latest_balances 
        WHERE 
            accountNumber = @from_source
		UPDATE latest_balances 
        SET amount = @Current_Balance + @amount 
        WHERE accountNumber = @from_source
		END 

		IF @type='transfer'
		BEGIN
		UPDATE latest_balances 
        SET amount = @Current_Balance - @amount 
        WHERE accountNumber = @from_source
		UPDATE latest_balances 
        SET amount = @Current_Balance + @amount 
        WHERE accountNumber = @to_destination
		END

        FETCH NEXT FROM cur_transactions
        INTO @from_source, @to_destination, @type, @amount
    END
    CLOSE cur_transactions
    DEALLOCATE cur_transactions
END;
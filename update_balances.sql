CREATE PROCEDURE Update_Latest_Balances
AS
BEGIN
    DECLARE @Customer_Account_Number int 
    DECLARE @Transaction_Amount money

    DECLARE cur_transactions CURSOR 
    FOR
        SELECT * 
        FROM transactions

    OPEN cur_transactions

    FETCH NEXT FROM cur_transactions
    INTO @Customer_Account_Number, @Transaction_Amount

    WHILE @@FETCH_STATUS = 0 
    BEGIN
        DECLARE @Current_Balance money

        SELECT 
            @Current_Balance = amount 
        FROM 
            latest_balances 
        WHERE 
            accountNumber = @Customer_Account_Number

        IF @Current_Balance IS NULL
        BEGIN
            INSERT INTO latest_balances (accountNumber, amount) 
            VALUES (@Customer_Account_Number, @Transaction_Amount)
        END 
        ELSE 
        BEGIN
            UPDATE latest_balances 
            SET amount = @Current_Balance + @Transaction_Amount 
            WHERE accountNumber
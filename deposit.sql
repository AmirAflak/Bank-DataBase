CREATE PROCEDURE Deposit
   -- @AccountNumber VARCHAR(20),
    @Amount float
AS
BEGIN
    DECLARE @Balance DECIMAL(18,2);
    SELECT @Balance = Balance FROM Accounts WHERE AccountNumber = @AccountNumber;

    SET @Balance = @Balance + @Amount;

    UPDATE Accounts SET Balance = @Balance WHERE AccountNumber = @AccountNumber;

    INSERT INTO Transactions (AccountNumber, TransactionType, Amount, Date)
    VALUES (@AccountNumber, 'Deposit', @Amount, GETDATE());
END
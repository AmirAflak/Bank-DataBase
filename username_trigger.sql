CREATE TRIGGER Generate_Unique_Username
ON account
AFTER INSERT
AS
BEGIN
    DECLARE @FirstName varchar(10)
    DECLARE @LastName varchar(10)
    DECLARE @Username varchar(20)
    DECLARE @Counter int = 0

    SELECT @FirstName = i.first_name, @LastName = i.last_name
    FROM inserted i

    SET @Username = CONCAT(@FirstName, @LastName)

    WHILE EXISTS (SELECT * FROM account WHERE username = @Username)
    BEGIN
        SET @Counter = @Counter + 1
        SET @Username = CONCAT(@FirstName, @LastName, @Counter)
    END

    UPDATE account
    SET username = @Username 
    WHERE username IS NULL
END
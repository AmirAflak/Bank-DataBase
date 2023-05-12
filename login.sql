CREATE PROCEDURE Login 
    @username VARCHAR(20),	
    @pass VARCHAR(10)
AS
BEGIN
    DECLARE @hashed_Pass VARCHAR(256)
    SET @hashed_Pass = HASHBYTES('SHA2_512', @pass)

    IF EXISTS (SELECT * FROM account WHERE username = @username AND pass = @hashed_Pass)
    BEGIN
        INSERT INTO login_log (username, login_time)
       -- VALUES (@username, GETDATE());
		VALUES (@username, Default)
		
        PRINT 'Login successful';
    END
    ELSE
    BEGIN
        PRINT 'Login failed';
    END
END;
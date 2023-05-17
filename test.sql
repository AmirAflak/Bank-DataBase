DECLARE @accountNumber char(16) = '9876543210123456'
DECLARE @pass VARCHAR(10) = 'MyPass123'
DECLARE @firstName VARCHAR(10) = 'Jane'
DECLARE @lastName VARCHAR(10) = 'Doe'
DECLARE @national_id char(10) = '0987654321'
DECLARE @date_of_birth date = '1995-05-17'
DECLARE @type varchar(10) = 'Checking'
DECLARE @interest_rate int = 3

EXEC Register @accountNumber, @pass, @firstName, @lastName, @national_id, @date_of_birth, @type, @interest_rate

--EXEC sp_MSforeachtable 'DROP TABLE ?'

select * from account;
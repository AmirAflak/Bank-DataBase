DECLARE @accountNumber char(16) = '9810843299321456'
DECLARE @pass VARCHAR(10) = 'pass24'
DECLARE @firstName VARCHAR(10) = 'Leo'
DECLARE @lastName VARCHAR(10) = 'ng'
DECLARE @national_id char(10) = '2327654298'
DECLARE @date_of_birth date = '2002-05-17'
DECLARE @type varchar(10) = 'client'
DECLARE @interest_rate int = 3

EXEC Register @accountNumber, @pass, @firstName, @lastName, @national_id, @date_of_birth, @type, @interest_rate

--EXEC sp_MSforeachtable 'DROP TABLE ?'
--SELECT name, collation_name FROM sys.databases;
--SELECT FROM_UNIXTIME(snapshot_timestamp) FROM snapshot_log;
--SELECT name, sid FROM sys.server_principals WHERE type_desc IN ('SQL_LOGIN', 'WINDOWS_LOGIN');


select * from account;
select * from transactions;
select * from snapshot_log;
select * from login_log;
select * from latest_balances;
EXEC update_balances;

DECLARE @pass VARCHAR(10) = 'pass24'
DECLARE @username VARCHAR(20) = 'Leong'
EXEC Login @username, @pass

DECLARE @amount FLOAT = 15000;
EXEC deposit @amount;
DECLARE @amount FLOAT = 10000;
EXEC withdraw @amount;

DECLARE @amount FLOAT = 15000;
DECLARE @AccountNumber_destination char(16) = '9879843210123456';
EXEC transfer @amount, @AccountNumber_destination;

select * from snapshot_1;
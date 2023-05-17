
CREATE PROCEDURE update_balances
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
        DECLARE @Current_Balance float;
		DECLARE @snapshotID int; 
		DECLARE @table_name varchar(20);
		DECLARE @interest_rate float;

		IF @type = 'deposit'
		begin 
        SELECT 
            @Current_Balance = amount 
        FROM 
            latest_balances 
        WHERE 
            accountNumber = @to_destination    
        UPDATE latest_balances 
        SET amount = @Current_Balance + @amount 
        WHERE accountNumber = @to_destination;
		INSERT INTO snapshot_log
		VALUES (DEFAULT);
		select @snapshotID = MAX(snapshot_id) from snapshot_log;
		SET @table_Name = CONCAT('snapshot_', @snapshotID);
		EXEC('CREATE TABLE ' + @table_Name + 
          'AS SELECT * FROM latest_balances');
		END

		IF @type = 'interest'
		begin 
        SELECT 
            @Current_Balance = amount 
        FROM 
            latest_balances 
        WHERE 
            accountNumber = @to_destination;
		SELECT @interest_rate = interest_rate
		FROM
			account 
		WHERE 
			accountNumber = @to_destination;
        UPDATE latest_balances 
        SET amount = (@Current_Balance) + (@amount * (1+(@interest_rate/100)))
        WHERE accountNumber = @to_destination;
		INSERT INTO snapshot_log
		VALUES (DEFAULT);
		select @snapshotID = MAX(snapshot_id) from snapshot_log;
		SET @table_Name = CONCAT('snapshot_', @snapshotID);
		EXEC('CREATE TABLE ' + @table_Name + 
          'AS SELECT * FROM latest_balances');
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
		INSERT INTO snapshot_log
		VALUES (DEFAULT);
		select @snapshotID = MAX(snapshot_id) from snapshot_log;
		SET @table_Name = CONCAT('snapshot_', @snapshotID);
		EXEC('CREATE TABLE ' + @table_Name + 
          'AS SELECT * FROM latest_balances');
		END 

		IF @type='transfer'
		BEGIN
		UPDATE latest_balances 
        SET amount = @Current_Balance - @amount 
        WHERE accountNumber = @from_source
		INSERT INTO snapshot_log
		VALUES (DEFAULT);
		select @snapshotID = MAX(snapshot_id) from snapshot_log;
		SET @table_Name = CONCAT('snapshot_', @snapshotID);
		EXEC('CREATE TABLE ' + @table_Name + 
          'AS SELECT * FROM latest_balances');
		UPDATE latest_balances 
        SET amount = @Current_Balance + @amount 
        WHERE accountNumber = @to_destination
		INSERT INTO snapshot_log
		VALUES (DEFAULT);
		select @snapshotID = MAX(snapshot_id) from snapshot_log;
		SET @table_Name = CONCAT('snapshot_', @snapshotID);
		EXEC('CREATE TABLE ' + @table_Name + 
          'AS SELECT * FROM latest_balances');
		END

        FETCH NEXT FROM cur_transactions
        INTO @from_source, @to_destination, @type, @amount
    END
    CLOSE cur_transactions
    DEALLOCATE cur_transactions
END;
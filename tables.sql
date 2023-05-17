create table account(
	username varchar(20) unique,
	accountNumber char(16) unique,
	pass varchar(256),
	first_name varchar(10),
	last_name varchar(10),
	national_id char(10),
	date_of_birth DATE,
	type varchar(10),
	interest_rate int
);

create table login_log(
	username varchar(20) FOREIGN KEY REFERENCES account(username),
	login_time TIMESTAMP,
	--constraint fk_1 FOREIGN KEY (username) REFERENCES account(username)
);


create table transactions(
	from_source char(16) FOREIGN KEY REFERENCES account(accountNumber),
	to_destination char(16) FOREIGN KEY REFERENCES account(accountNumber),
	type varchar(10),
	transaction_time TIMESTAMP,
	amount float,	
	--constraint fk_1 FOREIGN KEY (from_source) REFERENCES account(accountNumber),
	--constraint fk_2 FOREIGN KEY (to_destination) REFERENCES account(accountNumber)
);

create table latest_balances(
	accountNumber char(16)  FOREIGN KEY REFERENCES account(accountNumber),
	amount float,
	--constraint fk_1 FOREIGN KEY (accountNumber) REFERENCES account(accountNumber)
)

create table snapshot_log(
	snapshot_id int IDENTITY(1,1),
	snapshot_timestamp TIMESTAMP
)

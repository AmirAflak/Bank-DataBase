create table account(
	username varchar(20) primary key,
	accountNumber char(16) unique,
	pass varchar(10),
	first_name varchar(10),
	last_name varchar(10),
	national_id char(10),
	date_of_birth DATE,
	event_type varchar(10),
	interest_rate int
);

create table login_log(
	username varchar(20),
	login_time TIMESTAMP(3),
	constraint fk_1 FOREIGN KEY (username) REFERENCES account(username)
);

create table transactions(
	from_source char(16),
	to_destination char(16),
	event_type varchar(10),
	transaction_time TIMESTAMP(3),
	amount float,
	constraint fk_1 FOREIGN KEY (from_source) REFERENCES account(accountNumber),
	constraint fk_2 FOREIGN KEY (to_destination) REFERENCES account(accountNumber)
);

create table latest_balances(
	accountNumber char(16),
	amount float,
	constraint fk_1 FOREIGN KEY (accountNumber) REFERENCES account(accountNumber)
)

create table snapshot_log(
	snapshot_id serial,
	snapshot_timestamp TIMESTAMP(3)
)



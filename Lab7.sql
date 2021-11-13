create table customers (
    id integer primary key,
    name varchar(255),
    birth_date date
);

create table accounts(
    account_id varchar(40) primary key ,
    customer_id integer references customers(id),
    currency varchar(3),
    balance float,
    "limit" float
);

create table transactions (
    id serial primary key ,
    date timestamp,
    src_account varchar(40) references accounts(account_id),
    dst_account varchar(40) references accounts(account_id),
    amount float,
    status varchar(20)
);

INSERT INTO customers VALUES (201, 'John', '2021-11-05');
INSERT INTO customers VALUES (202, 'Anny', '2021-11-02');
INSERT INTO customers VALUES (203, 'Rick', '2021-11-24');

INSERT INTO accounts VALUES ('NT10204', 201, 'KZT', 1000, null);
INSERT INTO accounts VALUES ('AB10203', 202, 'USD', 100, 0);
INSERT INTO accounts VALUES ('DK12000', 203, 'EUR', 500, 200);
INSERT INTO accounts VALUES ('NK90123', 201, 'USD', 400, 0);
INSERT INTO accounts VALUES ('RS88012', 203, 'KZT', 5000, -100);

INSERT INTO transactions VALUES (1, '2021-11-05 18:00:34.000000', 'NT10204', 'RS88012', 1000, 'commited');
INSERT INTO transactions VALUES (2, '2021-11-05 18:01:19.000000', 'NK90123', 'AB10203', 500, 'rollback');
INSERT INTO transactions VALUES (3, '2021-06-05 18:02:45.000000', 'RS88012', 'NT10204', 400, 'init');





create role accountant;
grant select,update on accounts to accountant;
grant select,update on transactions to accountant;

create role administrator;
grant all privileges on accounts to administrator;
grant all privileges on customers to administrator;
grant all privileges on transactions to administrator;

create role support;
grant select,update on customers,accounts,transactions to  support;

create user Ben;
create user Jack;
create user Tom;
grant accountant to Ben;
grant administrator to Jack ;
grant support to Tom;


--grant administrator to Jack with grant option;

create role admin7 createrole;
grant admin7 to Jack;


revoke update on accounts from Ben;


alter table transactions alter column status set not null;

create unique index onlyon
on accounts (customer_id,currency);


create index tra
on accounts(currency,balance);


do
$$
declare
    transaction_amount int;
    destination varchar(40);
    source varchar(40);

begin
    insert into transactions values(transaction_amount,destination,source,'init') ;

update accounts set balance=balance+ transaction_amount where account_id=destination;
update accounts set balance=balance-transaction_amount where account_id=source;
update transactions set status ='commited';
    exception
    when others then
        update transactions set status='rollback';
end
$$
language plpgsql;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    charge float
);

INSERT INTO dealer (id, name, location, charge) VALUES (101, 'Ерлан', 'Алматы', 0.15);
INSERT INTO dealer (id, name, location, charge) VALUES (102, 'Жасмин', 'Караганда', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (105, 'Азамат', 'Нур-Султан', 0.11);
INSERT INTO dealer (id, name, location, charge) VALUES (106, 'Канат', 'Караганда', 0.14);
INSERT INTO dealer (id, name, location, charge) VALUES (107, 'Евгений', 'Атырау', 0.13);
INSERT INTO dealer (id, name, location, charge) VALUES (103, 'Жулдыз', 'Актобе', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Айша', 'Алматы', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Даулет', 'Алматы', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Кокшетау', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Ильяс', 'Нур-Султан', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Алия', 'Караганда', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Саша', 'Шымкент', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Маша', 'Семей', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Максат', 'Нур-Султан', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2012-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2012-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2012-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2012-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2012-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2012-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2012-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2012-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2012-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2012-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2012-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2012-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;

select * from dealer cross join  client;

select dealer.id,dealer.name, client.dealer_id , client.name , client.city,client.priority, sell.id,sell.date,sell.amount
from dealer  join client
on  client.dealer_id=dealer.id
join sell  on  client.id = sell.client_id;

select * from dealer inner join client on dealer.location=client.city;

select sell.id , sell .amount , client.name, client.city
from sell inner join client  on client.id = sell.client_id
where sell.amount >100 and sell.amount<500;

select client.name,dealer.name as Dealer
from client
full join dealer
on dealer.id=client.dealer_id


select client.name , client.city  , dealer.name as dealer , dealer.charge
from client
 join dealer  on dealer.id = client.dealer_id


select client.name , client.city, dealer.name as dealer, dealer.charge
from client
join dealer  on dealer.id = client.dealer_id
where dealer.charge >0.12;
select client.name , client.city ,sell.id as sell_id, sell.date, sell.amount ,dealer.name as dealer, dealer.charge
from client
right join dealer
on dealer.id=client.dealer_id
right join sell
on sell.client_id=client.id

select client.name , client.priority , dealer.name as dealer , sell.id , sell.amount
from client
join dealer  on client.dealer_id = dealer.id
join sell  on client.id = sell.client_id;


create view clientcount
as  select sell.date , count(distinct  sell.client_id),
avg(sell.amount) , sum(sell.amount)
from sell
group by sell.date;

select * from clientcount;

create view top5
as select date, sum(amount)
from sell
group by date
order by sum(amount) desc limit 5;

select * from top5;

create view dealers
as select dealer_id , count(dealer_id), avg(amount) , sum(amount)
from sell
group by dealer_id;

select * from dealers;

create view  hoch55
as select location,sum(sell.amount)*dealer.charge as delloc
from  dealer
join sell  on dealer.id = sell.dealer_id
group by location,charge;
select * from hoch55;


create view locf
as select location, count(location),avg(amount),sum(amount)
from sell
join dealer  on sell.dealer_id = dealer.id
group by location ;

select * from locf;

create view citc12
as select city, count(city),avg(amount),sum(amount)
from client
join sell  on client.id = sell.client_id
group by city;

select * from citc12;

create view lsm
as select location,citc12.sum,locf.sum as location4
from  citc12
join   locf on citc12.sum>locf.sum;


select distinct location from lsm;

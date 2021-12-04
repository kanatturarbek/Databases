

create type  fulllname as (
    F_name varchar(255),
    L_name varchar(255)
                         );


create table customer(
    id integer primary key,
    name fulllname,
    gender varchar(255),
    address text,
    phone_number int,
    city varchar






);


create table orders(
    id integer primary key ,
    customer_id integer references customer(id),
    total_price integer,
    status varchar
);




create table product(
    id integer primary key ,
    name varchar(255),
    price float
);


create table manufacter(
    id integer  ,
    product_id integer references product(id),
    address varchar(255),
    phone_number integer,
    primary key (id,product_id)

);
create table category(
    name varchar(255) ,
    product_id integer references product(id),
    primary key (name,product_id)
);
create table sale_report(
       id integer primary key ,
     order_id integer references orders(id),
    customer_id integer references customer(id),
    product_id integer references product(id),
       payment_id integer references payment(payment_id),
       year int
)  ;


create table payment(
  payment_id integer primary key ,
  payment_method varchar(255),
  customer_id integer references customer(id),
  payment_date timestamp,
  amount float
);

create table delivery(
    order_id int ,
    customer_id int references customer(id),
    order_date timestamp,
    deliveried_date timestamp,
    status text,
    delivery_time_hours int,
    track_id integer,
    product_id int references product,
    address varchar(255)  ,
    primary key (order_id),
    foreign key (order_id) references orders(id)
    on delete set null

);


create table supplier(
  id integer primary key ,
 full_name varchar(255),
  salary integer,
  gender varchar(255)
);

create table storage(
  address varchar(255),
  product_id int references product(id),
  remained integer,
    primary key (address,product_id),
    foreign key (product_id) references product(id)
    on delete set null

);


create table shop(
  order_id int,
  address varchar(255),
  phone_number int,
  primary key (order_id),
  foreign key (order_id) references orders(id)
  on delete set null

);

create table employee(
    id integer primary key,
    full_name varchar(255),
    salary integer,
    gender varchar(255)
);

drop table orders;
drop table sale_report;
DROP TABLE delivery;
drop table SHOP;
DROP TABLE payment;
drop table customer;
drop table manufacter;
drop table category;
drop table storage;

select * from sale_report  where order_id=1234454;


select customer_id,sum(amount) from payment group by customer_id order by sum(amount) desc limit 1;

select product_id,count(product_id) from sale_report where year=2020 group by product_id order by count(product_id) desc limit 2;

select sale_report.product_id ,sum(payment.amount) from payment,sale_report where year=2020 and payment.payment_id = sale_report.payment_id  group by sale_report.product_id order by sum(payment.amount) desc limit 2;

select product_id,remained from storage where address='California' and remained=0;

select order_id,status from delivery where status='undeliveried';

select customer_id,sum(amount) from payment group by customer_id ;

insert into customer values (1,'(Turarbek,Kanat)','M','Tole bi 8','5454646','Almaty');
insert into customer values (2,'(Polina,Gagarina)','F','Krasnay Ploshad 7','8874111','Moscow');
insert into customer values (3,'(Justin,Bieber)','M','Washington 44','4539154','California');
insert into customer values (4,'(Aibek,Kuralbaev)','M','Gogol 54','8741216','Almaty');
insert into customer values (5,'(Almat,Batyrkulov)','M','Kabanbai batyr 28/2','7461678','Astana');
insert into customer values (6,'(Yulia , Parshoota)','F','Sovetski 44','12156450','Moscow');
insert into customer values (7,'(Lady,Gaga)','F','Underground 47s','8898655','California');
insert into customer values (8,'(Nurzhan , Batyrkulov)','M','Nazarbayev 88/7','54879512','Astana');
insert into customer values (9,'(Anatoli,Tsoy)','M','Abay 78','9895325','Almaty');
insert into customer values (10,'(Karina,Koks)','F','Pushkin 88','7777777','Moscow');
insert into customer values (11,'(Bred,Pit)','M','Downtown 77','8785454','California');
insert into customer values (12,'(Dan,Balan)','M','Stroyteli 888','8878454','Nur-Sultan');
select * from customer;


insert into orders values (100,1,1500,'online');
insert into orders values (101,2,2500,'offline');
insert into orders values (102,3,3500,'online');
insert into orders values (103,4,4500,'online');
insert into orders values (104,5,5500,'offline');
insert into orders values (105,6,1544,'offline');
insert into orders values (106,7,500,'offline');
insert into orders values (107,8,100,'online');
insert into orders values (108,9,10,'offline');
insert into orders values (109,10,150,'online');
insert into orders values (110,11,304,'offline');
insert into orders values (111,12,15,'offline');
insert into orders values (112,1,1540,'offline');
insert into orders values (113,1,8784,'online');
insert into orders values (114,2,878,'online');
insert into orders values (115,3,145,'offline');
insert into orders values (116,3,180,'offline');
insert into orders values (117,3,151,'offline');
insert into orders values (118,11,12000,'offline');
insert into orders values (119,12,5920,'online');
insert into orders values (1234454,12,5920,'online');
select * from orders;


insert into product values (55,'Acer Nitro4',1100);
insert into product values (56,'Acer Aspire5',1000);
insert into product values (57,'Acer Aspire7',548);
insert into product values (58,'Macbook Air',999);
insert into product values (59,'Makbook Pro',1500);
insert into product values (54,'Lenova S4848',331);
insert into product values (33,'Iphone S',100);
insert into product values (34,'Iphone S+',101);
insert into product values (35,'Iphone 11',300);
insert into product values (36,'Iphone 11pro',359);
insert into product values (37,'Iphone 11promax',370);
insert into product values (38,'Iphone 12',470);
insert into product values (39,'Iphone 13',700);
insert into product values (77,'Airpods 1',150);
insert into product values (78,'Airpods 2',170);
insert into product values (79,'Airpods pro',200);
insert into product values (51,'Realme S',110);
insert into product values (50,'Xiomi y4',177);
insert into product values (60,'Samsung A41',1774);
insert into product values (61,'Samsung A54',117);
insert into product values (444,'lsc 4545',17);
insert into product values (445,'lac 45',14);
insert into product values (999,'Ipad mini',444);
insert into product values (991,'Ipad',490);
insert into product values (900,'Ipad pro',777);
insert into product values (907,'Ipad air',555);
insert into product values (62,'Samsung tab',100);
insert into product values (63,'Huawei 4',117);
insert into product values (64,'Meizu ada',187);
insert into product values (65,'Nokia 7ad',177);
insert into product values (66,'Pixel',114);
insert into product values (67,'Matarolla',116);

select * from product;


insert into manufacter values(1000,55,'China, Guanjou',8787787);
insert into manufacter values(1000,56,'China, Guanjou',8787787);
insert into manufacter values(1000,57,'China, Guanjou',8787787);
insert into manufacter values(111,58,'China ,Pekin  ',15451021);
insert into manufacter values(111 ,33 ,'China,Pekin ',15451021);
insert into manufacter values(111,34,'China,Pekin ',15451021);
insert into manufacter values(111 ,35,'China,Pekin ',15451021);
insert into manufacter values(111,36,'China,Pekin ',15451021);
insert into manufacter values(111,37,'China,Pekin ',15451021);
insert into manufacter values(111,77,'China,Pekin ',15451021);
insert into manufacter values(111,78,'China,Pekin ',15451021);
insert into manufacter values(111,79,'China,Pekin ',15451021);
insert into manufacter values(111 ,999,'China,Pekin ',15451021);
insert into manufacter values(111,991 ,'China,Pekin ',15451021);
insert into manufacter values(111 ,900 ,'China,Pekin ',15451021);
insert into manufacter values(177, 54,'China,Hong' ,78454);
insert into  manufacter values (199,51,'Korea, Pusan',874841);
insert into manufacter values (200,50,' China, Heo',84848);
insert into manufacter values (555 , 60 , 'Korea, Seoul',55555);
insert into manufacter values (555 , 61 , 'Korea, Seoul',55555);
insert into manufacter values (555 , 62 , 'Korea, Seoul',55555);
insert into manufacter values (500 , 444, 'Japan, Tokyo',55484);
insert into manufacter values (500 , 445, 'Japan, Tokyo',55484);
insert into manufacter values (666 , 63 , 'China, Tonjon',7777);
insert into manufacter values (99 , 64 , 'Russia, Moscow',5878);
insert into manufacter values (88,65, 'Finland  , Reiko',7774151);
insert into manufacter values (77,66 , 'USA,Detroit' ,  84841541);
insert into manufacter values (444,67, 'USA, New York ',959595);

select * from manufacter;

insert into category values ('laptop' ,55);
insert into category values ('laptop' , 56);
insert into category values ('laptop' , 57);
insert into category values ('laptop' , 58);
insert into category values ('laptop' , 59);
insert into category values ('phone', 33 );
insert into category values ('phone', 34 );
insert into category values ('phone', 35 );
insert into category values ('phone', 36 );
insert into category values ('phone', 37 );
insert into category values ('phone', 38 );
insert into category values ('phone', 39 );
insert into category values ('phone', 50 );
insert into category values ('phone', 51 );
insert into category values ('phone', 60 );
insert into category values ('phone', 61 );
insert into category values ('phone', 63 );
insert into category values ('phone', 64 );
insert into category values ('phone', 65 );
insert into category values ('phone', 66 );
insert into category values ('phone', 67 );
insert into category values ('earphone',77);
insert into category values ('earphone',78);
insert into category values ('earphone',79);
insert into category values ('earphone',444 );
insert into category values ('earphone',445);
insert into category values ('tablet',991);
insert into category values ('tablet',999);
insert into category values ('tablet',900);
insert into category values ('tablet',62);
select * from category;


insert into payment values (1100,'card',1,'2021-10-02 10:10:10', 2555);
insert into payment values (1101,'card',2,'2019-10-02 10:10:10', 255);
insert into payment values (1102,'card',1,'2018-11-02 10:10:10', 555);
insert into payment values (1103,'card',3,'2017-11-02 10:10:10', 155);
insert into payment values (1104,'card',4,'2018-10-02 10:10:10',12555);
insert into payment values (1105,'account_number ',5,'2013-10-02 10:10:10', 21);
insert into payment values (1106,'card',2,'2015-11-02 10:10:10', 2);
insert into payment values (1107,'account_number ',7,'2014-10-02 10:10:10', 65);
insert into payment values (1108,'card',3,'2020-11-02 10:10:10', 25);
insert into payment values (1109,'account_number ',8,'2020-11-02 10:10:10',14555);
insert into payment values (1110,'account_number ',9,'2020-11-02 10:10:10', 2417);
insert into payment values (1111,'card',10,'2019-10-02 10:10:10', 1145);
insert into payment values (1112,'card',1,'2019-10-02 10:10:10', 8117);
insert into payment values (1113,'card',2,'2018-11-02 10:10:10', 7577);
insert into payment values (1114,'card',8,'2018-11-02 10:10:10', 6655);
insert into payment values (1115,'card',9,'2020-11-02 10:10:10', 5555);

select * from    payment;

insert into sale_report values (100000,100,1,55,1100,2019);
insert into sale_report values (100001,101,2,56,1101,2019);
insert into sale_report values (100002,102,3,57,1102,2017);
insert into sale_report values (100003,103,4,58,1103,2017);
insert into sale_report values (100004,104,5,59,1104,2016);
insert into sale_report values (100005,105,6,54,1105,2019);
insert into sale_report values (100006,106,7,33,1106,2019);
insert into sale_report values (100007,107,8,34,1107,2019);
insert into sale_report values (100008, 108,9,35,1108,2017);
insert into sale_report values (100009,109,11,36,1109,2020);
insert into sale_report values (100010,110,10   ,37,1110,2020);
insert into sale_report values (100011,111  ,  12,38,1111,2020);
insert into sale_report values (100012,112,11,39,1112,2020);
insert into sale_report values (100013,113,10,77,1113,2020);
insert into sale_report values (100014,114,10,78,1114,2019);
insert into sale_report values (100015,115,4,79,1114,2020);
insert into sale_report values (100016,116,2,51,1113,2019);
insert into sale_report values (100017,117,6,50,1112,2020);
insert into sale_report values (100018,118,2,60,1114,2019);
insert into sale_report values (100019,119,5,444,1110,2010);
insert into sale_report values (100020,101,1,445,1100,2011);
insert into sale_report values (100021,102,4,999,1101,2019);
insert into sale_report values (100022,110,9,991,1105,2018);
insert into sale_report values (100023,111,11,900   ,1103,2015);
insert into sale_report values (100024,110,6,62,1104,2014);
insert into sale_report values (100025,118,2,63,1105,2013);
insert into sale_report values (100026,119,3,64,1106,2019);
insert into sale_report values (100027,101,7,65,1107,2020);
insert into sale_report values (100028,102,8,66,1108,2019);
insert into sale_report values (100029,107,12,55,1109,2020);
insert into sale_report values (100030,108,10,55,1110,2020);
insert into sale_report values (100031,100,1,55,1111,2020);
insert into sale_report values (100032,1234454,1,444,1111,2020);
select * from sale_report;

insert into delivery   values (100,1,'2021-11-02 10:10:10','2021-12-02 19:40:10','deliveried',48,1119,445,'Tole bi 77');
insert into delivery values (102,3,'2020-11-02 10:10:10','2021-10-02 10:10:10' , 'undeliveried', 100   ,1111,444,'Tole bi 77');
insert into delivery values (103,4,'2021-10-02 10:10:10','2021-10-02 11:10:10','deliveried', 64   ,11151,55,'Tole bi 77');
insert into delivery values (107,8,'2020-09-02 12:10:10','2020-10-03 12:40:10','deliveried',    84,1155,56,'Tole bi 77');
insert into delivery values (109,11,'2020-10-02 10:10:10','2021-10-02 10:10:10','undeliveried',24,1542,66,'Tole bi 77');
insert into delivery values (113,10,'2021-10-02 10:10:10','2021-12-02 00:10:10','deliveried',150,1548,999,'Tole bi 77');
insert into delivery values (114,10,'2021-02-02 17:10:50','2021-08-04 14:10:10','deliveried',24,1558,77,'Tole bi 77');
insert into delivery values (119,5,'2021-11-02 14:10:10','2021-11-04 17:10:10','deliveried',8,1258,78,'Tole bi 77');
insert into delivery values (1234454,1,'2021-11-02 14:10:10','2021-11-04 17:10:10','notdeliveried',8,1258,78,'Tole bi 77');

select * from delivery;

insert into supplier values (111,'Turarbek Kanat Rysbaiyly',75000,'M');
insert into supplier values (112,'Turar Zhanat ',75000,'F');
insert into supplier values (113,'Turarbek Almat ',75000,'M');
insert into supplier values (114,'Dima Kan',75000,'M');

select * from supplier;


insert into storage values ('Tole bi 77',64,10);
insert into storage values ('Tole bi 77',55,848);
insert into storage values ('Tole bi 77',56,44);
insert into storage values ('Tole bi 77',57,0);
insert into storage values ('Tole bi 77',444,0);
insert into storage values ('Tole bi 77',445,0);
insert into storage values ('Tole bi 77',999,0);
insert into storage values ('California',900,0);
insert into storage values ('Tole bi 76',62,4);
insert into storage values ('Tole bi 76',67,1);
insert into storage values ('Tole bi 76',63,0);
insert into storage values ('Tole bi 76',38,0);
insert into storage values ('Tole bi 76',77,5);
insert into storage values ('Tole bi 76',64,6);
insert into storage values ('Tole bi 76',65,7);
insert into storage values ('Tole bi 76',66,8);



insert into shop values (101,'Tole bi 76 ', 5444511);
insert into shop values (104,'Tole bi 76 ', 5444511);
insert into shop values (105,'Tole bi 76 ', 5444511);
insert into shop values (106,'Tole bi 76 ', 5444511);
insert into shop values (108,'Tole bi 76 ', 5444511);
insert into shop values (110,'Tole bi 76 ', 5444511);
insert into shop values (111,'Tole bi 76 ', 5444511);
insert into shop values (112,'Tole bi 76 ', 5444511);
insert into shop values (115,'Tole bi 76 ', 5444511);
insert into shop values (116,'Tole bi 76 ', 5444511);
insert into shop values (117,'Tole bi 76 ', 5444511);
insert into shop values (118,'Tole bi 76 ', 5444511);
select * from shop;



insert into employee values (151,'Kemelkhan Zhanerke',88800,'F');
insert into employee values (152,'Kizametdinov Temirlan',88800,'M');
insert into employee values (153,'Torekeldi Ulzhan',88800,'F');
insert into employee values (154,'Apsattar Zhappar',88800,'M');

select * from employee;

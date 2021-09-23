task 1

create database lab_2;
create table department(
    dept_name varchar(20),
    building varchar(20),
    budget int
);
drop table department;
insert into department values ('History','Southwestern','1111000');
update department set dept_name='Biology' where dept_name='History';
select * from department;
delete from department where building='Southwestern';

task 2

create table customers(
    id int primary key,
    full_name varchar(50) not null ,
    timestamp timestamp not null,
    delivery_address text not null
);
create table orders(
    code int primary key,
    customer_id int references customers (id),
    total_sum double precision not null check(total_sum>0),
    is_paid boolean not null
);
create table products(
    id varchar primary key,
    name varchar not null unique,
    description text,
    price double precision not null check(price>0)
);
create table order_items(
    order_code int references orders(code),
    product_id varchar references products(id),
    quantity int not null check(quantity>0),
    primary key (order_code,product_id)

);

Task 3

create table students(
    full_name varchar Primary key,
    age int not null,
    birth_date date not null,
    gender varchar not null,
    average_grade double precision not null,
    information text not null ,
    need_dorm boolean not null,
    additional_inf text

);
create table instructors(
    full_name varchar Primary key,
    speaking_lang varchar not null,
    woek_experience text not null,
    remote_lessons boolean not null
);
create table lessons(
   lesson_title varchar Primary key,
   instructor_name varchar references instructors(full_name),
   room_numb int not null
);
create table studsub(
   student varchar references students (full_name),
   stud_lesson varchar references lessons(lesson_title),
   primary key(student)
);
Task 4

insert into customers values('202030500','Kanat Turarbek','2003-05-04 02:44:59','Aqsai 3');
insert into orders values('24','202030500','1000',false);
insert into products values('111v','Leo','south atlantic salmon','1000.00');
insert into order_items values('24','111v',50);

update customers set full_name='Almat Batyrkulov' where full_name='Kanat Turarbek' ;
update orders set total_sum='222' where total_sum='1000';
update products set description='south american crab' where description='south atlantic salmon';
update order_items set quantity =20 where quantity=50;

delete from order_items where order_code='24';
delete from orders where is_paid=false ;
delete from products where price='1000.00';
delete from customers where id='202030500';
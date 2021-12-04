create database lab8;

create or replace function plus1(number integer)
returns integer as
    $$
    begin
    return number+1;
 end;
    $$
LANGUAGE 'plpgsql';

select plus1(8);


create or replace function addition(number1 integer,number2 integer)
returns integer as
    $$
    begin
    return number1+number2;
 end;
    $$
LANGUAGE 'plpgsql';

select addition(2,3);

create or replace function iseven(number1 integer,number2 integer)
returns bool as
    $$
    begin
    if(number1%2=0 and number2%2=0 and number2!=0 and number1!=0) then
        return true;
    else
     return false;
end if;
    end;
    $$
LANGUAGE 'plpgsql';

select iseven(77712,4);



  create or replace function  isvalid(pswr varchar)
returns bool    as
    $$
    begin
    if(length(pswr)>8 and length(pswr)<15 ) then
        return true;
    else
     return false;
end if;
    end
    $$
LANGUAGE 'plpgsql';

select  isvalid('Astana');

create or replace function outp( full_name text)
returns record as
$$
declare surname record;
declare name record;
begin
 select split_part(full_name,' ',1) into name;
 select split_part(full_name,' ',2) into surname;
return name  ;

end;
$$
language 'plpgsql';


select outp(   'Kanat Turarbek ');



--4
\
create table employee(
id integer  PRIMARY KEY ,
name varchar,
date_of_birth date,
age integer,
salary integer,
workexperience integer,
discount integer
);


create or replace  procedure  incrse()


language plpgsql
as $$
begin
update employee
set salary= salary * power(1.10, workexperience/2),
    discount=10 *power(1.01, workexperience/5);



commit;
end;
$$;



create or replace  procedure  ince()





language plpgsql
as $$
begin
update employee
set salary= salary * 1.15
where age>=40;

update employee
set discount=10
where workexperience>8;

update employee
set  salary=salary*1.15*1.15
where workexperience>8   and age>=  40;

update employee
set salary=salary*1.15
where workexperience>8  and age<40;




commit;
end;
$$

--5

create table members(
    memid integer,
    surname varchar(200),
    firstname varchar(200),
    address varchar(200),
    zipcode integer,
    telephone varchar(20),
    recommendedby integer,
    joindate timestamp
);


create table    bookings(
    facid integer,
    memid integer,
    starttime timestamp,
    slots integer

);


create table facilities (
    facid integer,
    name varchar(100),
    membercost numeric,
    guestcost numeric,
    initialoutlay numeric,
    monthlymaintenance numeric


);

with recursive recommenders(recommender, member) as (
	select recommendedby, memid
		from members
	union all
	select m.recommendedby, r.member
		from recommenders r
		inner join members m
			on m.memid = r.recommender
)
select r.member member, r.recommender, m.firstname, m.surname
	from recommenders r
	inner join members m
		on r.recommender = m.memid
	where r.member = 22 or r.member = 12
order by r.member asc, r.recommender desc



--3
   --The function must return a value but in Stored Procedure it is optional. Even a procedure can return zero or n values.

--  Functions can have only input parameters for it whereas Procedures can have input or output parameters.

--  Functions can be called from Procedure whereas Procedures cannot be called from a Function.

--2
create table stud(
id int primary key ,
name varchar,
course int,
time    timestamp
);
create or replace function lastchanges()
   returns trigger
   language plpgsql
   as
$$
        begin
        new.time  =  now();
        return new;
        end;
$$;
create trigger l_changd
before update or insert or delete
on stud
for each row
execute procedure lastchanges();
insert into stud(id,name,course) values (11,'Kuanysh',1)
insert into stud(id,name,course) values (1110, 'Kanat',2);
select * from stud;

drop table stud;

--B
 create table person(
 id int primary key ,
 name varchar,
 age int,
 year_of_birth int not null
);
create or replace function age()
returns trigger
language plpgsql
as
$$
  begin
      new.age=extract(year from current_date) - new.year_of_birth;
  return new;
end;
$$;
create trigger age5
before insert
on person
for each row
execute procedure age();
insert into person(id,name,year_of_birth) values (3,'Kanat',2003);

select * from person;

--C
create table item(
id int primary key ,
name varchar,
price int

);

create or replace function tax()
returns trigger
language plpgsql
as
$$
begin

  new.price= new.price*   1.12;
  return new;
end;

$$;
create trigger tx
before insert
on item
for each row
execute procedure tax();
insert into item values (1,'book',100);
select * from item;

--D
create table university (
name varchar,
city varchar,
students int
);
create or replace function prevent()
returns trigger
language plpgsql
as
$$
begin
   insert into university(name,city,students) values (old.name,old.city,old.students);
   return old;
end;

$$;
create trigger t7
after delete
on university
for each row
execute procedure prevent();

insert into university values ('KBTU','Almaty', 1500);
delete from university where name='KBTU';
select * from university;


--  E


 create or replace function  isv()
returns trigger as
    $$
    begin
    if(length(new.pswr)>8 and length(new.pswr)<15 ) then
       new.isval=true;
    else
     new.isval=false;
end if; return new;
    end;
    $$
LANGUAGE 'plpgsql';
CREATE TRIGGER PSW
BEFORE INSERT
ON person88
FOR EACH ROW
EXECUTE FUNCTION isv();


CREATE TABLE person88 (
id int primary key ,
isval bool,
pswr varchar
);
insert into person88(id,pswr) values (1,'AQSsdade');
select * from person88;




create table perso7(
full_name text,
age int,
name varchar,
surname varchar
);
create or replace function oup()
returns trigger as
$$
begin
 new.surname=split_part( new.full_name,' ',1) ;
 new.name=split_part( new.full_name,' ',2) ;
return new;

end;
$$
language 'plpgsql';
create trigger flm
before   insert
on perso7
for each row
execute function   oup();

insert into perso7(full_name,age) values ('Turarbek Kanat',18);
select * from perso7;

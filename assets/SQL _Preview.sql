--CREATE VACATION RENTAL
create table vacation_rental
(vrental_id number(10) constraint holiday_home_pk primary key,
description varchar2(50),
complete_address varchar2(100),
owner_name varchar(50) not null,
owner_email varchar2(100) not null,
owner_phone char(10) not null,
other_details varchar2(100));

--CREATE AMENITIES 
create table vrental_amenity
(
    amenity_code char (5 byte),
    VRENTAL_ID number(10) ,
    other_details varchar2(100),
    constraint property_amenity_PK primary key (vrental_id, amenity_code),
    constraint fk_property_amenity_to_amenity foreign key(amenity_code)
    REFERENCES amenity (amenity_code),
    constraint fk_property_amenity_to_vrental foreign key(vrental_id)
    REFERENCES vacation_rental (vrental_id)
);

--CREATE AMENITY
create table amenity
(
    amenity_code char (5) constraint amenity_pk primary key,
    amenity_description varchar2 (100) not null
)

--CREATE PROPERTY
create table property
(
property_id number (5)not null,
property_unit_number char(8)not null,
property_type varchar2( 50)not null,
bathroom_count number (2,1)not null,
bedroom_count number (2)not null,
room_count number (3,1)not null,
sleeps_how_many number (3)not null,
other_details varchar2(100),
constraint property_pk primary key (property_id, property_unit_number),
constraint fk_property_to_vrental foreign key (property_id)
REFERENCES vacation_rental (vrental_id)
);
commit;


--CREATE PROPERTY_STATUS
create table property_status
(
property_id number (10)not null,
property_unit_number char(8)not null,
status_date date not null,
booking_id number (10),
available char (1)not null,
constraint property_status_pk primary key 
(property_id,property_unit_number, status_date),
constraint fk_property_status_to_booking FOREIGN KEY (booking_id)
REFERENCES booking (booking_id),
constraint fk_property_status_to_property FOREIGN KEY (property_id,property_unit_number)
REFERENCES property (property_id, property_unit_number)
);
commit;

--CREATE BOOKING
create table booking
(
booking_id number(10) not null,
property_id number (10) not null,
property_unit_number char (8) not null,
guest_id number (10) not null,
booking_status varchar2(25) not null,
booking_status_change_date date not null,
booking_start date not null,
booking_end date not null,
other_details varchar2(100),
constraint booking_pk primary key(booking_id),
constraint fk_booking_to_guest foreign key (guest_id)
REFERENCES guest (guest_id),
constraint fk_booking_to_property foreign key (property_id, property_unit_number)
REFERENCES property (property_id, property_unit_number)
);

--CREATE GUEST
create table guest
(
guest_id number (10) not null,
guest_first_name varchar2 (50),
guest_last_name varchar2 (50) not null,
DOB date not null,
drivers_license_state char (2) not null,
drivers_license_no varchar2(15) not null,
other_details varchar2 (100),
constraint guest_pk primary key (guest_id)
);






--INSERT VACATION_RENTAL
insert into vacation_rental values (1,'Lakeside View Villa','12342 jingle St', 
'yu-Hen Hsiao','yo@yahoo.com','1231231234','cheap discount come now!');
insert into vacation_rental values(2,'Six Senses Resort','forest Dr', 
'Jennifer Toms','jToms@yahoo.com','8675648675','50% discount until 2021!');
insert into vacation_rental values (3, 'Robert''s Resort',
'12 MICHIGAN AVENUE, Sunnyside, CA 20134','Robert Roberts',
'rroberts@developCA.com','1234354567',null);


--INSERT amenity
insert into amenity values (1, 'pool');
insert into amenity values (2, 'tennis court');
commit;

--INSERT vrental_amenity
insert into vrental_amenity values (1, 2, 'yo');
commit;

--insert guest
insert into guest values (1, 'Ryan', 'Hsiao', '04-FEB-1999', 'MT', '1282LIC', 'very good guest');
insert into guest values (2, 'Veronica', 'O''brien', '05-March-1999', 'TX', '1222LIC', 'very good guest');
insert into guest values (3, 'Jack', 'Jones', '05-March-2005', 'MT', '62321', 'very bad guest');
insert into guest values (4, 'Jennifer', 'Silp', '05-Jan-1999', 'TX', '7332', 'very good guest');
commit;

--insert property 
insert into property values 
(2,'102','resort', 3,3,4,3,null );

 
--insert booking
insert into booking values
(1, 2, '102', 1, 'Confirmed', '12-Dec-2020', '12-Feb-2021', '15-Feb-2021',null );

--insert property_status






--show data from booking and property
select b.booking_id, b.guest_id, b.booking_start, p.property_id, vr.description
FROM booking b JOIN property p
ON b.property_id = p.property_id
JOIN vacation_rental vr
ON p.property_id = vr.vrental_id;


--show data from property and vacation_rental
select property_id, vrental_id, vr.description, p.property_unit_number, p.property_type
from property p join vacation_rental vr
on p.property_id = vr.vrental_id;


--show data from vacation_rental and amenity description
select vr.owner_name, vr.complete_address, a.amenity_description
FROM vacation_rental vr JOIN vrental_amenity va
ON vr.vrental_id = va.vrental_id
JOIN amenity a
ON va.amenity_code = a.amenity_code;


--;)
select guest_last_name, drivers_license_state
FROM guest 
WHERE drivers_license_state like '%MT%'
UNION
select guest_last_name, 'outside MT' AS drivers_license_state
FROM guest 
WHERE drivers_license_state not like '%MT%'
order by drivers_license_state asc, guest_last_name asc;





--constraint
alter table guest
add
(constraint ageverif
check( current_date - dob > 18));


select * from amenity;
select * from booking;
select * from guest;
select * from property;
select * from property_status;
select * from vacation_rental;
select * from vrental_amenity;



create index jack
ON guest (owner_name, owner_name);


SELECT ?p.property_id, p.property_unit_number, b.booking_start, b.booking_end

from property p JOIN booking b

ON ??????p.property_id = b.property_ID??

WHERE ?b.booking_start between TO_DATE ('12-FEB-2021' , 'dd-mm-yyyy')

AND TO_DATE ('23-APR-2021' ,'dd-mm-yyyy????');

SELECT ?p.property_id, p.property_unit_number, b.booking_start, b.booking_end, numdays (b.booking_end - b.booking_start) as days
from property p JOIN booking b

ON ??????p.property_id = b.property_ID??

WHERE ?b.booking_start between TO_DATE ('12-FEB-2021' , 'dd-mm-yyyy')

AND TO_DATE ('23-APR-2021' ,'dd-mm-yyyy????');

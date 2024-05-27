-- database m2_final_project
BEGIN TRANSACTION;

-- *************************************************************************************************
-- Drop all db objects in the proper order
-- *************************************************************************************************
DROP TABLE IF EXISTS users, shards, orders, characters, location, orders_characters CASCADE;

-- *************************************************************************************************
-- Create the tables and constraints
-- *************************************************************************************************

--users (name is pluralized because 'user' is a SQL keyword)
CREATE TABLE users (
	user_id SERIAL,
	username varchar(50) NOT NULL UNIQUE,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	name varchar(50) NOT NULL,
	address varchar(100) NULL,
	city varchar(50) NULL,
	state_code char(2) NULL,
	zip varchar(5) NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

create table location (
	location_id INT PRIMARY KEY,
	name VARCHAR(10) NOT NULL,
	population INT NOT NULL
);

create table characters (
	character_id SERIAL PRIMARY KEY,
	name VARCHAR(60) NOT NULL,
	gender VARCHAR(60) NOT NULL,
	nationality VARCHAR(60) NOT NULL,
	location_id int REFERENCES location(location_id),
	user_id int REFERENCES users(user_id) NULL
);

create table shards (
	shardblade_id SERIAL PRIMARY KEY,
	shardblade_name VARCHAR(20) UNIQUE,
	shardblade_type VARCHAR(30) NOT NULL,
	character_id int REFERENCES characters(character_id),
	user_id int REFERENCES users(user_id) NULL
);

create table orders (
	order_id INT PRIMARY KEY,
	order_name VARCHAR(20) UNIQUE
);

CREATE TABLE orders_characters(
	order_id int REFERENCES orders(order_id),
	character_id int REFERENCES characters(character_id),
	ideal INT DEFAULT(1) NOT NULL,
	PRIMARY KEY (order_id, character_id)
);

-- *************************************************************************************************
-- Insert some sample starting data
-- *************************************************************************************************

-- Users
-- Password for all users is password
INSERT INTO users (username, password_hash, role, name, address, city, state_code, zip) VALUES
    ('user', '$2a$10$tmxuYYg1f5T0eXsTPlq/V.DJUKmRHyFbJ.o.liI1T35TFbjs2xiem','ROLE_USER',  'Jack O''Lantern', null, 'Cleveland', 'OH', '44123'),
    ('admin','$2a$10$tmxuYYg1f5T0eXsTPlq/V.DJUKmRHyFbJ.o.liI1T35TFbjs2xiem','ROLE_ADMIN', 'Jill O''Lantern', null, 'Beverly Hills', 'CA', '90210');

insert into location (location_id, name, population)
values (1, 'Thaylenah', 51378),
(2, 'Alethkar', 78104),
(3, 'Herdaz', 33787),
(4, 'Jah Keved', 86287),
(5, 'Tukar', 57314),
(6, 'Yezier', 78006),
(7, 'Aimia', 25079),
(8, 'Shinovar', 79684),
(9, 'Kharbranth', 94311);

insert into characters (name, gender, nationality, location_id)
values ('Clerkclaude Barnfield', 'Male', 'Tukar', 1),
('Uta Sloam', 'Female', 'Azir', 1),
('Paulina Noir', 'Female', 'Tukar', 2),
('Lockwood Hargitt', 'Male', 'Shinovar', 9),
('Danya Skrines', 'Male', 'Herdaz', 8),
('Davis Dahmke', 'Male', 'Herdaz', 9),
('Fransisco Irvine', 'Male', 'Azir', 5),
('Shayna Arguile', 'Female', 'Tukar', 4),
('Alisander Bentote', 'Male', 'Jah Keved', 3),
('Hillie Gilhouley', 'Male', 'Thaylen', 3),
('Zia Lowman', 'Genderfluid', 'Herdaz', 3),
('Rodolph Dyball', 'Male', 'Azir', 2),
('Lawry Beer', 'Male', 'Azir', 2),
('Wendye Harpin', 'Female', 'Tukar', 7),
('Ardelia Bellham', 'Polygender', 'Alethkar', 1),
('Bing McKellar', 'Male', 'Azir', 8),
('Nan Eagleston', 'Female', 'Kharbranth', 6),
('Alister Sweeny', 'Male', 'Shinovar', 4),
('Cherlyn Izsak', 'Female', 'Alethkar', 5),
('Filmer Asser', 'Male', 'Shinovar', 3),
('Norry Rutter', 'Female', 'Alethkar', 4),
('Mozelle Quaife', 'Female', 'Kharbranth', 2),
('Freddie Chasmer', 'Male', 'Thaylen', 3),
('Baillie Musterd', 'Male', 'Jah Keved', 4),
('Vincenz Abbott', 'Male', 'Tukar', 2);

insert into shards (shardblade_name, shardblade_type, character_id)
values ('Thunderclash', 'Dead Shardblade', 1),
('Starshard', 'Shardplate', 1),
('Ironfang', 'Honorblade', 3),
('Shadowstrike', 'Dead Shardblade', 4),
('Whisperblade', 'Dead Shardblade', 5),
('Flamespike', 'Living Shardblade', 5),
('Oathbringer', 'Shardplate', 6),
('Deepcutter', 'Honorblade', 7),
('Mercysong', 'Living Shardblade', 8),
('Frostcleaver', 'Shardplate',9 ),
('Dawnslayer', 'Honorblade', 9),
('Moonrend', 'Dead Shardblade', 10),
('Night''s Edge', 'Dead Shardblade', 11),
('Windreaver', 'Dead Shardblade', 12),
('Sunmaker', 'Living Shardblade', 13),
('Stormbringer', 'Living Shardblade', 14),
('Lightshard', 'Honorblade', 14),
('Nightblood', 'Shardplate', 15),
('Widowmaker', 'Shardplate', 14),
('Emberblade', 'Shardplate',25),
('Puzzlemaker', 'Living Shardblade', 25),
('Lightsong', 'Dead Shardblade',24),
('Duskbringer', 'Honorblade', 23),
('Soulshaper', 'Dead Shardblade', 22),
('Warbreaker', 'Honorblade', 20);


insert into orders (order_id, order_name)
values (1, 'Bondsmiths'),
(2, 'Dustbringers'),
(3, 'Truthwatchers'),
(4, 'Windrunners'),
(5, 'Stonewards'),
(6, 'Edgedancers'),
(7, 'Willshapers'),
(8, 'Skybreakers'),
(9, 'Elsecallers'),
(10, 'Lightweavers');


insert into orders_characters(order_id, character_id, ideal)
values (1, 1, 1),
(3, 2, 3),
(2, 3, 2),
(4, 4, 3),
(3, 5, 4),
(5, 6, 1),
(4, 7, 1),
(6, 8, 2),
(5, 9, 3),
(7, 10, 4),
(6, 11, 1),
(8, 12, 2),
(7, 13, 3),
(8, 14, 4),
(9, 15, 3),
(8, 16, 1),
(10, 17, 3),
(9, 18, 2),
(1, 19, 3),
(10, 20, 2),
(2, 21, 2),
(1, 22, 1),
(3, 23, 1),
(2, 24, 1),
(4, 25, 3);


COMMIT TRANSACTION;

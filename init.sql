--- Data Schema ---
CREATE SCHEMA IF NOT EXISTS "data"
AUTHORIZATION postgres;

--- Users ---
CREATE SEQUENCE thegame.data.seq_user
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE thegame.data.users (
    user_id int NOT NULL,
    first_name varchar(255) NOT NULL,
    last_name varchar(255) NOT NULL,
    PRIMARY KEY (user_id)
);

INSERT INTO thegame.data.users (user_id, first_name, last_name)
VALUES
	(nextval('thegame.data.seq_user'), 'Thomas', 'Dröge'),
	(nextval('thegame.data.seq_user'), 'Martin', 'Schreiber'),
	(nextval('thegame.data.seq_user'), 'Max', 'Mustermann'),
	(nextval('thegame.data.seq_user'), 'Phillip', 'Knight'),
	(nextval('thegame.data.seq_user'), 'David', 'Heuckmann'),
	(nextval('thegame.data.seq_user'), 'Robin', 'Kötter');


--- Villages ---
CREATE SEQUENCE thegame.data.seq_village
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE thegame.data.villages (
	village_id int NOT NULL,
	x_coords int NOT NULL,
	y_coords int NOT NULL,
	primary key (village_id),
	user_id int references thegame.data.users
);

INSERT INTO thegame.data.villages
VALUES
	(nextval('thegame.data.seq_village'), 1, 1, 1),
	(nextval('thegame.data.seq_village'), 5, 10, 2);


--- ResourceTypes ---
CREATE TABLE thegame.data.resource_types (
	resource_type_id int NOT NULL,
	resource_name varchar(255) NOT NULL,
	primary key (resource_type_id)
);

INSERT INTO thegame.data.resource_types
VALUES
	(1, 'Food'),
	(2, 'Wood'),
	(3, 'Stone'),
	(4, 'Iron');


--- Resources ---
CREATE SEQUENCE thegame.data.seq_resource
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE thegame.data.resources (
	resource_id int NOT NULL,
	village_id int references thegame.data.villages,
	resource_type_id int references thegame.data.resource_types,
	resource_at_update_time int NOT NULL,
	resource_income int NOT NULL,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	primary key (resource_id)
);

INSERT INTO thegame.data.resources
VALUES
	(nextval('thegame.data.seq_resource'), 1, 1, 1000, 1000),
	(nextval('thegame.data.seq_resource'), 1, 2, 400, 1250),
	(nextval('thegame.data.seq_resource'), 1, 3, 200, 250),
	(nextval('thegame.data.seq_resource'), 1, 4, 50, 0),
	(nextval('thegame.data.seq_resource'), 2, 1, 1000, 100),
	(nextval('thegame.data.seq_resource'), 2, 2, 400, 100),
	(nextval('thegame.data.seq_resource'), 2, 3, 200, 25),
	(nextval('thegame.data.seq_resource'), 2, 4, 50, 0);


--- Building Types ---
CREATE TABLE thegame.data.building_types (
	building_type_id int NOT NULL,
	building_name varchar(255) NOT NULL,
	primary key (building_type_id)
);

INSERT INTO thegame.data.building_types
VALUES
	(1, 'City Hall'),
	(2, 'Mill'),
	(3, 'Lumberjack'),
	(4, 'Mason'),
	(5, 'Iron Mine');


--- Buildings ---
CREATE SEQUENCE thegame.data.seq_building
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE thegame.data.buildings (
	building_id int NOT NULL,
	village_id int references thegame.data.villages,
	building_type_id int references thegame.data.building_types,
	building_level int NOT NULL,
	primary key (building_id)
);

INSERT INTO thegame.data.buildings
VALUES
	(nextval('thegame.data.seq_building'), 1, 1, 1),
	(nextval('thegame.data.seq_building'), 1, 2, 1),
	(nextval('thegame.data.seq_building'), 1, 3, 1),
	(nextval('thegame.data.seq_building'), 1, 4, 1),
	(nextval('thegame.data.seq_building'), 1, 5, 0),
	(nextval('thegame.data.seq_building'), 2, 1, 1),
	(nextval('thegame.data.seq_building'), 2, 2, 1),
	(nextval('thegame.data.seq_building'), 2, 3, 1),
	(nextval('thegame.data.seq_building'), 2, 4, 1),
	(nextval('thegame.data.seq_building'), 2, 5, 0);

--- BuildingLevelEffect ---
CREATE TABLE thegame.data.seq_building_level_effect (
    building_level_effect_id int NOT NULL,
    building_level_effect_name varchar(255) NOT NULL,
    primary key (building_level_effect_id)
);

INSERT INTO thegame.data.building_level_effect
VALUES
    (1, 'buildingTimeModifier'),
    (2, 'Food'),
    (3, 'Wood'),
    (4, 'Stone'),
    (5, 'Iron');


--- BuildingLevel ---
CREATE SEQUENCE thegame.data.seq_building_level
    START WITH 1
    INCREMENT BY 1;

CREATE TABLE thegame.data.seq_building_level (
    building_level_id int NOT NULL,
    building_level int NOT NULL,
    building_level_value int NOT NULL,
    building_time int NOT NULL,
    update_cost_stone int NOT NULL,
    update_cost_wood int NOT NULL,
    building_level_effect_id int references thegame.data.seq_building_level_effect,
    building_type_id int references thegame.data.building_types,
    primary key (building_level_id)
);

-- Cityhall --
INSERT INTO thegame.data.building_level
VALUES
    (nextval('thegame.data.seq_building_level'), 1, 100, 10, 10, 10, 1, 1),
    (nextval('thegame.data.seq_building_level'), 2, 96, 20, 20, 20, 1, 1),
    (nextval('thegame.data.seq_building_level'), 3, 92, 30, 30, 30, 1, 1),
    (nextval('thegame.data.seq_building_level'), 4, 88, 40, 40, 40, 1, 1),
    (nextval('thegame.data.seq_building_level'), 5, 84, 50, 50, 50, 1, 1),
    (nextval('thegame.data.seq_building_level'), 6, 80, 60, 60, 60, 1, 1),
    (nextval('thegame.data.seq_building_level'), 7, 76, 70, 70, 70, 1, 1),
    (nextval('thegame.data.seq_building_level'), 8, 72, 80, 80, 80, 1, 1),
    (nextval('thegame.data.seq_building_level'), 9, 68, 90, 90, 90, 1, 1),
    (nextval('thegame.data.seq_building_level'), 10, 64, 100, 100, 100, 1, 1),
    (nextval('thegame.data.seq_building_level'), 11, 60, 110, 110, 110, 1, 1),
    (nextval('thegame.data.seq_building_level'), 12, 56, 120, 120, 120, 1, 1),
    (nextval('thegame.data.seq_building_level'), 13, 52, 130, 130, 130, 1, 1),
    (nextval('thegame.data.seq_building_level'), 14, 48, 140, 140, 140, 1, 1),
    (nextval('thegame.data.seq_building_level'), 15, 44, 150, 150, 150, 1, 1),
    (nextval('thegame.data.seq_building_level'), 16, 40, 160, 160, 160, 1, 1),
    (nextval('thegame.data.seq_building_level'), 17, 38, 170, 170, 170, 1, 1),
    (nextval('thegame.data.seq_building_level'), 18, 34, 180, 180, 180, 1, 1),
    (nextval('thegame.data.seq_building_level'), 19, 30, 190, 190, 190, 1, 1),
    (nextval('thegame.data.seq_building_level'), 20, 28, 200, 200, 200, 1, 1);

-- Mill --
INSERT INTO thegame.data.building_level
VALUES
    (nextval('thegame.data.seq_building_level'), 1, 30, 10, 10, 10, 2, 2),
    (nextval('thegame.data.seq_building_level'), 2, 40, 20, 20, 20, 2, 2),
    (nextval('thegame.data.seq_building_level'), 3, 50, 30, 30, 30, 2, 2),
    (nextval('thegame.data.seq_building_level'), 4, 60, 40, 40, 40, 2, 2),
    (nextval('thegame.data.seq_building_level'), 5, 70, 50, 50, 50, 2, 2),
    (nextval('thegame.data.seq_building_level'), 6, 80, 60, 60, 60, 2, 2),
    (nextval('thegame.data.seq_building_level'), 7, 90, 70, 70, 70, 2, 2),
    (nextval('thegame.data.seq_building_level'), 8, 100, 80, 80, 80, 2, 2),
    (nextval('thegame.data.seq_building_level'), 9, 110, 90, 90, 90, 2, 2),
    (nextval('thegame.data.seq_building_level'), 10, 120, 100, 100, 100, 2, 2),
    (nextval('thegame.data.seq_building_level'), 11, 130, 110, 110, 110, 2, 2),
    (nextval('thegame.data.seq_building_level'), 12, 140, 120, 120, 120, 2, 2),
    (nextval('thegame.data.seq_building_level'), 13, 150, 130, 130, 130, 2, 2),
    (nextval('thegame.data.seq_building_level'), 14, 160, 140, 140, 140, 2, 2),
    (nextval('thegame.data.seq_building_level'), 15, 170, 150, 150, 150, 2, 2),
    (nextval('thegame.data.seq_building_level'), 16, 180, 160, 160, 160, 2, 2),
    (nextval('thegame.data.seq_building_level'), 17, 190, 170, 170, 170, 2, 2),
    (nextval('thegame.data.seq_building_level'), 18, 200, 180, 180, 180, 2, 2),
    (nextval('thegame.data.seq_building_level'), 19, 210, 190, 190, 190, 2, 2),
    (nextval('thegame.data.seq_building_level'), 20, 220, 200, 200, 200, 2, 2);

-- Lumberjack --
INSERT INTO thegame.data.building_level
VALUES
    (nextval('thegame.data.seq_building_level'), 1, 30, 10, 10, 10, 3, 3),
    (nextval('thegame.data.seq_building_level'), 2, 40, 20, 20, 20, 3, 3),
    (nextval('thegame.data.seq_building_level'), 3, 50, 30, 30, 30, 3, 3),
    (nextval('thegame.data.seq_building_level'), 4, 60, 40, 40, 40, 3, 3),
    (nextval('thegame.data.seq_building_level'), 5, 70, 50, 50, 50, 3, 3),
    (nextval('thegame.data.seq_building_level'), 6, 80, 60, 60, 60, 3, 3),
    (nextval('thegame.data.seq_building_level'), 7, 90, 70, 70, 70, 3, 3),
    (nextval('thegame.data.seq_building_level'), 8, 100, 80, 80, 80, 3, 3),
    (nextval('thegame.data.seq_building_level'), 9, 110, 90, 90, 90, 3, 3),
    (nextval('thegame.data.seq_building_level'), 10, 120, 100, 100, 100, 3, 3),
    (nextval('thegame.data.seq_building_level'), 11, 130, 110, 110, 110, 3, 3),
    (nextval('thegame.data.seq_building_level'), 12, 140, 120, 120, 120, 3, 3),
    (nextval('thegame.data.seq_building_level'), 13, 150, 130, 130, 130, 3, 3),
    (nextval('thegame.data.seq_building_level'), 14, 160, 140, 140, 140, 3, 3),
    (nextval('thegame.data.seq_building_level'), 15, 170, 150, 150, 150, 3, 3),
    (nextval('thegame.data.seq_building_level'), 16, 180, 160, 160, 160, 3, 3),
    (nextval('thegame.data.seq_building_level'), 17, 190, 170, 170, 170, 3, 3),
    (nextval('thegame.data.seq_building_level'), 18, 200, 180, 180, 180, 3, 3),
    (nextval('thegame.data.seq_building_level'), 19, 210, 190, 190, 190, 3, 3),
    (nextval('thegame.data.seq_building_level'), 20, 220, 200, 200, 200, 3, 3);

-- Mason --
INSERT INTO thegame.data.building_level
VALUES
    (nextval('thegame.data.seq_building_level'), 1, 30, 10, 10, 10, 4, 4),
    (nextval('thegame.data.seq_building_level'), 2, 40, 20, 20, 20, 4, 4),
    (nextval('thegame.data.seq_building_level'), 3, 50, 30, 30, 30, 4, 4),
    (nextval('thegame.data.seq_building_level'), 4, 60, 40, 40, 40, 4, 4),
    (nextval('thegame.data.seq_building_level'), 5, 70, 50, 50, 50, 4, 4),
    (nextval('thegame.data.seq_building_level'), 6, 80, 60, 60, 60, 4, 4),
    (nextval('thegame.data.seq_building_level'), 7, 90, 70, 70, 70, 4, 4),
    (nextval('thegame.data.seq_building_level'), 8, 100, 80, 80, 80, 4, 4),
    (nextval('thegame.data.seq_building_level'), 9, 110, 90, 90, 90, 4, 4),
    (nextval('thegame.data.seq_building_level'), 10, 120, 100, 100, 100, 4, 4),
    (nextval('thegame.data.seq_building_level'), 11, 130, 110, 110, 110, 4, 4),
    (nextval('thegame.data.seq_building_level'), 12, 140, 120, 120, 120, 4, 4),
    (nextval('thegame.data.seq_building_level'), 13, 150, 130, 130, 130, 4, 4),
    (nextval('thegame.data.seq_building_level'), 14, 160, 140, 140, 140, 4, 4),
    (nextval('thegame.data.seq_building_level'), 15, 170, 150, 150, 150, 4, 4),
    (nextval('thegame.data.seq_building_level'), 16, 180, 160, 160, 160, 4, 4),
    (nextval('thegame.data.seq_building_level'), 17, 190, 170, 170, 170, 4, 4),
    (nextval('thegame.data.seq_building_level'), 19, 210, 190, 190, 190, 4, 4),
    (nextval('thegame.data.seq_building_level'), 20, 220, 200, 200, 200, 4, 4);

-- Iron Mine --
INSERT INTO thegame.data.building_level
VALUES
    (nextval('thegame.data.seq_building_level'), 1, 30, 10, 10, 10, 5, 5),
    (nextval('thegame.data.seq_building_level'), 2, 40, 20, 20, 20, 5, 5),
    (nextval('thegame.data.seq_building_level'), 3, 50, 30, 30, 30, 5, 5),
    (nextval('thegame.data.seq_building_level'), 4, 60, 40, 40, 40, 5, 5),
    (nextval('thegame.data.seq_building_level'), 5, 70, 50, 50, 50, 5, 5),
    (nextval('thegame.data.seq_building_level'), 6, 80, 60, 60, 60, 5, 5),
    (nextval('thegame.data.seq_building_level'), 7, 90, 70, 70, 70, 5, 5),
    (nextval('thegame.data.seq_building_level'), 8, 100, 80, 80, 80, 5, 5),
    (nextval('thegame.data.seq_building_level'), 9, 110, 90, 90, 90, 5, 5),
    (nextval('thegame.data.seq_building_level'), 10, 120, 100, 100, 100, 5, 5),
    (nextval('thegame.data.seq_building_level'), 11, 130, 110, 110, 110, 5, 5),
    (nextval('thegame.data.seq_building_level'), 12, 140, 120, 120, 120, 5, 5),
    (nextval('thegame.data.seq_building_level'), 13, 150, 130, 130, 130, 5, 5),
    (nextval('thegame.data.seq_building_level'), 14, 160, 140, 140, 140, 5, 5),
    (nextval('thegame.data.seq_building_level'), 15, 170, 150, 150, 150, 5, 5),
    (nextval('thegame.data.seq_building_level'), 16, 180, 160, 160, 160, 5, 5),
    (nextval('thegame.data.seq_building_level'), 17, 190, 170, 170, 170, 5, 5),
    (nextval('thegame.data.seq_building_level'), 18, 200, 180, 180, 180, 5, 5),
    (nextval('thegame.data.seq_building_level'), 19, 210, 190, 190, 190, 5, 5),
    (nextval('thegame.data.seq_building_level'), 20, 220, 200, 200, 200, 5, 5);



--- Timer Types ---
CREATE TABLE thegame.data.timer_types (
	timer_type_id int NOT NULL,
	timer_name varchar(255) NOT NULL,
	primary key (timer_type_id)
);

INSERT INTO thegame.data.timer_types
VALUES
	(1, 'building'),
	(2, 'unit');


--- Timer ---
CREATE SEQUENCE thegame.data.seq_timer
	START WITH 1
	INCREMENT BY 1;

CREATE TABLE thegame.data.timer (
	timer_id int NOT NULL,
	village_id int references thegame.data.villages,
	timer_type_id int references thegame.data.timer_types,
	object_type_id int NOT NULL,
	update_time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	primary key (timer_id)
);

INSERT INTO thegame.data.timer
VALUES
	(nextval('thegame.data.seq_timer'), 1, 1, 1),
	(nextval('thegame.data.seq_timer'), 2, 1, 1);
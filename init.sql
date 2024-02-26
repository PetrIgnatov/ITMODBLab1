BEGIN;

-- dropping tables
DROP TABLE IF EXISTS spaceship CASCADE;
DROP TABLE IF EXISTS route CASCADE;
DROP TABLE IF EXISTS routereef CASCADE;
DROP TABLE IF EXISTS routeshallow CASCADE;
DROP TABLE IF EXISTS reef CASCADE;
DROP TABLE IF EXISTS shallow CASCADE;
DROP TABLE IF EXISTS place CASCADE;
DROP TABLE IF EXISTS planet CASCADE;
DROP TABLE IF EXISTS species CASCADE;
DROP TABLE IF EXISTS controller CASCADE;

-- creating tables
CREATE TABLE IF NOT EXISTS place(
	id SERIAL PRIMARY KEY,
	coordinates POINT NOT NULL,
	galaxy TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS shallow(
	id SERIAL PRIMARY KEY,
	placeid INTEGER REFERENCES place(id) NOT NULL,
	complexity INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS reef(
	id SERIAL PRIMARY KEY,
	placeid INTEGER REFERENCES place(id) NOT NULL,
	complexity INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS planet(
	id SERIAL PRIMARY KEY,
	placeid INTEGER REFERENCES place(id) NOT NULL,
	name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS route(
	id SERIAL PRIMARY KEY,
	destination INTEGER REFERENCES planet(id) NOT NULL
);
CREATE TABLE IF NOT EXISTS routeshallow(
	shallowid INTEGER REFERENCES shallow(id),
	routeid INTEGER REFERENCES route(id) NOT NULL,
	PRIMARY KEY (shallowid, routeid)
);
CREATE TABLE IF NOT EXISTS routereef(
	reefid INTEGER REFERENCES reef(id) NOT NULL,
	routeid INTEGER REFERENCES route(id) NOT NULL
);
CREATE TABLE IF NOT EXISTS species(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	planetid INTEGER REFERENCES planet(id) NOT NULL
);
CREATE TABLE IF NOT EXISTS controller(
	id SERIAL PRIMARY KEY,
	name TEXT NOT NULL,
	speciesid INTEGER REFERENCES species(id) NOT NULL
);
CREATE TABLE IF NOT EXISTS spaceship(
	id SERIAL PRIMARY KEY,
	routeid INTEGER REFERENCES route(id) NOT NULL,
	name TEXT NOT NULL,
	controllerid INTEGER REFERENCES controller(id),
	creatorsid INTEGER REFERENCES species(id) NOT NULL
);

INSERT INTO place(coordinates, galaxy)
VALUES
	(POINT(1782, 234), 'Milky Way'),
	(POINT(1272, 953), 'Milky Way'),
	(POINT(-143, 352), 'Milky Way'),
	(POINT(52, 248), 'Milky Way'),
	(POINT(2194, 192), 'Milky Way'),
	(POINT(-125, 532), 'Milky Way');

INSERT INTO shallow(placeid, complexity)
VALUES
	(1,425);

INSERT INTO reef(placeid, complexity)
VALUES
	(2, 382);

INSERT INTO planet(placeid, name)
VALUES
	(3, 'Jupiter'),
	(4, 'Mars'),
	(5, 'Neptune'),
	(6, 'Earth');

INSERT INTO route(destination)
VALUES
	(3);

INSERT INTO species(name, planetid)
VALUES
	('Humans', 4);

INSERT INTO spaceship(routeid, name, controllerid, creatorsid)
VALUES
	(1, 'Discovery', NULL, 1);

COMMIT;

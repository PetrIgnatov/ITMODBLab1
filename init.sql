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
DROP TABLE IF EXISTS menace CASCADE;
DROP TABLE IF EXISTS pathmenace CASCADE;
DROP TYPE IF EXISTS menaces CASCADE;

CREATE TYPE menaces AS ENUM ('BLACK_HOLE','REEF','SHALLOW');

-- creating tables
CREATE TABLE IF NOT EXISTS place(
	id SERIAL PRIMARY KEY,
	x INTEGER NOT NULL,
	y INTEGER NOT NULL,
	z INTEGER NOT NULL,
	galaxy TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS menace(
	id SERIAL PRIMARY KEY,
	placeid INTEGER REFERENCES place(id) NOT NULL,
	complexity INTEGER NOT NULL,
	menacetype menaces NOT NULL
);
CREATE TABLE IF NOT EXISTS planet(
	id SERIAL PRIMARY KEY,
	placeid INTEGER REFERENCES place(id) NOT NULL,
	name TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS route(
	id SERIAL PRIMARY KEY,
	startid INTEGER REFERENCES planet(id),
	endid INTEGER REFERENCES planet(id) NOT NULL,
	complexity INTEGER NOT NULL
);
CREATE TABLE IF NOT EXISTS routemenace(
	menaceid INTEGER REFERENCES menace(id),
	routeid INTEGER REFERENCES route(id) NOT NULL,
	PRIMARY KEY (menaceid, routeid)
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

INSERT INTO place(x, y, z, galaxy)
VALUES
	(1782, 234, 100, 'Milky Way'),
	(1272, 953, 126, 'Milky Way'),
	(-143, 352, 52, 'Milky Way'),
	(52, 248, 72, 'Milky Way'),
	(2194, 192, 83, 'Milky Way'),
	(-125, 532, 193, 'Milky Way');

INSERT INTO menace(placeid, complexity, menacetype)
VALUES
	(1, 425, 'REEF'),
	(2, 382, 'SHALLOW');

INSERT INTO planet(placeid, name)
VALUES
	(3, 'Jupiter'),
	(4, 'Mars'),
	(5, 'Neptune'),
	(6, 'Earth');

INSERT INTO route(startid, endid, complexity)
VALUES
	(NULL, 3, 173);

INSERT INTO species(name, planetid)
VALUES
	('Humans', 4);

INSERT INTO spaceship(routeid, name, controllerid, creatorsid)
VALUES
	(1, 'Discovery', NULL, 1);

COMMIT;

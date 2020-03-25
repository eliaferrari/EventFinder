CREATE TABLE public.category(catname VARCHAR(25) PRIMARY KEY);
CREATE TABLE public.subcategory(subcatname VARCHAR(25) PRIMARY KEY);
CREATE TABLE public.events(id SERIAL PRIMARY KEY,
						   name VARCHAR(128) NOT NULL,
						   ort VARCHAR(50) DEFAULT 'Zuerich',
						   plz smallint DEFAULT 8001,
						   datum TIMESTAMP, --format: YYYY-MM-DD HH:MI:SS
						   beschreibung text,
						   website VARCHAR(200),
						   ticket VARCHAR(200),
						   teilnehmer int,
						   geom GEOMETRY(Point, 2056) NOT NULL,
						   catname VARCHAR(25),
						   subcatname VARCHAR(25),
						   CONSTRAINT catname FOREIGN KEY (catname)
						   REFERENCES public.category(catname),
						   CONSTRAINT subcatname FOREIGN KEY (subcatname)
						   REFERENCES public.subcategory(subcatname));
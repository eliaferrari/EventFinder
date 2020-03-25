CREATE TABLE public.punkte ( 
  id SERIAL PRIMARY KEY, -- SERIAL = AUTO_INCREMENT
  name VARCHAR(128),
  geom GEOMETRY(Point, 2056) -- EPSG = 2056 > LV95
);

INSERT INTO public.punkte (name, geom) 
VALUES ('Bern', ST_GeomFromText('POINT(2600000 1200000)', 2056));

INSERT INTO public.punkte (name, geom) 
VALUES ('Zurich', ST_GeomFromText('POINT(2682500 1248000)', 2056));

INSERT INTO public.punkte (name, geom) 
VALUES ('Chur', ST_GeomFromText('POINT(2760050 1190000)', 2056));
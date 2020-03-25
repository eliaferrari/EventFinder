toc.dat                                                                                             0000600 0004000 0002000 00000014102 13636624715 0014452 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP           4    
            x            eventfinder    12.2    12.2     r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false         s           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false         t           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false         u           1262    27160    eventfinder    DATABASE     �   CREATE DATABASE eventfinder WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Switzerland.1252' LC_CTYPE = 'English_Switzerland.1252';
    DROP DATABASE eventfinder;
                postgres    false         v           0    0    DATABASE eventfinder    COMMENT     h   COMMENT ON DATABASE eventfinder IS 'DB for the access with geoserver for the webinterface Eventfinder';
                   postgres    false    3701                     3079    27161    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false         w           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2         �            1259    28259    category    TABLE     M   CREATE TABLE public.category (
    catname character varying(25) NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false         �            1259    28271    events    TABLE     �  CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    ort character varying(50) DEFAULT 'Zuerich'::character varying,
    plz smallint DEFAULT 8001,
    datum timestamp without time zone,
    beschreibung text,
    website character varying(200),
    ticket character varying(200),
    teilnehmer integer,
    geom public.geometry(Point,2056) NOT NULL,
    catname character varying(25),
    subcatname character varying(25)
);
    DROP TABLE public.events;
       public         heap    postgres    false    2    2    2    2    2    2    2    2         �            1259    28269    events_id_seq    SEQUENCE     �   CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.events_id_seq;
       public          postgres    false    211         x           0    0    events_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;
          public          postgres    false    210         �            1259    28264    subcategory    TABLE     S   CREATE TABLE public.subcategory (
    subcatname character varying(25) NOT NULL
);
    DROP TABLE public.subcategory;
       public         heap    postgres    false         �           2604    28274 	   events id    DEFAULT     f   ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);
 8   ALTER TABLE public.events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    211    211         l          0    28259    category 
   TABLE DATA           +   COPY public.category (catname) FROM stdin;
    public          postgres    false    208       3692.dat o          0    28271    events 
   TABLE DATA           �   COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, geom, catname, subcatname) FROM stdin;
    public          postgres    false    211       3695.dat �          0    27466    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    204       3546.dat m          0    28264    subcategory 
   TABLE DATA           1   COPY public.subcategory (subcatname) FROM stdin;
    public          postgres    false    209       3693.dat y           0    0    events_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.events_id_seq', 10, true);
          public          postgres    false    210         �           2606    28263    category category_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (catname);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    208         �           2606    28281    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    211         �           2606    28268    subcategory subcategory_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategory_pkey PRIMARY KEY (subcatname);
 F   ALTER TABLE ONLY public.subcategory DROP CONSTRAINT subcategory_pkey;
       public            postgres    false    209         �           2606    28282    events catname    FK CONSTRAINT     u   ALTER TABLE ONLY public.events
    ADD CONSTRAINT catname FOREIGN KEY (catname) REFERENCES public.category(catname);
 8   ALTER TABLE ONLY public.events DROP CONSTRAINT catname;
       public          postgres    false    3554    211    208         �           2606    28287    events subcatname    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT subcatname FOREIGN KEY (subcatname) REFERENCES public.subcategory(subcatname);
 ;   ALTER TABLE ONLY public.events DROP CONSTRAINT subcatname;
       public          postgres    false    211    3556    209                                                                                                                                                                                                                                                                                                                                                                                                                                                                      3692.dat                                                                                            0000600 0004000 0002000 00000000066 13636624715 0014274 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        konzert
ausstellung
sport
tanz
fest
messe
kultur
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                          3695.dat                                                                                            0000600 0004000 0002000 00000012030 13636624715 0014271 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Street Parade	Seefeldquartier	8008	2020-08-08 13:00:00	Im Sommer dreht Zuerich so richtig auf: Im August lassen elektronische Klaunge die Stadt vibrieren, die Love-Mobiles waulzen sich am Seebecken entlang und Hunderttausende tanzen auf den Strassen Zuerichs. Die Street Parade ist die groesste Techno-Party der Welt und ein unumstrittenes Highlight in Zuerichs Event-Kalender	http://www.streetparade.com/	kostenlos	1	01010000200808000000000080247A4441000000006E023341	fest	\N
2	Zuerich OpenAir	Glattbrugg	8152	2020-08-26 00:00:00	Wauhrend 4 Tagen begeistert es Musikliebhaber mit elektronischen und rockigen Klaungen sowie einem faszinierenden Festivalgelaunde mit diversen Food- und Unterhaltungsstaunden. Nahe dem Flughafen gelegen, ist es das ideale Open Air auch fuer Gauste aus dem Ausland und durch die Nauhe zur Stadt kann das Festival-Erlebnis mit einer ausgiebigen Shopping-Tour durch die Zuercher Innenstadt kombiniert werden	https://zurichopenair.ch/	https://zurichopenair.ch/	1	010100002008080000000000006C7D44410000000021233341	konzert	\N
3	Knabenschiessen	Zuerich	8001	2020-12-09 00:00:00	Knabenschiessen hat wenig mit dem zu tun, was man in erster Linie vermuten koennte. Wauhrend dem «Knabenschiessen»-Wochenende findet eins der groessten Zuercher Volksfeste statt	https://www.knabenschiessen.ch/	kostenlos	1	010100002008080000000000004277444100000000000B3341	fest	\N
4	Zuercher Theater Spektakel	Landiwiese	8038	2020-08-13 00:00:00	Das internationale Theaterfestival Theater Spektakel begeistert seit 40 Jahren grosse und kleine Zuschauer – an schoenster Lage am Zuerichsee. Dann verwandelt sich die Landiwiese bei Wollishofen in eine zauberhafte Kulisse fuer Performance und Theater. Auf mehr als 10 Buehnen zeigen rund 40 internationale Ensembles ihre Werke	https://www.theaterspektakel.ch/	kostenlos	1	01010000200808000000000000EF774441000000008EFF3241	kultur	theater
5	Zurich Film Festival	Zuerich	8001	2020-09-24 11:00:00	Im Oktober 2005 fand es zum ersten Mal statt und hat sich innerhalb weniger Jahre in der internationalen Festivallandschaft etabliert. Das Zurich Film Festival setzt sich zum Ziel, einem grossen Publikum Einblick in das Schaffen junger, aufkommender Filmemacher aus aller Welt zu ermoeglichen und den Austausch zwischen arrivierten Filmschaffenden, jungen Talenten und dem Publikum zu foerdern	https://zff.com/de/home/	http://zff.starticket.ch/	1	010100002008080000000000004277444100000000000B3341	kultur	film
6	slowUp Zuerichsee	Zuerichsee	8001	2020-09-27 10:00:00	Der slowUp Zuerichsee findet auf der knapp 30 km langen Route zwischen Meilen, Rapperswil-Jona und Schmerikon statt. Der slowUp ermoeglicht allen Bewohnerinnen und Bewohnern von Zuerich und den Gemeinden entlang des Sees, aber auch Gausten aus Nah und Fern, den herrlichen Zuerichsee fernab der gewohnten Hektik des alltauglichen Strassenverkehrs zu erleben	https://www.slowup.ch/zuerichsee/de.html	kostenlos	1	010100002008080000000000004277444100000000000B3341	sport	\N
7	Drone Prixe Zuerichsee	Schloss Rapperswil	8640	2020-10-01 00:00:00	Die besten Drohnen-Piloten der Welt steuern am «Drone Prix Zuerichsee» ihre Geraute mit Hoechstgeschwindigkeiten ums Schloss Rapperswil	https://dcl.aero/de/press/region-zuerichsee-wird-austragungsort-des-drone-grand-prix-lake-zurich-2018/	kostenlos	1	01010000200808000000000080E5A2444100000000D4CA3241	sport	drohnensport
8	Food Zurich	Europaallee Zuerich	8004	2020-10-22 00:00:00	Auch 2020 treffen bei FOOD ZURICH wieder traditionelle Schweizer Gerichte auf internationale Trends, etablierte Restaurants auf ueberraschende Kulissen und junge Koeche auf «alte Hasen» der Gastronomie. An zahlreichen Schauplautzen mitten in der Limmatstadt sowie in der Region Zuerich wird wauhrend FOOD ZURICH gekocht, gekostet und geschlemmt	https://www.foodzurich.com/de/	kostenlos	1	010100002008080000000000009B77444100000000700B3341	kultur	food
9	Samichlausschwimmen	Zuerich	8001	2020-06-12 12:00:00	Seit dem Jahr 2000 stuerzen sich jauhrlich rund 300 unerschrockene Schwimmerinnen und Schwimmer in die eiskalte Limmat, um dieser 111 kalte Meter spauter beim Frauenbad Stadthausquai wieder zu entsteigen. Doch was soll das Ganze? Was mit rund 65 Teilnehmenden wohl als Spass unter Freunden begann, hat sich in den letzten Jahren zunehmend zu einem beliebten Sportanlass gemausert. Ausserdem wird seit 2011 jeweils eine gemeinnuetzige Organisation mit den Einnahmen des Anlasses unterstuetzt	https://www.samichlausschwimmen.ch/samichlausschwimmen	Spende	1	010100002008080000000000004277444100000000000B3341	sport	schwimmen
10	Zuercher Silvesterlauf,Limmatquai	Zuerich	8001	2020-10-01 10:00:00	In verschiedenen Kategorien und Laufdistanzen von 1,6 bis 10 Kilometern rennen Gross und Klein oder Jung und Alt durch die festlich beleuchtete Zuercher Innenstadt. Der einmalige Lauf hat sich zum groessten Breitensportanlass im Kanton Zuerich etabliert und die Teilnehmenden werden jedes Jahr von vielen Fans – meist bestehend aus Freunden und Familie – angefeuert	http://silvesterlauf.ch/home	https://www.datasport.com/de/	1	01010000200808000000000000A677444100000000650B3341	sport	marathon
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        3546.dat                                                                                            0000600 0004000 0002000 00000000005 13636624716 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        \.


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           3693.dat                                                                                            0000600 0004000 0002000 00000000234 13636624716 0014273 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        rock
jazz
classic
blues
runninng
sci
skating
dart
bierpong
tango
salsa
lindy
ballet
kunst
fotografie
theater
film
drohnensport
food
schwimmen
marathon
\.


                                                                                                                                                                                                                                                                                                                                                                    restore.sql                                                                                         0000600 0004000 0002000 00000012752 13636624716 0015411 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE eventfinder;
--
-- Name: eventfinder; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE eventfinder WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Switzerland.1252' LC_CTYPE = 'English_Switzerland.1252';


ALTER DATABASE eventfinder OWNER TO postgres;

\connect eventfinder

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE eventfinder; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE eventfinder IS 'DB for the access with geoserver for the webinterface Eventfinder';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    catname character varying(25) NOT NULL
);


ALTER TABLE public.category OWNER TO postgres;

--
-- Name: events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    ort character varying(50) DEFAULT 'Zuerich'::character varying,
    plz smallint DEFAULT 8001,
    datum timestamp without time zone,
    beschreibung text,
    website character varying(200),
    ticket character varying(200),
    teilnehmer integer,
    geom public.geometry(Point,2056) NOT NULL,
    catname character varying(25),
    subcatname character varying(25)
);


ALTER TABLE public.events OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.events_id_seq OWNER TO postgres;

--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;


--
-- Name: subcategory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subcategory (
    subcatname character varying(25) NOT NULL
);


ALTER TABLE public.subcategory OWNER TO postgres;

--
-- Name: events id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (catname) FROM stdin;
\.
COPY public.category (catname) FROM '$$PATH$$/3692.dat';

--
-- Data for Name: events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, geom, catname, subcatname) FROM stdin;
\.
COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, geom, catname, subcatname) FROM '$$PATH$$/3695.dat';

--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.
COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM '$$PATH$$/3546.dat';

--
-- Data for Name: subcategory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subcategory (subcatname) FROM stdin;
\.
COPY public.subcategory (subcatname) FROM '$$PATH$$/3693.dat';

--
-- Name: events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.events_id_seq', 10, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (catname);


--
-- Name: events events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: subcategory subcategory_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategory_pkey PRIMARY KEY (subcatname);


--
-- Name: events catname; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT catname FOREIGN KEY (catname) REFERENCES public.category(catname);


--
-- Name: events subcatname; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.events
    ADD CONSTRAINT subcatname FOREIGN KEY (subcatname) REFERENCES public.subcategory(subcatname);


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
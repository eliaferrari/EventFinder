PGDMP                         x           eventfinder    12.2    12.2     r           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            s           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            t           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            u           1262    27160    eventfinder    DATABASE     �   CREATE DATABASE eventfinder WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Switzerland.1252' LC_CTYPE = 'English_Switzerland.1252';
    DROP DATABASE eventfinder;
                postgres    false            v           0    0    DATABASE eventfinder    COMMENT     h   COMMENT ON DATABASE eventfinder IS 'DB for the access with geoserver for the webinterface Eventfinder';
                   postgres    false    3701                        3079    27161    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            w           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    28259    category    TABLE     M   CREATE TABLE public.category (
    catname character varying(25) NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    28271    events    TABLE     �  CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    ort character varying(50) DEFAULT 'Zuerich'::character varying,
    plz smallint DEFAULT 8001,
    datum timestamp without time zone,
    beschreibung text,
    website character varying(200),
    ticket character varying(200),
    teilnehmer integer,
    catname character varying(25),
    subcatname character varying(25),
    geom public.geometry(Point,4326)
);
    DROP TABLE public.events;
       public         heap    postgres    false    2    2    2    2    2    2    2    2            �            1259    28269    events_id_seq    SEQUENCE     �   CREATE SEQUENCE public.events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.events_id_seq;
       public          postgres    false    211            x           0    0    events_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;
          public          postgres    false    210            �            1259    28264    subcategory    TABLE     S   CREATE TABLE public.subcategory (
    subcatname character varying(25) NOT NULL
);
    DROP TABLE public.subcategory;
       public         heap    postgres    false            �           2604    28274 	   events id    DEFAULT     f   ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);
 8   ALTER TABLE public.events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            l          0    28259    category 
   TABLE DATA           +   COPY public.category (catname) FROM stdin;
    public          postgres    false    208   u       o          0    28271    events 
   TABLE DATA           �   COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, catname, subcatname, geom) FROM stdin;
    public          postgres    false    211   �       �          0    27466    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    204   G"       m          0    28264    subcategory 
   TABLE DATA           1   COPY public.subcategory (subcatname) FROM stdin;
    public          postgres    false    209   d"       y           0    0    events_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.events_id_seq', 10, true);
          public          postgres    false    210            �           2606    28263    category category_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (catname);
 @   ALTER TABLE ONLY public.category DROP CONSTRAINT category_pkey;
       public            postgres    false    208            �           2606    28281    events events_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.events DROP CONSTRAINT events_pkey;
       public            postgres    false    211            �           2606    28268    subcategory subcategory_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.subcategory
    ADD CONSTRAINT subcategory_pkey PRIMARY KEY (subcatname);
 F   ALTER TABLE ONLY public.subcategory DROP CONSTRAINT subcategory_pkey;
       public            postgres    false    209            �           2606    28282    events catname    FK CONSTRAINT     u   ALTER TABLE ONLY public.events
    ADD CONSTRAINT catname FOREIGN KEY (catname) REFERENCES public.category(catname);
 8   ALTER TABLE ONLY public.events DROP CONSTRAINT catname;
       public          postgres    false    211    3554    208            �           2606    28287    events subcatname    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT subcatname FOREIGN KEY (subcatname) REFERENCES public.subcategory(subcatname);
 ;   ALTER TABLE ONLY public.events DROP CONSTRAINT subcatname;
       public          postgres    false    3556    209    211            l   ;   x�ȱ� �^�0Q
%���0}�叕���%������ঌI����� :�      o   w	  x��XKr�H]ç���?���$R�e��G8zS�@����
�Vs����}���(s�y������G� �*�˗�+o������)Xm(�����l0�i��a/�⟊����7�Z�yNVŖR��Ud�]�\��՛D�j�Z�y�TΫL;G����ޖ�qw)��LWEB*6�V^�^ݛ�Ef*N��w�=�n˵�ȩ����p�IcDk��r��g�HTU��?�z�+�Iy]�CX����+i��Nեd?��2X0�OlI�yR��.-�.�"�U_)�L��*w���:�M�f��9�Q�{��w�3^�R�w���������;I}zW�g��D�"+]r>��}F��?�p1�7�d8XǓp1���0�����?�����d��-.vT̍�2���VIL�Q�ö?V,c�UW) ��P}�	*���PUaw��3���:�k"7�)���Ŗw[�7�r���\���v���%�h�u�ߌ�s��ܓe��e�$��Hu��Ƚũz�A�a�Y��z�g	��I,:�N��P|)�B-�f��+p 㧄�Wl�%e\Y��\x���z�l�ԭ.
�ۮ����Q��&�(�p	J%�X��ng����D�C`�u��MQP���e��y�'�]
_� ���ƞޥg��J"���/�3����$ZL�%�g4�]��'���y(�7@. �!n��O,QM���g���J5���C���	����p���X���Q* ���ɏ?��S��?{_K�t���T�I��\���2�:�*R(��]��O�K��n������x9�"��r�����x~!��>��yǫGo)ށp��D7j{�$�(�7e�dnm
>|ܼ� �0To5��K�-
˷�%��5w���ol�kɔdp ,������ ^{,��P�Yd������2�Ғ;���\�Zs3o �M�˸W��#�SZ0�^[��S��F唢�2��P�W�t�@�^�o��~�Тp��y|��m��q_�wmŞA�� 86h���>y����N/^h�p��U�쇭/Yf�a8�l��qh���B�ta�Ԋ�M@0�V�u�| �s��+��� �,{L�:��u��0;��@(��$�%}3��4
_��P+D����xw��% ���0!��x�'<��l)x:Jʵ4�2��]�����i�C��3�ײo�����x��蚜1O���X���]���b$ڔ,��H}7��1��eNg��ϑ�	~ķ�[g�̿q�r�ew�r��ۧ���#Z�@��=�
cm�����vj�m��:� �J��x�Ӆ:} ��d�����	���L��|��!�/���%Z�2+�B��@>��#uP^QNF�Ak�b�vρ&kjFw=��,�<�D���؆!�U`گ�� K� ��|��X/H�R����,�u5�0��8l��1�]*P�4�y�DJܮ��aΣ�0Lƣ���s��h2��٥�a\�b��h�?� ��P�t<��zDG#İ"K�����d%�޹Z\������(�㟵�^�����%,��	�={�g�-�ÝK���Ķ~�]v�ɖ�R;��{f)�.���퍍{���	[?��z1/��X�Vo�%�2x��A�~M�^�~\���9���b2x\���l�\./��-��F�Ee˝f�w�pg������ϙ�|A����t\~�p��}����Zaf2�hlX�	��z{2lT%�X��3+�	�	7�OĒ��x'OT`����q7v�9T7�b��mR�Z<���J;��en0�瘼:�,5���a������Y�7�L�k_;���\�$Pw��8�)�v{�uIh��O��ǝ�-�<��6��&A��/�s��Wdy�t��ت���zi���U�o�_Q�y�8�hx�;�~�}���Nf�*($R�Y
�Vx�َt��H**�+��ꚟ���s�;�(R��[bG�vܼ�9�?�X���X�>� L�{��㏆�,}����//�qo'�����Y��?���'g����I���[����/`iINr�U�(O�m�hy�>��q}����(�k�)߳��� ~��- {�ǳ<�I&V�[\}'�$�4��STȇm��1NZ�9�ld
��e`�%5[aD�ԧ��9[xR��q ׎:tJu��
��t9�j������|���F�ḱ2�=��E��I����̋�K�/ǡ�OX�8)�i��c/��Xx�G'��k#��%g����p��m�<y�GU2��V�W7sL�ù�5� �*�=��a�6���Q�5(���p<�2��IL�M�H�:����I,'r0�	 ����+�q���S�Ǯzز܊M�.^@�欕ІǮo�;ƌ	�~�	�b��l�S��8��ڧ�/���W�^��Hڢ      �      x������ � �      m   x   x����@��c��^p]*0M����L2Ʉ�o�o4�LiX��D\fb�#� *y�SV�8��"�I��_��ʅ�,l^�m¨�T�D'z�0�<=���g1>2'&�p�k���8*     
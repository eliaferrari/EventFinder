PGDMP     *        
            x           eventfinder    12.2    12.2     q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            r           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            s           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            t           1262    27160    eventfinder    DATABASE     �   CREATE DATABASE eventfinder WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_Switzerland.1252' LC_CTYPE = 'English_Switzerland.1252';
    DROP DATABASE eventfinder;
                postgres    false            u           0    0    DATABASE eventfinder    COMMENT     h   COMMENT ON DATABASE eventfinder IS 'DB for the access with geoserver for the webinterface Eventfinder';
                   postgres    false    3700                        3079    27161    postgis 	   EXTENSION     ;   CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;
    DROP EXTENSION postgis;
                   false            v           0    0    EXTENSION postgis    COMMENT     g   COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';
                        false    2            �            1259    28259    category    TABLE     M   CREATE TABLE public.category (
    catname character varying(25) NOT NULL
);
    DROP TABLE public.category;
       public         heap    postgres    false            �            1259    28271    events    TABLE     �  CREATE TABLE public.events (
    id integer NOT NULL,
    name character varying(128) NOT NULL,
    ort character varying(50) DEFAULT 'Zuerich'::character varying,
    plz smallint,
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
       public          postgres    false    211            w           0    0    events_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.events_id_seq OWNED BY public.events.id;
          public          postgres    false    210            �            1259    28264    subcategory    TABLE     S   CREATE TABLE public.subcategory (
    subcatname character varying(25) NOT NULL
);
    DROP TABLE public.subcategory;
       public         heap    postgres    false            �           2604    28274 	   events id    DEFAULT     f   ALTER TABLE ONLY public.events ALTER COLUMN id SET DEFAULT nextval('public.events_id_seq'::regclass);
 8   ALTER TABLE public.events ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    211    210    211            k          0    28259    category 
   TABLE DATA           +   COPY public.category (catname) FROM stdin;
    public          postgres    false    208   h       n          0    28271    events 
   TABLE DATA           �   COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, catname, subcatname, geom) FROM stdin;
    public          postgres    false    211   �       �          0    27466    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    204   �K       l          0    28264    subcategory 
   TABLE DATA           1   COPY public.subcategory (subcatname) FROM stdin;
    public          postgres    false    209   �K       x           0    0    events_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.events_id_seq', 55, true);
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
       public          postgres    false    3553    208    211            �           2606    28287    events subcatname    FK CONSTRAINT     �   ALTER TABLE ONLY public.events
    ADD CONSTRAINT subcatname FOREIGN KEY (subcatname) REFERENCES public.subcategory(subcatname);
 ;   ALTER TABLE ONLY public.events DROP CONSTRAINT subcatname;
       public          postgres    false    209    211    3555            k   ;   x�ȱ� �^�0Q
%���0}�叕���%������ঌI����� :�      n      x��}[sɕ�3�+Rވ)����j-@ �Z�$����3 T�.p]�&�~�Wol�Fl��л1��:��'���O�sNf�p#@��z�r[PYy9y.�9y2S��%�	{�DΘ��8�po��ԉ�G����j����ڂ��f�*�W{��y���%�)��ь�!�wʜtrȠ\'��q�<'�y���/�(�x4���������Y�v�#h�u��exɕ�p�z<f'����[r����k�	�,����Q�8)�7�,q|	����/X�Dv9n��^�s����4
y'����,x�\A5{ǽ���n ��~�Dn�� �y�Ng�?an��_B/�����j�$�,�FLmϩ��(�j!4xa\�j'�|US5���վMԦi�M���[��k��TM���[��m�MS��^�����7�{N��t:��4K��V�M,��;'�����Ν)Pjȧ(De0��4v/<�g��IuR"K�.\|YN1�Z� ����&N|�4�8'�{�xS����X�ؽ�N� �
U�M ��9^5´P٠�^9�Jc�v�ә3�w�&�40�$tz���s >��-�#�0 ;^�I����N7���qA)�W@ή�Hr�To�{�y|D4��b�HE�8���L��*)*�9�E�y� �������`��/10t &4�A8n���<р�����c�j�m4�~K �XF���m��fW%�1j/�� ���(4?�b��h����Yz��A ����{�2��:H3�	PF`�ab�K1�Y�S�~�`�,gH|�ÿ.5��ߕw!�I�ą���1�i&�AA�oC�"F����$9Q/��w�F��{�n��5��9����>؝#��Y˻p>���l��\p����9��(��f��!�N�2��h"Yp������T���IC$.��]�D0p%�/�#����!�$N�T��>�01=��t�!)fR��h�}��=ύg!J&N7�u��C�	LËCY�70�0����!5@,'��3*/f�ʺ)����kN�aa���A��!�Fz;���OD�qF��)�HA�D5Y�.rd�̓����5¤��d�VX��I�jVWU�&�D�2�S�t�b�JM��5�PT@���G��ҨP����& A�3�P�4�l� ���k� v�.��R��
؛j���}7�O��Tx�� C|��!����@H�֑��Cj��]��!B>��2k�F�6�|��B"'��Kj�e�c���t�H�z�����$D����dBz�f��23��C� �$���3����5v-���7���J�\����Pj��L1
1�s�93Tv�3�N@��!�݂x�@��-f[���5��	&���E0�H�h1;	�[��|��Fȕ���/�>�#�Sy�}�2Ȁ���^l2��t� ��Pe�� Ή$����l?����������(c�+^�ҘE��=0�%{L ��q֯�E���*�$�������ڦf4m�C`��CkZ�j�{��Z go"�^�	��=.MT�e��4��ZɄ����lP�O���=G��4řq��m�����B���A�A�~D��)�Y���078�>	�r3��G^��Q�"5���D|
zI)H�,�h��lG��Q��R��9e��R��E�����:XC�����:�8jv�>�Nf��n�#���e���T*�Z?�¹�l��	J��S_��w�m��O��������7o��0��80б�ڙC�H�w��RU'+P !H��9{�Q%y���H�s#`id�qnv�D�:d/pE���6g'a,b�c'F��.�X^g�E\�
"�9���-�|��ܼt}�I�n�|�:��g���+�e�/ �%u� 3*�1��}���&0?�	2]�Ξc����v���njL��6k�-�3M�s�%�EC��\A��r��{7*�d(����&ЗxK|����h�Q������Mм⇿�PB�4&��rDt��7B�?��(�`茅{��.u��%K��>Jl��q���ǀ�Ƞ������h����|�OT�G��l���D�<9Ī�(�eC��C��J�z��
�S7�=R,s�r�n ��1
��A���LFPE�}�A��CJ�dx�ڃa���ǍIĤ� �	l�F�Z�r(8��ժqX��k~�j:䚪x�ʦ`Fk�2-��ږ�t�~Ӕl����q�z���#hnR����Ν#{�c�������^ ���+��%T8�B�XЖku����K��y�9'�=FXHo�@����Z_�2t��S���Ԑ<����^��Y�j�g�T���	�Fd����>*HJj(נ��|���#�A qƁ�$(��n�0��n	��NX8 ���֔O��&���s��x��Xc'qh ����w"'��w���<��9W�Eޘ�2�ܹ�_�P����s��c�癟sB�g����O˺�"?�:ԉ˖��,l���\A� ���^��1a~E�&Hm�@����<2�Ո�&?��#�*�/r��aEX4�N�R�@EWa
*�UѸ�"�$��ۼ�gч�w'�A���S߂pA�N��AkQ�˞�M�D]�PA?'�6��I�xt2qG`��w���:���:CG8^��;R!./9���%at��=����K���1`!���캿K9��i�%�*`�$��G�ȃ�<*u .p�@�&w���f!T�mV�p�\=��C���P�- �]�?�=r�N��'����B����(a�I�|җ� ���U�MeT�B�!�+tR�c'�1�b�j�f��������.�N��Sg��_�w������>}A��;��[���>0���6-������n�s�5�z0�Rg���@e�>��`��+����k�OAz⸳$���:�t2cw�[�$����	�X��`�G�l�_��?cal�N	FjvƟC��7bR #����¹"�p� ��:UR���P�q��췭�x��P�0~���@�����0�u6�z��I�r&�*i�(�h�p ��� -x������� �N)4㊶��F��h������_��m����`g��� fgRP�>F�����3 �乌L�7>��+<b���Ƥ)C.=�B;$�C�&q.Ȣ䥆W`[�ȯ'-f�u��8�a$ ���C`gb-��B6���z_�S�_���rB�a��h}�����#�.J���?��%[ӲC�L�O�:��A[7�2���F�|2t�N�PճN\�Ip�ڭ5���T-�� �4��c�K�C��݋�x�͐!� ��8�!��"���q	�8�X@�`|O�-;�f�9���p����-�V��D���oBtH��U�.��D/j]�b�5ƥFv�b�f�j*�Ljm�7�uud�l��O�ΌC2 ã+����>�_�*b�$�/u�<��C<���`m�@K���ہcA&*�M�Mb6,l ;���|e�X�#|cC�@�aYb7j5��cW��BE�qp	�dl?	ÄJ�/�>��D�l5>��ƀW�;e�S.��HI�w%�j�Ѷ�1Fs�i�ԁ��i=SU�M��5���
ֲ�2�����i؇�\!����C�~�^d\ �O�C�J'{N.N�ۦ'@
��4��&��(G�����`PI쎩;U�-0r��2t��E���s�Qx)� �R_���%|όr�h�JE�t'Z���D~�p$�����b[ --,+bCU�O����H����@��	|��}�S��ނ���u�������d�d�Ȅ:�`�
ZJ%��U<S�4]�>���v�p@�C�<q<���Y����t�K��*��U~�΀U�1�d�d/�k�b�a�}ĩ���}�k�AF&��+P�����>#d8D�ޢ�ƽ��F�s��I�O�"�V���� �     �ehn9t$cz��J=�p�����Mh1L@�Q.�|,PZ���aI���f�"V&�D�'d�Y��&�ktD�TƽsV&��6�w�*q*���:��4˩���`?�.����UQ������<�+�g�K|��a�'�c5�ܸ�4Z��iU���Y�S(][qx^�S'wpyT���tώ�nu�A��A1�&J�,ң!fDZ�k��?�_�0s�+��"�^ K�`�x�2��}��{�,�E�(��.b�a��c2'x:#�)�T>��.�#���aH�,���7��<��?�abȷ�A����2��4��8��|ȿq�ς�pBW8�� A��9�Xḳ���ɮ��u���NQS��-�7.EfV1�a�R����\ ���2�#QV,�a�!Q�e�OL#
b�
8�CA�E���S�r����rg�#M����
w���i&���iYr�� ����Eq�Li+|�~�v�Uk�}>u��q�}1' ����L�Î@dc��r��s�j�_����d���n��q���dUBlQ�E�-���f膪=L���Zm����{=$����mA�v�D �c/�$
�;��tb��g8_j�^vM �4�,�`{uR�h��l/B( �I�wF�"����+�t���nJ�
>��P�oit��)���G�_�2H�c���b����5T�Ao��̣��2�.+�r��)uY��r�H�Z�� ��c��:��Zx�TMS�l�g��r'�8�;ަ�O9�wH�X���=�(�e�dwX+�òs�P����>�F�uFI*\W���	BԘ��n[�^�!殳+�=LR�iMJT��u)VUP���@
�4T�6��z�C�X��ة�#��z��0���W*�U�����Å��]���ѿ�8���NB�b�m��0�(�
_y�ӄ.�?�7�_��>��ԯ�	1`��W�q���"{y�g=}t<���z�{0�Ѳ7H������î�����b:���Vi�>�(sJ	k�0���U�!�i(ӱ�l�Bl���XL�8>7��	�0b�)�Eo��Hޡ8N)T�Gsk����E�.���n&�`6$Z��̭Q���H�Y��&����٘�E2w�f�T��i�7V�|hE��������'��[��"GW jΊ�ٟ&�l�w���JA���B�#nzI�N���&��_�P1�UP�HC����^G�� V�Y~(3�&a�M�NN$�:�ؽ�1�:��"ټ�i܏g"|���dT�`�ժ�-���O*��+l�Pj*uʚ0�RD�V@�� ]�c] �P�O"@�GP�Qr��}��*��	�WJ��ii�D�L;&?)yD��G���V6��4�s��gr�EȬO"
|㥣�h�L��0zO쿍�Ed�/qi��-��CH���V�HU8�s"h��<���%Ws^Z�J���X9Q�����	gVeX9�c��P=["�:`��G ׽IWIzk6��M�6%E`��I�~E �G�ȉ��0J
��G֭][⊒᝹5��ŉK�9Ii��ޡ��ad�����_v�FPI<��M�&4�Y�����2Y�
X�K��n%v.H]�F��: ��w�3�kR�K;6��lh�����d����CP�z����7v�7�L���/+����]�Y��Y�߱o�[�B��q�َ#W�h�͑�s/�X�@ ��f#
�����pw����Ŧ�Ļ���c�Ǳ7*"G�>���"~��T�M:|��L���U壢K�M��!�a�0�9!��`�)�uD8^1��'��;mlZ�7�I�}�W��3��Fi�d�Gqf��`�+P�4'���F-�Y���Cű������F�jy��?�F�{"��6&�?Ip#�}��g���"���0?�~c��;�SS�\���Su�Ed�EA�kN�.ݩ�늝K�z}�9��2��N�H<"��5�^�%�7��/;�ٺ��/�fx;��)�\�+n��|+�Gv"�Ў""�؎����̯R|��	E��:z!n��]I��|���]p>�ʜ�r����E�3��������}�jc"����5tKi}���.�r��{,���t��m���7JT���ۡ����s��jn�Rh��7�ss�˃)<��}���p�Dn�9|b/��Q�L���dbJv�W�T=���6�^�3�.9��O��X��]t�&�"UL�+�GE2�<
/�P�2AK���/0��&�����\1�9�#\e���j\��y	0��;{���o�.#��Q�c�'C��@�)�i�_Rپ3D�d�iF�/���ɲ?�}6?�W�@���C�͒RX�����ȏu��]w{�������0XPp47Ay����Rx�k,!��D���?*%�n��B�@��N� {��<(*K��){Z�D_P���L[s�(xB͢7�NΜ�\��eaTЛ;��Q.�+��1Y���gnSL�~c�A�m|"�nդ����(��ߞ俱cxRA�rc��`�9x�4_������4a��}I��N�Zn����0;�W�?�`���:4T��,:�+G.�|%נ"�lr��Y��rx�:r[����7�f���V�z�"�8��o�,v���t�,ⓧ�,"����wo������c�Kq��/�Pl��e6�/���c��kz���.�������;e�B
>s�!zx
��O���Y$�Ү�؎N�O5����A�m9zu���(����WK}��	���\-tz�ct].cW��Z�!D�W���q��Eu���\�,����e��(�t�8���N@�[x�6�bj߽���1�O�}q�I�_Ł�����~4��I���J����J���y�\:9O��h�Q�5�N@�C`C�}��� �a<�.{������+�7L���F�!^[�z�1 ��['�zxQ��*��WF#��8��q���v����t�WտZz�XVJa���/_�.��3��ֶ�,|q���y̎\ď�l��`4�W��uf�,�ȉ�����	���͟:o��w�#��:��k�y�k��aO�t��h4fg�x�nv�#�/od����9ܡ7���	��'g��<;/�N'2w�9�NF�h̞�'p�4��5����p���<NW8��Mt��2!��G�Hn�F9��Qr���!�I��G�L-����$/|�u�x	�^*n �_�/���3�R��z��g\*���V�6�#{�^x�/��";L�����,M�Y������<�=�W|+��u�'d"������^?	�]�GsS��#]�4��
�K�,������<�m�w�� �c_��p�t̟�͆a�Z����"~k5,�4-�<I>��Z_Pf�|�A2��T/~���ੴ��Q�&��v����w2X�z0��Q٧�!ޠ�T=��!�N�)�_��|��(�"�eWO�߼]i"i�B�$�8?݂Xb��8������5y������j�v�av(�;m�Gkӭ�n��S����,�68�R���~���ڹ�x�Eͬ@�؛���"u�(��ݖ�~�{�K�4�����Q;�f?�Ǆ��{��N��ח�ON�g�aJ+�H���G�[���x$ݺa7֞AVĽV���B������!�+v�ôJ[�m��Z�	yu[��i���h}S�zv_?:�Y��%�X��P�[�z�º*��5��yy�����e����ҹ�A5*"�+�K	7[��@ϓ��,�$[0�q��J�bm8�?��m)83�K��Uև6��G��[2#�h�l����[�V�����lߝ-W�� ��U�A2�ogKs������e��uU���sb�}=�z�1T�A��ng(��ű;XNܩ���JG[��*sS� 9N���0]w[ l�AQ�ȋ�%p�P�ϣ�mʍ8�pVy�"/�r��'p��V��8���� ���֮�r�% ��8);�K�n~�$x�^�T-fXVq�����IY�H�-t5U�J�zw)�u���7��ۛ<>#��<J�x^�\�F�    �<�t_�����
�/wiנ��K�fT��/Ka��h� j��Z�o����Xec�f�\ˆC� ��,�c� 2�G��^C�nj���0S�[M[�-�`V</�8����ί\~� �������͕��5*�0��P*����c4Ik�{��C]k`0�R1���_�1ͦa%�djfôY5��t�h4�v��I�R@)�.BjеQ���*Q�yz����E�C�
9���c��
�o;��e^�?���JadB�L]^�u��p?a�� �͟o���ygx���
���������[7v�[���Sڥ�-,(\�?���|��[�_N�R7o�	�b�.��?�`g����I֫��V��b�+�H����ڭ��L~������dwp�d_�UQ�kEe56G�ֆ�6��")�m0ݨ�H��}7���f��>�����w�G��s�:��z��{��|����R>����h�pR���I�ԍ���Q%��i�#I���%��*uM�4�fK{��4���c��VS �5̣�A�Ӳ�-q��Y=��G�hQ�a��<�r,�m�gT���*0^:�ƛ����x���b�4�`����J��Og���WxIP�c��;8`��c7W�ѱ�Y��ѐ'��fʰ
��˷d�`�.!��G]�ٶ��u���U���C����=�}�}YEF�p�Í'��a�]�� ����~�3�	������9�W�Z��W�V-5;���Ĭ�������	[�x���F��_�����҅�t�+B����07�Ċ!,�����s�sS68]G'�5�S:A�r9C���0�.�ﾀ�29��9�03f�e�`eV}0������e���_�\�v�Ѿ����B���̽�6p�!{���]�tYv��C�nh�!���y��e���4��sӋ������z{=�5M�W8�����!�~�{S��Ľvq{�%�0mDzx��͏Ӥ��B���Vg�m3ܞ�(^Â4\�:�A�T
���oku��5\�_�7�����p��޿^7�x)k,EP{�*r�%�z��r�nV53�:��N?�~�n���q���a���m䎔� �\$.�.�1/�Ŕ�$s��Jd�0�!;q�aQ_��ك9 g���ubV�9�X���+�E:iL�Ocu�[e#���$�/�l�*�g�6����do��+��u~��e��y�M�pF&#�[-�A�l�M��6{=����5l��?j�%�&�U;[�Rv�9��`C��z��c�*���t2�\֧���q����,7�sZ�0t3�<w�X�r^��z�IQ��4����[�d����"XXܴE2`�w���c][W���k[c��]�G�|���|�B�NI�W@	�Xt8(h@ �P4S9}��`��K�Ws���lus~�@;P��	����o�9LƠo~L�S�fY�捃Ej���8K�**Ц�1�j1Sezs7�̸+f!2K5n�j���b s>s��bc�W�b�����Nx0�y�iU��Z-�����>��zCm2�P��������k��C]m��!.���|�;hB����_ENH�����D�5���$���x�YbB��*0 ��rp�]�%�T~eKSg�:P4S7��DVd�v�H|FD���<u'��`��S����	"��C�\�
.�;C'9�N�ܠ?�bm��ħ'�c��d,nDYv�n%t����]oӇv��Nm�Z��p� ��������x
7�%r�<:L9�^������P��7G��� f��|���l������S�J UH�SN�T�׾	f�]8BDu��`B*b�H�e!�m���C�~I�����C�\������e�n��mI��f�\�Dim�p��ԕ�fhe9�Ҳ$��ۭ^O3:�G7�Kכ�ն%�k׎��Q���C�;IRl-s��WK�+���^�9�\�����ܖ�:¸i��ǚڲ��z�ȀњP�i�wߢ���
*{ @_z�>��������
�v�qr�.�3�k�����n�oO6��oތ�49R�:��£���Hm���	YFқJ۴U�0և��s�e�;�����?���?�dk�^k�ٰ�����1`2��{�۴��8���WtȲ����<���R{��R��ФNy<�?`�D)�t��$��
4�������;�{	?���8�O�1o��A����0�i�ȑ�s��m\xwC��p��-���t�u܌:��o y�/��#ڂo�_/�:Ŗ�%S0~����߆H}^AG�9�77Ħ
�xT>�C�'Uvn�K��J�֪���M������V��#����T��p�ލ�Y����=0u]��pqJ�Lcpd���=��T�+���W�N�Q���op 'x)Մub<���4o���/y@*WTi��%+���ۻ�S.a�%�f7��^H:݈<��o���8Ew/Q��)�{��&+܅D�9v���SFӹ�l[�jZ�͟��y���r���Z�ǯ�K�WK��6U�e�b��E7���l�㚌s��]��s,f�CB`k���*2��`��<7`�PobL�kpa�3�!3>��2Rڊ@fBh�Hj(8�:|��ފ߷�h�[�7�`���%J�{�6!N�3���7��v�f{M=|�Y�A�È�PG ���!�z�Qx�'̡�W^�Ii#��A9`�`�?�a����K�/�G��UEK(��An	��b�K�W�%��T���9ʶ���{|���	s�#��e�}6 A��J �`m�Jd�G�@��naI���$H�n#�BJ�ny���&���[�Q���v:x1ayϧ�	Z�%L���9�3����e�����}:mH\^YÚ�f���|w��b�F��SBhO�d3�S:�R[V�AN̯��c��V�ӱ�#�0�)�Xu�6�(k��ic�.)�i*��ae�蜿ف�R\ђ�v*Nf���ð�`������l#|���^����]��d��Y8p�΀sc�&Db�c�.g�3� V(�d7�|���8�M�+�V�3Sj|�Rz��h-ǘ���ۏ@����>��nx%jeW��A�#/bb)�ʗ vsoB�q�FQb�x�r�ZKd�O�ܮg��w����ҨȈ+~c���㖡��f�J�S7K^�p�)8k������1�pt���~ ���r���9��_,��bdw8�Fn��)���q�nu ~�DH�^����l��5x(1��6� N/'�oY��D=-��FQ[���Q���qZ��ˍ�[���\A�ٍ�4�M�LUo�&8� �/6H�o�m����K�=^LV&����E�q�!dF���-�}�r�@�p%�O�V�az�"����kKz���'��UX;sY�[p0�.��o�7�-.��W"�B�2�օHϗc��r�S@t���-��:��09%r+���;�z��CZ���
�	^ێ�D4�t^8n1�7�_|�"�?��f�ϪK�4���n	n��[�m����oٲ������M�A�k�՞n�@-:I��k����@��T%ڵ#�ܖ8����[`�N��Ϳ��;�� ��h��5s0J<t#�_οZk�'Έ#o�)b�a�`�v���
��8�G�|�j�YT8+"Pv(̚�r(s�� O�-�^��K1���G��s�\1K����0�7�������}������{=��ݝb��8ŋ/o�1Ð���6��|���?�Z,��s��X4�@��&Ñ2�|�y�������h���{ϾZ�^�zt-or�_�u����k�:���Q_{}l�~0��+��E������g����>����F�y������?�����㎱�U6U��Í���w��7 ����w3U�4�Ϳp��0���-�w�����ǥ�osF�o�%x�0^�A�)y	��ݴ$Y��wU��V[׎L�o�ZG�`�Mqp�����C���}�J&:�3]w8�`��<M=Բ�2{�ğ�J��wv����]��ޕ?��i�NӘ�t�|ޙנ���͑��,+���w��=�%=5�x��\K(OOQ��cgȚ�J�8 �  ذ��7��B�F�#w4�|i�:�4�og��	\ά����\*_�7t��T����$�J��|,j�ֻ#��Vfu�y���k�$����������V�~Ww�g��w􆦃����X"�s�$�s�3gz�ٜ��職iꝼ�U��@�қ?����O���F�)��V��͎��r���d�V���R����K�,3�wL~\��[����}4]p����MӴ�9�i��vs���]����ٵ�f�Ȕk"��ǩ�B�2�WĿ�����\��0a�~���>�����,O�[�ppߧ�C�VM6��W:�����tK�iV�*[Lp-L��Z_f���L �x�St̓!Ԗ˧���a{K�Y�k4�y��U�\~��!G��H�#�;�	U{�M�@|�<d/�+����'o��в�8np��p���I��U�{���s�X�K�[)�G��+� tѰD`a�h����� �^�^H��u)��"���C��UI�N#�ci��`F44�^�Q,������<(��"���#��:�8��	y,�~C����dc���)gb��1�8�Y��J�Y/� ���c���В8�ID+i�e��)�S��"Í�l��R���>	5t�5�Y�9�CT9�y�0M��c#:�T����)��Ģ/��9&<����4�c���6pŃ��i���a�C��U#��޲���`Xu-���1W�X�A`{F�8Ҏv�3�U���U�m��x����/�?x/��      �      x������ � �      l   x   x����@��c��^p]*0M����L2Ʉ�o�o4�LiX��D\fb�#� *y�SV�8��"�I��_��ʅ�,l^�m¨�T�D'z�0�<=���g1>2'&�p�k���8*     
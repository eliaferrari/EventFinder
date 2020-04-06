PGDMP     9                    x           eventfinder    12.2    12.2     q           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
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
    name character varying(200) NOT NULL,
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
    public          postgres    false    208   i       n          0    28271    events 
   TABLE DATA           �   COPY public.events (id, name, ort, plz, datum, beschreibung, website, ticket, teilnehmer, catname, subcatname, geom) FROM stdin;
    public          postgres    false    211   �       �          0    27466    spatial_ref_sys 
   TABLE DATA           X   COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
    public          postgres    false    204   �[       l          0    28264    subcategory 
   TABLE DATA           1   COPY public.subcategory (subcatname) FROM stdin;
    public          postgres    false    209   \       x           0    0    events_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.events_id_seq', 347, true);
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
       public          postgres    false    209    211    3555            k   U   x��A
�0��_$�PS�Mi����x�0sZ{y��da���5~���S�A;���h�:8����TB�'�s�X �:"�      n      x��}�nɖ�3�W�� 56��3�����j�l�jS.ߺ(�$�d�ra�"��}�`�y�ܗF�4��'�O�K����DQRY�}���&�ˉ��Y�f����;K���?'�3��޾y=<j��~:-٦mfͰ�6M��+��xq��~<M܃q����G4|�xه�M˰*fӪ[՚��.���� 	���p���'&N��g�>�������oƸ�����~�:��_���g��:���6�ݶ]�L�g[U���V��A��w�j�j��n�J�~,B��N�s�����aE7��� '?���ڈa�D*�V��j�/	��= b�w�HӨ~I�4���#@��j|9�X�a
�3�(��
w�k���a�i�M�&�?�*
 ��'B6	�<fNA.
�;3Ɠ�!����,�b��(>�����w��\��.O��`G�a�'1�tF!�,�2}�&��I0r\�%O�+#8�@��_�~�r���1O`��`1��%X��߰a�����h����ga �(�\��~`���
�	���4�p|�;�8t�X���#g6w�1s�iX��x�]\U�h�\D4���&D*]0����TD���mT+�j�a��v��aV��j�띆D��>��ᷝ����q<
�٬Դjvz�v���?�d0aUv�g ���	� ���N�ȹp1�� �s����0_8��:b8�`	p	�Myt��t�x&آs�ݙ���8�Ĺ!� &�)k��F�c�g�v��&0��Mfs>�w`$X4 �$,z�#�L �@� � �) ��\�C�?i�v6Mh�	P�p��"�U*L��O�����# ��	l�f *��p,�?3����3��������oD ��R��K�XT ��Nx0����	�?�*u�ת4�~� ��*�n�����=TJ�}8d����'d�D�6�V�<k/�9����L�W	��+5�����9���7�c��%�� �Á�!��O��6ŧ5>�wD�S�$�GD�����?�E�T% ;�S "-^'0�F�V��;���eY�A�oڭ���4��t	�s�q���n� �	�m%c�V%�m�8/\�h�Pps�<�F��j��9�A[$,�p]D�q�����?�|%�p� ���L����༖�x�Ę�m�����!p]'�H�x�8�OFH�S8��	��1��v�0c,צ�t d9e��Q��L�I��]	"��ݭA��G���p`����Q8�X�i�m�E',������V,H���b1�-î2�ʤ�ۋ8@6k�f�&
�Hȓ4�8t�b�R��9�H@���G�(�(c����@A1�Ȁ�#�m�P���gG�e��%r��,�Q.�Ǿ�ÿ��p�� B���!,���@��#�#<NĂl���.�����hZڠ��2ײT����s�{RɋԜ��H�t� ��q�l�0�4@���tJz"^�O��b���Ak}$��W"�g{`M�����"Gr��?�X� ��l ��f�R
�łULv�1T�  �`��N(] �w�  ��q��]Npx��9 ]$��d�f�ӹ��#��j�X)����:Rz���'��b7�u/4	%����	?@��0d�� �	�䡀h?������;4��H���/�i��H���<&6�,�ԯҩ E��XI���f�jU�J�^k�2��a5j5���:4J=P�;��"�p0z�;�R�^5�x��r"�A�L`�ѐ}g���T��_<��6�37�����9���� T�(�	��%�3� q�����/Q�o2v�$�EB�e(f������	'�v�g��8-c��3f�0�D�nH=ȰM��r�'r����9*�n�m��u�Vk0t+M��*��!��I,8�yz&H�����A��h�?0�����t�}�c~��{�@f�9�F'rg#��¹BE�& Uu��
���2n��	d� �8�7��P�{��]I���k<E9��E[�#N:��+��x�6H^>wC�h5���1Z[�BZܼq<��R��f���uJ�x�h�Im/��� /.�?�D��#ds��u�)��Dͫ��s|j��*�c�V#�u�Y�dytcf���B�(�Q��@h�Rj����F�#5�
<� ��)Ж��� g����+�(�W����y����	˲���D�F-�xC�A��o e��D�7p�ѯ	w>��PY�QL��� ��x�	�Whgʺ�h�XΎ당'-=`�.�o�pV�.`
��PW���Wc����g��Jq�JԀ�(R7F-R|f�t�}t7 ~x�@��e�'��Ta$q�� ڂ�R:#��'0l��a=ND$�����$0�4�P[�����&�����u	�v�Cʩ�6�� �4�5ɦZ�jsЮ�U��13sc踗��C�nZ�����͜#y��Ǥߓ94A��x��¿70���cAYn��~9�����!��v.g_�ZHo�F���Z�'�u����h�=���^��X����qOה�*���	I(E9$q<ؔ��P�A�B�u$&�0��7�&��,O4�<4���EvKjJ�餫 �4�֚�)��Xk�Q��aP�, քǜ6�r9�8y<����,�̓8`��n���63��#
�-�4��#�������V�
*�a������R]��鵛�^m`�a�-�m5[�^�+cV�t��2����;a�9� �͝����1X8ƙ��W�ژ;"�Q�d��[ 52�j���P�y�i0 ���Hp���$b �\�Q����т��X�RB/�V�����ءՋ~����mh$��(��{�A���+�-�����a��P�6?X��3�0�����JAqX�A����na�S���,�!N���7[	#���C茸�.��.$�C��^
ۥ3��p�"���UZ�����|�A���,���C��o`����^ ra1�r�I�<(�1���t�y �v*q0�g�I�V>����p� �.�/`�)d�a�HA�PB���>��d,y���i�s�4�8���4�HO,��h��Fe_�p��շ�~�f6jV��Ez�j����d�;����@�w�Bɺs�0��29���)�䮘G7�q�8%�2�t<g��-�"�K� ���@���;������"�F�$��������É���9jlH3�:K�"�pb�-�Z��������#�ݍ�xƆHh��`q��<df^�2)>uP �I�J\1b7">��
zN6��\�jX �� "X�A'nXk�_i5닠�N�/A�.@��x0��ID��Y�TP�>F��H��5 �\��Ff��\�F�g�G<x@L:2��#���Cd9�����$J��h�%�2a�r�A�N|�F�[���( t&�"��h���%Z��{j�e��� F|�H+��36�X\��A_p��I�L�К�V��$�$^nA �8ʺ>3���C���@�t�+d������CP�MP\�����  �%hٴ�}����c�&��2.�&��!A.� �qO#z~���r�
'R�'Dݒ�C��X��3
�[f�Ѭ������ۥ��:�*b�l��K�RM5���>�t�*�V����������y�>�vrf�� ���(�鷭����x�鷵%|?��>���q4�}`&�Ȅ퀱@�M)��lDX8.�G-�4*f��q��᳄n4'h԰'1����eK�D��KڍF�i��P�|�x��E�H\j�:���M���#X�qiL�F�ˡV�R����G�Ơ�j����Z��ivf�S�T���[�>��5��{n5�-�_�e�^�^�@�f9X�� {/
femG�D�k\�4�b����R5���c���/��A��h[�ٲl��ºݮ��j���~'	
&������S?    !4�H�_�jK�1�~�yw{���Lh����z)Ȫ)��W���{͉Nd&� ��Jæ�ș�r��[��ڡ)XF�Ki��D��R
�GXAT�r)��6�Z�9�N�����2�`� ���F q��D̰.�*�Q�"Ҩ����.H������{`�<֠Aݙpl�1L�[��_��,_�$����@u�Hh}��jY���H��4w#�`��!;���p�b���/��/��i"���U���`�d�����C�.���{.e���kDMKӬ2ͤ���u,i ���_�p�\���#\��
̫�$�,���(D��A,�*���L96I��y5I��O�@NLמR���r"&R�D	����t&�M.�JQ�|BM����9_i:"��b��#Żp�e���D�r�Krg���Y���\G�������uQ��7�����a�����xB;W����u*\�-(�I���5���`  �K�����8蔺�?�@�1h���5����N&S���ڢ����m I"�,@�����jU����qL��n0[mU��R��̀A�N��3���W��T-L�xPU�V�a�����*k×�&�q?���`Vsބΰ��(�N�w`���1J/��CzγknoP�� ������~���^0M�^ ���ߦO��=˻���u)��r���k��w1f!��A2��k"�D�:K8����I�h�wp�K��bx���]�ޫ7��iކq5�������8<��k>���v��l`�0>`�H[��웼��H�ﴷ�r:Q������X�F%�*��ߪRI�.@yP�n�+-+s��j�Ya����G��~���e����-�L�u+_�	���> �F��.X�#dئ;J*|�Ӛ��)g�R���6���ao[��Y�o��[O�8�0U�u<A[>�J' ��YH62@C6��1��[���Yf�-u����Wm�*p�7A%��f4<9cN	�*vŴ�?�o��hvz�~�� ����u	�Z鈇.���`$�0�qy���%'=���-�q�Cɲ�/�-�Ê��y8E[t�7vd�-"(0i� ��99 ����_���w(�9r���!��vˤ[eN�,@�<c����*�X�#��EyP��TʡB|�:��L-sZ�1�/٘ђ���wG�P�=��Ԯ��9�u��JլV�Z�ګW-K���C�I����[�����L�<���-��,�{�S< ���!:o�銝`ܫ���`��cփ͸��<��fF9��' ?5O�	�Dҧ���ap���p��JE�9>�hpi�*b�&$ʍ��)�`H�*����ň�qW�8�5X�,&�g�v0U�(.���6LV�-��"��� \���܅�a�r\��
�[ʅ�3�+x��|��D�S�o-����GP�%8��	������Ĵ>�@+�tՃ�~ ��MQ����1�1����Ɲ�JE�3P*�?1�]#S��/�[���lS�f�� �`�؉貉b8y��i0@��I��'�8��K���	�ڀ}ú���?]�}�/`gc7�l �>y- ��F�R ����?�}���98�����p�/���\^����
A(7���O�NƯB�j����
q��x&�.7=�l�������b���D9(��!~��b9�Q8�gM��#�@?�o���9�&�N�bof��ǐ��.YqU���%����(�M ����uG�n20�"��T�č��#~�L�_LÔ�-��Q0)�q���PT��z��!�k�iUr �	Y!7V�HW�*շ @b*�%m�p��Mϐf���G|���XZ��'i�/ۑ��V(t&�ݟ��f�dHY2/�>89��+���?���4�1���l�#��A?��3��ZC�2�V�M��	������yt?M�rX�?��`����	��,\�9�`� �XZ����K\��AJ +�~�c�Tz�ʯD�
Z�d��*.w�??P���3�]I'��#G'Ń� yL��]��m����El��Q�~��5+-�ҴU��>d�5Ļ$B������Ġ3����X\t��oǬ��Z�#-a�������8N�M:\��7eN��E֥`�2[���줈���p�X���3H�a@���A��N�����1��v�z�."u���k`N���!������eP��#f�v��-2b����gDM��k�z1~����6B��&	H��#
�t_��8J3A�}=���ri�ƥ�_n���Eb��־���]���<���y3ɬ�lx.��;̯F'��"�7 ɾ��R�@�)lj�?C�N���[��2<zۥ�����E����˭��ɺdˇ�t`�-Q|&e���=x�����S&4%���{^�c��Ȝ� R�g:�&�� ��ڭ��������xR�z����E�
H�o�Z��D�T�}h-�ܝ����w!7;GnG�DX�������%��J�ٵ�⼇�P5Ea�"����6JN<9VH�ci?���!�(4�p-�H����#�.�Q���Y{E�[�Q�	2�3�l)N�"O�U�`s�'�t��u������ދ��{P�6�f��BE�|��T�ri��LCZ��RJ�b��;��t9R鳜�r}��;��}�"�$�zD��7n2��ɗ�Dkq���7�2��� ī�f*Ԍ�JP�n��y g.a�KP兺*��Y�Z�\�Z� <��	���@_y��f��}oh V��a�-���s��Π+$��͋��b�~'FP��OC�#��aR�(�"� �` �8�7aݺ�5��	޹���:{ ��;�r�4�|@4�ֲ7�w�d�=vP�CP�M�&������sI�*v���J�o�;���y�$vI��7� �F� ��W�pײ�GwI���>H�B�����*|��W�_&[��S-�u8��~�q�%5��ч�9B~u�8�צ%ئ��3�Uԅ�\���Ԋ%�'%�Ns��#J�i84`N�zwZ���d5��]}���Կ��
$G�^g�
��"��� }�3�����^ޥ��"֑ ���P�9A@W�I�>-H8�����w*���^��(0߅x����J7�cV
���! �/�L^٩\����ZC�|(�?�Y֝5[3������oŚ��X��O����󷐶,n�F�T�Lzre�d����@.��ң��Ye,[��X��.KL^3���ȡ��5 U�>���-�9�g���hf��n��{�,_���vZ�F�:dW�Fcie�{;v��S��,Q�m�T�~οWa'W^��� 3�e`~
/�9)h��]������\LfY$�����6���~H�1�s�X��=�R݋k�X� �{���;��B����t�t���$?g	�Q�9g�L����_&*�V:k���t���屌��3lO.	)�c���
�z����y�S;"��rB����L��ڭ�~@ǉ�}M��l�G�M-H��E�9�bG�q���P~���b��X�]�������~��g;$N�iOr{�)1K6�6>��a�'==6eHL����	�S1t!J&�b��x�ῳpI�H,3��8.��`�#�җ�Cr�sg6g�\O�t��:s ���ŏ�;oGQ0v����p�	G�t��=y�tl/����U�"~�"�q"�b0�9@�E؅B�j���3Xv���w�����_�9��� �L���X�UV�<�V�c��[؄�(��5V����B���z~��<�o�8"����@?,��|�?����}��<�o���Q�`,CM=�Kl��_��/=X���#����@VR��z}_���~�r����b�<�84.\R��!���P�ˮԁ�<Z$j�گպ�v��nc
Q>�C��zI��.^!�zL�bu���V��`�]*�Nʆ�l6콾9ӣZ�˧��/'Bfh��� {K�8�������_��Ӌ����Fb��u".    �x��@/xUVLD�@�s���w��ې� s:�8 A!t��Q�x��(�AD�
�bNa��#*���N"���"7��@D�� ��K��ӻ��=��pC&
V:R���I2�$� �/�����e@��t%H#il�k��q��#���=�_�}�.���|��V�26w����k#�Ced����6���Ĳ�����ɜ���s�� bH��X�,�6��� }��zA������(ʠ�\P��ğ��r�$8r��*��S(�b�j y�<�(G�6F�c��r��
��6iJ\HB9���s�sV�'JD'����Ǜ4�zS�-7���˒�ƚ�����������Q�����ڸ	�l���L+��>H�,qز�~T	#|���qeF��hr�S2�1�C� ���l�l�@�d6�i��w�õ��F�>���-��M2��(.�-�wʬ{�\ ����9��7
�[֙���R����{0(Ko@�K�?�C�1V��c��Hr��f�Ѭ��G�Q�q �pL���nAwm˔re(��C�Qt�w}/($[�����$p�s�\�!��U�8��?�f��n����t����Y��}O&�p�?*:d����#6芏8��	Ë���>'�8�b�(6���ah�� e�{<l��QG��1���q<=�-B��5��N� +��z�m���l�h�F���� �2NOO����?�V���p?���,�O{�?�zT ��o3��� ����z���9p��`[���H�)������#��X�J�CDgL�M�0f,1��)�8�/r��e�����o�\:�\:��ۛS�|�!��~�ڬ6�f��v��L��5�p(�Z������l�Z�n��V'ӂ�X,P��#��㷹c���h�hļ�îת��xI�����u5��&I7nK"�r~�=��8��"2k�ˀT?��P(��A����6�����a�}��)k'�R��K�%&�]
��ܱi�}��.ёuóL9�j ���4d���╈�O�)�%��Qzmq$�RE�k�"�R�aEYi�[@�f#�\,

t�ޒ\�&��k���L�[�� �� ��r��zB�M��e��r� k�/s=Q��f!�ps���F�)l�|E]�J���Az����*Y�( ?�h|O֧�bX�2�a�E e�����0�g���k�'cX��=_�0��$iL�z�#1���H_�S ����ȮشdY�E��zV��:���)������;��8:���O��ź�α^�BD�L���i���;���I�j���;̮(˗n,@�磙��,&72�6��d��p�{���k%��<����̛3^�g�
X�����xAA�a/ql�
[~aU�ئ7�iW�Z>6���|XS���@`t W�wgk�Ē����R~���7�jJ�c��rif�P� T�+��x�U���	�]�����Px�L�>��<T@i�aoݣ�!�Ι� �lP�R�7��r��ӧ�ͧ��~�CIR
���|�kx��^|ƶ�!�9��ܝ��:������ų��YC=��ĉ�eA-�[i��7�ٽ>ey�>���?x� ?8�4�{Y J��<Я�C����)��f��Jv�|�8���"�)��[�.*UXsÇ���C֟,AAzD3����/�_a�Pߨ��h '��|�9((�wܟ��p���ުr�.0�W�����Z/�î��L��z��7e�x���կI�]�.[����mW�#�uPT=��� _=�W���y0UWf����z��/>�Y=s?��r�u�5����]�c댺���^akY��0v`(�C!��\�o����Ӂ;���o]��W+��_�N�mw!����{���Ö���}K���
�W������9�r�4���>�@�~�\�/A"9�c8w��HM�!o_���#�@ć	l��Nh9�w�
xP/����[�Au����Pd��{�O?�������У��	pؗ��xjy�u/l��o�ɼ�S��y�>���?�C9u��e U_ͯޣ 2UL�{�,���Q�*mIM�i�>@��-��V,!�t8H��f�;�L�� �W�����D|SmT��f�������J�Z����I�M�+J,q������ �����06U������ �s�׳/��0	~V�r���3=���U¹}#�#��Ϩ��,7��"ޯd�1�y��xչ�����IH��%Z���d��'�C��+*��Yd敩��J��x�ʺ��ū��q�x@��d��n��c�-�^H�A�� Y�u�NX^2�����2"�#��ʪ�yc�\=UƆC�a��v.���ʱ���\������֠�eĴ*ZT!��bV��Je��E �匣��rԉ�=�P��Ao�(W�_��Ha<u�{�������0�jA��RХ�j9�0�֍֗��]:.D��Kj>J��X��!��K�4��=@��ۡh�#��X)�Y*Mِ}U�N}�>n�B���Y̝Q!�*WY���iCt���p\5EV�?�[�O���������$���`#t>N��h!�}и�=(�޵�'c�[Y�oP���m��m�ѿv�v���7��κf�]�n^��#�z+��/���c�Z0[kY]�mCd����Q��ZKHU=7�AZ�H�{�O�G#��ED��|��2Fmls��B01>A%h㝚l����S��0Ӄ��k;Un���֮|Y��F	����o�N��畕�U�\��z�b5[���i��Z�A�Ѷ�U����v�۫�ݚD��6�$� T�=Ķ!��-%�E�r�fc*�M��l���_�+�";�IW#΀導��-�s��΢r�"K�
�(H2�����Mԇ/���gϊU"nAH6�;�R�L��W1ۨ͟b��ʿ;Zn�-��M�Q�}܎����]KnE�|��mC���srۿ?��lKB�|������ǆ�����n��\[��]�lr ��T����t	���ު\���,08P'��b+�GU��v����ejd������V�."���AU��+�K�d��^�T����,�쮰�����T�S�u9(�S|���G:g~��12���s������3��;��Qn?��<S�0��.t�q�����;g�J��|�(� |FW�*Ơ�D�9E	$ڬ�i�c����m/�	"c�[���i5ך��h��p ���+j�f�1�G�
�2ʐ	
�䠚���`-�������AN�MV# ����(t�´��C����2y�����RJIwf�vf`�0pgޮ�S��4Jݹ�NB��+B�J��`�&y:���֪������� c�a�iT\.�� �"ֱZc��9"���FV�XE�uo�@ ʷ���0�7��t?
t��h~��-qh���
:,��)��˻$��d�N�Tފ(KM"�7)N!��ΕZ�����ӣ�Q�}8z[f�o���n����4�Z�Qֹ!��p�e�E1gM6Y@�	�/�����b��!TV��1G�6
N�-V[�q�ć��fQ^�}Оƀ(��)H�S� �>�@Ũ�wNB-��R�C���"���U�5[��:8��6������~Ќڠ��83��HW,B�h9�<���>́j֓�h ����g�CY�;�8j���u�6��O�{�l���]Ov6���&�N�@XfC��:h�L}����r`�.ʐ��+�����ź���×�pp�n҅s�8�����H�Q�g߫��a�������zikW�Ċ��&\^��̖��o�z�K�kQ���nzGi$�1n(�5�,X�;M��a~$F/��E�D9�F�����,��=܅0��(��Q���j�l4k�����*�1�����8�ib�1&&yZ�L/��p����a� 	�ܓ(���l�'h�J~[O�Y��:�67N�|F�U]S��Q�>�ed��n��I�1��	���CMV��Z�Z�A�\���Zt�?�s��Q4Z�'��Y�ubJ�)��� %|2�u"v�Y�w�c��u��%����    |
|�~�~KPo�g��B�R�����v�F4�j����>(`���$�����;��'$
rx�5\�b�:��� �֐�i���
��rJО�{8P67�ؾ�`؎�`,���>���~≂9�{r�l�hB�g��#�DfX�þ�x�q��fF��xq�B	cEK��=��9Bt��:�d�����םӽU͢T��b�O�b?�ƶJCu���+Қ�̕
&UĲI�\ �HM�	""l���%����TT�G��e��͞[���ݾ��(�]�S_Ťg9�{O�Ih:�W�c���ެ�@a}L϶Kk�� �O�bL���œ,c��N�C�\|&p�(�k��Gx79_ �^�1M0O.��Pk�.Ԉ�*�iʶ���jW��J��N.B@�]��=\�R�Zj?�;|y�ʮf����^�\\�ˑ+<��P����x�x���aY�-��d�O�
)Vu�p�&QjU���v���ps�we�]�����{�+���p�U+���dB� �Zo9���׵]]Sr�z��Z�N���\�G1�j<O��1�a�J�P�V�rUb�9�k"l��t+t?9��L���!�t����̤'�|3e6�L
� ��X���e,|�_�zBYA�����G�s���!�a��P��(�GW�-Y��ϟ�̞�VxK�	���ٴl|Z�n�Moz3,�6u�R�^Y� +��`�7D%l��e����5�V{̨?�Ӹ�}gV�t՛�ņ��㭥�s#���v�[�O�.̮���X��@�(�S���?�.�*ة��	/�s��!`�?�^��}T�k#��5�j�u�X[G��j(�j�*��80k�*W5��U;�bU���������>{;`���ӷ'��!k��ԧ��;�b�?9>m�c/Y�3<���ާE�c�K�`wN���Z�/��d��\��"�g�ưR���Ez]
6	��S���@�̽4Ɂ\���� ���􇲅W�)J<�G���S9SD�K�]�˪S�ѫ7�F��9�݀!��15�%+ �0iF�TVm�eyQ��
��6��P8�5� �B����"�(X�ѥ
��GK55e��	�!�@��k6���A$M�-�\;���gu7�����|97M(8��O�3NH�T��'b�A������qP h��Z��� ֠u�ζ��� ���x����@F�.��~�cᮘy`3����__�RUUw����X<��� �ؐ)��p�j�*
`�d�Hf��w�NV3/�
?S7�;qqs#sb�E4�)ѽ������v��Sp�4�魼�
JY=t��O`�Uy<O��%���¹��E~�I�\W�-���Ji��̃:�լC�s]@���a#�.��TE֌�[%�G@�B(a+i��e&P��E�ςU�@�ܤ�{5�0{S��F��hc�^�;�T�z� 4�g�ﻄ�J,Wi�T�Xc$����a��p�U���V}J��͓���y�ͽ��8�\�Q���cLF�3q�GGS���vf���W�$	-��u��F����l��u�l��'C�E���*`��_��@^���ݭ\�u��:���?}�����!��l� ����>w�g�@ӫ4"�8������U���]����T�Zf�n4��Vw�AL��l9�^.l�[�>�Ry��0\w����vV���?�Z�=������*���miRŕ�T(�KR�)��l�pi'A�"e�@Ț�w�@=�n���������O��d.be;��@a������({�pg]�Y ��K�ep�~��w jMm��;A�^���;���S������v�u�X��`��gm�"@��ќ�� ��U:�Ñ�$�}Z.j�^���}���
��^!�P6��B��J��cg%/�&ۃη�n�����4��1`kZ�ځ9���j>Ͳj�J[�WB�
X��nO$!�<�E�˄N�7��i24]�ι�c|�M����w1tr��vg䶜}�樐�Hy~
�nպQ�Ү�{yT7Do:�u�=�)�UVw�hZ�ۿ'�6��ȃ	�qaq�:���@ܧ�;Q���R�`J�dˎD`��C`K�pO8Y�N59>��{X�/WVx3��ت	;>����us׎Mv[��C�Y�&�^�7�_�cߏ����-�FxՅ}�]�A�9T�8b�4�E�c��1o�F�m<��o�:�	}f�ͻ�d�32��x�`�X����+��<c.O%�y���jܣ@��a^����{��e�}�^imc�����cIoO��|��i['��D����i!w�� ��<�60[M��S�Tyz����� h>{��z6����9�v���&MW�����2�Bbg��c��S �=ݱw@���-��:��%>�
��-f�Nu�n���%��x7Udښ�v�����F��PMb"��wE�X��V�������0߱^M̆��1nJ�����
/
��aE��|�m�=���E��0k�CEA��7l5ĝ�* JA*�T2�y\����F|V�r�=���]~�����D2<��]WK�>OX�����i���(��e�t�*K	굻V55�(�nn��Px"�S��V�5�77 ����Kz��g�5n;����4��j�aZ� L|B�z��ql��Q��K�x�k�e�>�AD��
6&�.�����7/
�خRl3X�.�C�!ڰ����ql���*ٮ 봭J�mu��s�m�Zo ��u�Z��?;����>e'�?���}7쳳���l����~S�a��IN�Q�E����.����WF��ߡ[��be\����+ߘ��e]dp��Ұ�Vk�G�����u��e[�ʠ[�u;=�z)�0,j�j�뒠�gY�e�K9�A+�ȱv�g��c�'˓a8�}��2�:ִ�Uk��h��V�� �(�Vcd�)������ޤ�*��j�^��c�Mʦ���e�x�턆z��dJ�W��5����0�9���"&Kr���n���e��}��X��x���p	܋��S�(\`��3�0����:�p���7"��Z��r�>P{5|V���c��g�%Z ��?�K��xΧ��`3�M��`W�H�; ���TAp�v���n4:_� �l����U٣fb<�nQ'I|����u�EE�uF�AYw�]G��y��������D�%~@��{"��C�ō��J	�S0u+��u������R����|���q��7L��,F��f߷O�C���~���Ώ�W����?u�v�Ʒ��fVe������߽��OK;W����AmVrT�l�rf�5Ԛ�(]s�����/��&��q���jZ�Z������T�V�ݪ���7k�V}Ъ5��:�Viþ��n��jE!B>^��؉�ִ�.�F���౪mq[�Xq~�����?���XMp�RUi�5���A����V��}��v��zê���� �_E�\ ��	'SG�r�,��;����[�E����inj#�&�pU�n�v��wk�%�a��0�N������\KB�W9�{����hsw��i�%:QR0qXg�qhRUP�*��J��6h
�&��̲7�mUڭ�jްKCLco�`~G�K��f����Ĕ�̤DĠ� �-3���76��]�-��R����`�]�?b�_��
����`��ı�ቸ��$��#W$��`Z��%[�z��7>��0�'p��:�Q} P�-�-H�{4:��A��Ɵ�:�EA���GG����cmWXc*�Q��E�Ѓ<Я$����%��K�:��,�]�\�����L��#���`gA�BZ�>�]|�߇%�%O���� �L�MC\~Y�q����X�,Jπ!z�f�������Z� v�ڙ6�u��	/*L�O@��.�6�#son�-0AU�9���>�"�ڈ&�����_}�+6U���`1z!�W�h���\�>�3|}ZkLPh�0�)M �=� Y�n�=������ݨ��"� ��8 d�����3��*񯀗��@�g��   ˑ��ܙ;�BsR�L@�Q3n57��Z�e�w�#�j��iV��^��C	��Vk�*�nKi3�j��y��� (�!_�ol[�?v�#\MhDr��� M%{�X�a{�җ����F�t��
���<q;�N����n^��'n��ՠR?�m�� �zi�G2\P���RDs͵#�Z��Q�L�R�����W�&��]�j70a9ƽ��L�R;J (��s���y��`i����^�X�k�3'�4VP�����Ȩ �,�1��b��dS��l$X�聮s��+�aY�L]w��c��������_TAZ�f�2^�P�m�Z�`b��:F�d�w��uii��3�no�Qk�۠8�ki?=��|w�<A��ѰA/�踫���S�U6�"i�q�c����9���v�3��>Z\�����Ae��4i�+�"����;�9h0�LH���eݍ_ ���l� �bUx"���;�qI ҁ�g�h
�
ol�U��=�=�?�=P�*�'��IUSv�{wz�#��-~�7�=`,L�{?�{y
��[�R:��MB�J�t�TJX�=����n������F��n��no
$��ҫ�����|V���r�1��E<��l��I��0^��(�%7��י�0
cN���WM�f��j�w@����Y��UkZ69u�v�^����RÛ�R��p�@T<h��N�N�$ 3LΓ`�E���Z���Z�d��nF��ic'�����V�evz=�T�6d�O���?OF��      �      x������ � �      l   x   x����@��c��^p]*0M����L2Ʉ�o�o4�LiX��D\fb�#� *y�SV�8��"�I��_��ʅ�,l^�m¨�T�D'z�0�<=���g1>2'&�p�k���8*     
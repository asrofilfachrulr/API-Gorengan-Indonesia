--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-0ubuntu0.23.04.1)

-- Started on 2023-11-04 20:27:56 WIB

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
-- TOC entry 13 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 275 (class 1259 OID 28571)
-- Name: auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth (
    user_id character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.auth OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 28643)
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id character varying NOT NULL,
    recipe_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 28599)
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients (
    recipe_id character varying(255) NOT NULL,
    qty character varying(255) NOT NULL,
    unit character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.ingredients OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 28610)
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    recipe_id character varying(255) NOT NULL,
    user_id character varying(255),
    stars integer NOT NULL,
    comment character varying(255)
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 28609)
-- Name: ratings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ratings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ratings_id_seq OWNER TO postgres;

--
-- TOC entry 3769 (class 0 OID 0)
-- Dependencies: 278
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- TOC entry 276 (class 1259 OID 28585)
-- Name: recipes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recipes (
    id character varying(255) NOT NULL,
    author_id character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    img_url character varying(255) NOT NULL,
    difficulty character varying(255) NOT NULL,
    portion integer NOT NULL,
    minute_duration integer NOT NULL,
    star_rating character varying NOT NULL
);


ALTER TABLE public.recipes OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 28628)
-- Name: steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.steps (
    recipe_id character varying(255) NOT NULL,
    number integer NOT NULL,
    step character varying(255) NOT NULL
);


ALTER TABLE public.steps OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 28560)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    image_url character varying(255) DEFAULT 'https://placehold.co/200x200?text=\n'::character varying NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 28662)
-- Name: user_auth; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_auth AS
 SELECT users.id,
    users.name,
    users.username,
    users.email,
    users.image_url,
    auth.password
   FROM (public.users
     JOIN public.auth ON (((users.id)::text = (auth.user_id)::text)));


ALTER TABLE public.user_auth OWNER TO postgres;

--
-- TOC entry 3572 (class 2604 OID 28613)
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- TOC entry 3751 (class 0 OID 28571)
-- Dependencies: 275
-- Data for Name: auth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth (user_id, password) FROM stdin;
@id_userBPqBoCh_xILbpXln474bD	$2b$10$OcLMbxWRlLM/7H37wUMUKOnQgZ5jq.cGa03VbF.ZBuVmCsVUQhS6q
@id_userEW3XETwzatHLUsLIhpdh8	$2b$10$4jUiUHpqnR2mkdQSXcLGmOaQHu9ok1eN5maPV13E2jWb8RoNgVHGW
@id_user3HceBhx_jIfB_Xd5_04MU	$2b$10$dCd22v9KIxcq6weDLuccyOVbY.Mcz2TsQPPJTPQRpVSxDhfLF//uW
@id_user--E2er8FtN-4hyFIBgzfd	$2b$10$Y0paW4X6wiJYH1Yjz3kc8uWZS53qpNElFkm4Np5wpgwC1makOIM5K
@id_user52nNBdoEinsLnYkhzHPcX	$2b$10$cCtXZxmIAFjZpo01ejYTA.nxMkNotwQ7VQIzwSAJRoSuFJxU.cwme
@id_userUIjuDuhJ_QnJbdiA_z1F_	$2b$10$G0eNR0hBVxJoMXuLBJyPS.AAzXekMmOIgR1EDeCC75QWQ1DTSHTVG
@id_userk3a8NtJBKgCPSkPPSaBaA	$2b$10$bBTpBjUEcPxPCFDyma1mce1SxqHCJfqrEFlSTjqRU.hB.Dj.WZpWG
\.


--
-- TOC entry 3757 (class 0 OID 28643)
-- Dependencies: 281
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favourites (id, recipe_id, user_id) FROM stdin;
\.


--
-- TOC entry 3753 (class 0 OID 28599)
-- Dependencies: 277
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredients (recipe_id, qty, unit, name) FROM stdin;
receipt-1	250	gram	tepung kanji
receipt-1	2	siung	bawang putih, haluskan
receipt-1	½	sdt	garam
receipt-1	¼	sdt	gula
receipt-1	¼	sdt	kaldu bubuk (opsional)
receipt-1	200	ml	air
receipt-1	2	sdm	minyak goreng
receipt-1	3	sdm	saus sambal manis (untuk bumbu pedas manis)
receipt-1	1	sdm	saus tomat (untuk bumbu pedas manis)
receipt-1	1	sdm	kecap manis (untuk bumbu pedas manis)
receipt-1	1	sdt	gula (untuk bumbu pedas manis)
receipt-1	½	sdt	garam (untuk bumbu pedas manis)
receipt-1	1	sdm	air (untuk bumbu pedas manis)
receipt-2	200	gram	tempe, potong tipis
receipt-2	150	gram	tepung terigu
receipt-2	2	sdm	tepung beras
receipt-2	½	sdt	merica bubuk
receipt-2	¼	sdt	garam
receipt-2	200	ml	air es
receipt-3	4	buah	pisang, potong sesuai selera
receipt-3	150	gram	tepung terigu
receipt-3	50	gram	tepung beras
receipt-3	½	sdt	garam
receipt-3	2	sdm	gula
receipt-3	200	ml	air
receipt-3		~	minyak goreng
receipt-4	4	buah	kentang, potong sesuai selera
receipt-4	150	gram	tepung terigu
receipt-4	½	sdt	merica bubuk
receipt-4	½	sdt	garam
receipt-4	½	sdt	bawang putih bubuk
receipt-4		~	minyak untuk menggoreng
receipt-4		~	saus pedas sebagai pelengkap
receipt-5	200	gram	tepung beras
receipt-5	50	gram	tepung terigu
receipt-5	100	gram	udang, kupas, cuci bersih, dan tiriskan
receipt-5	150	ml	air es
receipt-5	2	siung	bawang putih, haluskan
receipt-5	1/2	sdt	garam
receipt-5	1/2	sdt	gula
receipt-5	1/4	sdt	kaldu bubuk
receipt-5		~	minyak untuk menggoreng
receipt-6	150	gram	tepung terigu
receipt-6	200	ml	air
receipt-6	2	siung	bawang putih, haluskan
receipt-6	1/2	sdt	garam
receipt-6	1/2	sdt	gula
receipt-6	1/4	sdt	kaldu bubuk
receipt-6	1/2	sdt	garam
receipt-6		~	tauge
receipt-6		~	wortel, potong korek api
receipt-6		~	kol, iris halus
receipt-6		~	daun bawang, iris halus
receipt-6		~	minyak untuk menggoreng
receipt-7	500	gram	ubi jalar, kupas dan iris tipis
receipt-7	150	gram	tepung terigu
receipt-7	1/2	sdt	bawang putih bubuk
receipt-7	1/2	sdt	garam
receipt-7	1/4	sdt	merica
receipt-7	150	ml	air
receipt-7		~	minyak untuk menggoreng
receipt-8	500	gram	kentang, kupas dan rebus hingga empuk
receipt-8	200	gram	daging ayam cincang
receipt-8	2	siung	bawang putih, haluskan
receipt-8	4	btr	bawang merah, cincang halus
receipt-8	1	btr	telur
receipt-8	1/2	sdt	garam
receipt-8	1/4	sdt	merica
receipt-8		~	penyedap rasa ~
receipt-8		~	minyak untuk menggoreng
receipt-9	4	buah	tahu, potong menjadi kotak-kotak kecil
receipt-9	150	gram	tepung terigu
receipt-9	1/2	sdt	bawang putih bubuk
receipt-9	1/2	sdt	garam
receipt-9	1/4	sdt	merica
receipt-9	200	ml	air
receipt-9		~	minyak untuk menggoreng
receipt-10	250	gram	tepung terigu
receipt-10	100	gram	mentega
receipt-10	50	gram	gula
receipt-10	1/2	sdt	garam
receipt-10	1	btr	telur
receipt-10		~	selai nanas
receipt-10		~	minyak untuk menggoreng
receipt-11	250	gram	tepung terigu
receipt-11	1/2	sdt	garam
receipt-11	1	sdm	gula
receipt-11	1/2	sdt	bawang putih bubuk
receipt-11	2	btr	bawang merah, cincang halus
receipt-11	1	btg	daun bawang, iris halus
receipt-11	200	ml	air
receipt-11		~	minyak untuk menggoreng
receipt-12	150	gram	tepung kanji
receipt-12	100	gram	tepung terigu
receipt-12	1/2	sdt	garam
receipt-12	1	sdm	gula
receipt-12	1/2	sdt	bawang putih bubuk
receipt-12	2	btr	bawang merah, cincang halus
receipt-12	1	btg	daun bawang, iris halus
receipt-12	200	ml	air
receipt-12		~	minyak untuk menggoreng
receipt-12		~	telur ayam
receipt-13	4	buah	tahu putih bulat, belah dua
receipt-13	150	gram	tepung terigu
receipt-13	1/2	sdt	garam
receipt-13	1/4	sdt	merica
receipt-13	200	ml	air
receipt-13		~	minyak untuk menggoreng
receipt-14	500	gram	sukun, kupas dan iris tipis
receipt-14	150	gram	tepung terigu
receipt-14	1/2	sdt	garam
receipt-14	1/4	sdt	merica
receipt-14	200	ml	air
receipt-14		~	minyak untuk menggoreng
receipt-15	2	buah	apel, kupas, buang biji, dan potong menjadi irisan setebal 1 cm
receipt-15	150	gram	tepung terigu
receipt-15	1/4	cup	gula
receipt-15	1/4	sdt	garam
receipt-15	1/2	sdt	kayu manis
receipt-15	1	btr	telur
receipt-15	200	ml	air
receipt-15		~	minyak untuk menggoreng
receipt-15		~	gula bubuk atau kayu manis bubuk untuk hiasan
receipt-16	4	potong	roti tawar, potong menjadi bentuk bantal
receipt-16	2	btr	telur
receipt-16	50	ml	susu
receipt-16	2	sdm	gula
receipt-16	1/4	sdt	garam
receipt-16		~	minyak untuk menggoreng
receipt-16		~	gula bubuk atau topping sesuai selera
receipt-17	2 1/4	sdt	ragi instan
receipt-17	120	ml	susu hangat
receipt-17	2 1/2	sdm	gula
receipt-17	500	gram	tepung terigu
receipt-17	1/2	sdt	garam
receipt-17	1	btr	telur
receipt-17	3	sdm	mentega
receipt-17		~	minyak untuk menggoreng
receipt-17		~	selai strawberry sesuai selera
receipt-17		~	gula bubuk untuk taburan
receipt-18	150	gram	tepung terigu
receipt-18	100	ml	air
receipt-18	2	btr	bawang merah, cincang halus
receipt-18	2	siung	bawang putih, cincang halus
receipt-18	1	sdm	gula
receipt-18	1/2	sdt	garam
receipt-18	200	gram	teri, sangrai
receipt-18		~	minyak untuk menggoreng
receipt-19	250	gram	tepung ketan
receipt-19	100	gram	gula pasir
receipt-19	5	lbr	daun pandan, dihaluskan
receipt-19	100	gram	gula merah, potong kecil-kecil
receipt-19		~	minyak untuk menggoreng
receipt-20	150	gram	tepung terigu
receipt-20	2	siung	bawang putih, haluskan
receipt-20	1/2	sdt	garam
receipt-20	1	sdt	gula
receipt-20	1/4	sdt	merica
receipt-20	2	btg	daun seledri, iris halus
receipt-20	1	buah	wortel, parut halus
receipt-20	100	gram	tauge (kecambah)
receipt-20	200	ml	air
receipt-20		~	minyak untuk menggoreng
receipt-21	12	lbr	kulit lumpia
receipt-21	200	gram	sayuran (wortel, kentang, buncis), rebus dan potong kecil-kecil
receipt-21	1	btr	telur, rebus dan potong kecil-kecil
receipt-21	1	sdt	garam
receipt-21	100	gram	tepung panir
receipt-21		~	minyak untuk menggoreng
receipt-22	100	gram	tepung terigu
receipt-22	50	gram	tepung beras
receipt-22	200	gram	jagung pipil (manis atau biasa)
receipt-22	1	sdm	gula
receipt-22	1/2	sdt	garam
receipt-22	2	btg	daun bawang, iris halus
receipt-22	200	ml	air
receipt-22		~	minyak untuk menggoreng
receipt-23	150	gram	tepung beras
receipt-23	50	gram	tepung terigu
receipt-23	2	siung	bawang putih, haluskan
receipt-23	1	sdm	gula
receipt-23	1/2	sdt	garam
receipt-23	1/2	sdt	ketumbar bubuk
receipt-23	200	ml	air
receipt-23		~	minyak untuk menggoreng
receipt-24	250	gram	tahu (gehu)
receipt-24	100	gram	tepung terigu
receipt-24	2	siung	bawang putih, haluskan
receipt-24	1/2	sdt	garam
receipt-24	1/4	sdt	lada
receipt-24	200	ml	air
receipt-24		~	minyak untuk menggoreng
receipt-24		~	saus cabai atau saus sambal sebagai pelengkap
receipt-25	150	gram	tepung terigu
receipt-25	2	siung	bawang putih, haluskan
receipt-25	2	siung	bawang merah, haluskan
receipt-25	2	btg	daun seledri, iris halus
receipt-25	1/2	sdt	garam
receipt-25	1/4	sdt	merica
receipt-25	1	btr	telur
receipt-25	200	ml	air
receipt-25	2	buah	daging sosis, potong-potong
receipt-25		~	minyak untuk menggoreng
receipt-26	250	gram	tepung ketan
receipt-26	100	gram	kelapa parut
receipt-26	2	btg	daun bawang, iris halus
receipt-26	2	btg	daun kemangi, iris halus
receipt-26	1/2	sdt	garam
receipt-26	1/4	sdt	merica
receipt-26	200	ml	air
receipt-26			sayur oncom
receipt-26		~	minyak untuk menggoreng
\.


--
-- TOC entry 3755 (class 0 OID 28610)
-- Dependencies: 279
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ratings (id, recipe_id, user_id, stars, comment) FROM stdin;
\.


--
-- TOC entry 3752 (class 0 OID 28585)
-- Dependencies: 276
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.recipes (id, author_id, title, category, img_url, difficulty, portion, minute_duration, star_rating) FROM stdin;
receipt-23	@id_user--E2er8FtN-4hyFIBgzfd	Peyek Kacang	Buah	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_kacang.jpg	Mudah	4	45	4.5
receipt-24	@id_userUIjuDuhJ_QnJbdiA_z1F_	Gehu Pedas UGD	Kedelai	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/gehu_pedas.jpg	Sedang	4	45	4.5
receipt-26	@id_userEW3XETwzatHLUsLIhpdh8	Combro	Isian Sayur	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/combro.jpg	Mudah	4	45	4.5
receipt-25	@id_userEW3XETwzatHLUsLIhpdh8	Sempol Chicken Kentucky	Aci	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/sempol.png	Mudah	4	45	4.5
receipt-1	@id_user52nNBdoEinsLnYkhzHPcX	Cireng Pedas Nuklir	Aci	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cireng.jpg	Mudah	3	30	4.75
receipt-2	@id_userUIjuDuhJ_QnJbdiA_z1F_	Tempe Mendoan KFC	Kedelai	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/mendoan.jpg	Mudah	6	30	4.2
receipt-3	@id_user--E2er8FtN-4hyFIBgzfd	Pisang Goreng Starbucks	Buah	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/pisang_goreng.jpg	Mudah	10	30	4.1
receipt-4	@id_user--E2er8FtN-4hyFIBgzfd	Kentang Goreng Istana Negara	Kentang	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/kentang_goreng_pedas.jpg	Sedang	40	45	4.3
receipt-5	@id_user52nNBdoEinsLnYkhzHPcX	Rempeyek Udang Cak Owi	Ikan	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_udang.jpg	Sedang	20	45	4.2
receipt-6	@id_userUIjuDuhJ_QnJbdiA_z1F_	Bakwan Sahabat Kolesterol	Isian Sayur	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/bakwan.jpg	Mudah	10	40	4.0
receipt-7	@id_user3HceBhx_jIfB_Xd5_04MU	Ubi Jalar yang diberi Tepung	Manis	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/ubi_jalar.jpg	Mudah	5	40	3.8
receipt-8	@id_userEW3XETwzatHLUsLIhpdh8	Perkedel (Persatuan Kentang dan Telur)	Kentang	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/perkedel.jpg	Sedang	7	40	2.9
receipt-9	@id_userEW3XETwzatHLUsLIhpdh8	Tahu Isi Harapan Rakyat	Kedelai	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/tahu_isi.jpg	Mudah	8	30	4.9
receipt-10	@id_userBPqBoCh_xILbpXln474bD	Molen	Manis	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/molen.jpg	Sulit	10	40	4
receipt-11	@id_userEW3XETwzatHLUsLIhpdh8	Cimol	Aci	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cimol.jpg	Mudah	5	40	4.0
receipt-12	@id_user52nNBdoEinsLnYkhzHPcX	Cilor	Aci	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cilor.jpg	Sedang	3	45	4.2
receipt-13	@id_user52nNBdoEinsLnYkhzHPcX	Tahu Bulat Digoreng Dadakan	Kedelai	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/tahu_bulat.jpg	Sedang	3	30	4.6
receipt-14	@id_user52nNBdoEinsLnYkhzHPcX	Sukun	Buah	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/sukun.jpg	Mudah	2	45	4.1
receipt-15	@id_userk3a8NtJBKgCPSkPPSaBaA	Apel Goreng Pak Newton	Buah	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/apel_goreng.jpg	Mudah	4	30	4.3
receipt-16	@id_userk3a8NtJBKgCPSkPPSaBaA	Roti Bantal Tidur	Manis	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/roti_bantal.jpg	Mudah	4	30	4.5
receipt-17	@id_user3HceBhx_jIfB_Xd5_04MU	Donat Strawberry	Manis	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/donat_strawberry.jpg	Sedang	12	60	4.5
receipt-18	@id_userk3a8NtJBKgCPSkPPSaBaA	Peyek Teri Ma Kasih	Ikan	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_teri.jpg	Mudah	4	45	4.5
receipt-19	@id_userEW3XETwzatHLUsLIhpdh8	Onde-Onde Jakarta	Manis	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/onde_onde.jpg	Mudah	20	60	4.5
receipt-20	@id_user52nNBdoEinsLnYkhzHPcX	Ote-Ote	Isian Sayur	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/ote_ote.jpg	Mudah	4	45	4.5
receipt-21	@id_userBPqBoCh_xILbpXln474bD	Risol Sayur	Isian Sayur	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/risol_sayur.jpg	Sedang	12	60	4.5
receipt-22	@id_userk3a8NtJBKgCPSkPPSaBaA	Dadar Jagung	Isian sayur	https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/dadar_jagung.jpg	Mudah	4	45	4.5
\.


--
-- TOC entry 3756 (class 0 OID 28628)
-- Dependencies: 280
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.steps (recipe_id, number, step) FROM stdin;
receipt-1	1	Campur tepung kanji, tepung terigu, bawang putih, garam, gula, dan kaldu ayam bubuk (jika digunakan) dalam mangkuk besar.
receipt-1	2	Tambahkan air perlahan-lahan sambil terus diaduk hingga membentuk adonan yang kental dan elastis. Pastikan tidak ada gumpalan.
receipt-1	3	Bentuk adonan menjadi silinder panjang dan potong-potong menjadi bagian berukuran sekitar 5 cm.
receipt-1	4	Panaskan minyak dalam wajan hingga cukup panas. Goreng cireng hingga kecokelatan dan mengembang, sekitar 4-5 menit.
receipt-1	5	Angkat cireng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-1	6	Untuk bumbu pedas manis (opsional), campur semua bahan bumbu dalam mangkuk kecil dan aduk rata.
receipt-1	7	Celupkan cireng dalam bumbu pedas manis atau sajikan bumbu tersebut sebagai saus.
receipt-2	1	Campur tepung terigu, tepung beras, merica bubuk, dan garam dalam mangkuk.
receipt-2	2	Tambahkan air es ke dalam campuran tepung sambil terus diaduk hingga membentuk adonan yang kental.
receipt-2	3	Celupkan potongan tempe ke dalam adonan tepung.
receipt-2	4	Panaskan minyak dalam wajan dan goreng tempe yang telah dicelupkan ke dalam adonan tepung hingga kecokelatan dan renyah, sekitar 3-5 menit.
receipt-3	1	Kupas pisang dan potong sesuai selera.
receipt-3	2	Campur tepung terigu, tepung beras, garam, gula, dan air hingga membentuk adonan yang kental dan melekat pada pisang.
receipt-3	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-3	4	Celupkan potongan pisang ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.
receipt-3	5	Angkat pisang goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-4	1	Kupas kentang dan potong sesuai selera.
receipt-4	2	Campurkan tepung terigu, merica bubuk, garam, dan bawang putih bubuk dalam mangkuk.
receipt-4	3	Celupkan potongan kentang ke dalam adonan tepung hingga rata.
receipt-4	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-4	5	Goreng kentang hingga kecokelatan dan renyah, sekitar 5-7 menit.
receipt-4	6	Tiriskan kentang goreng di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-4	7	Sajikan kentang goreng dengan saus pedas sebagai pelengkap.
receipt-16	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-5	1	Campur tepung beras, tepung terigu, udang, air, bawang putih, garam, gula, dan kaldu bubuk dalam mangkuk hingga membentuk adonan yang kental dan melekat pada udang.
receipt-5	2	Panaskan minyak dalam wajan hingga cukup panas.
receipt-5	3	Celupkan udang ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.
receipt-5	4	Angkat peyek udang dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-6	1	Campur tepung terigu, air, bawang putih, garam, gula, kaldu bubuk, dan garam dalam mangkuk hingga membentuk adonan yang kental.
receipt-6	2	Tambahkan tauge, wortel, kol, dan daun bawang ke dalam adonan. Aduk rata.
receipt-6	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-6	4	Ambil satu sendok sayur adonan dan goreng hingga kecokelatan, sekitar 3-5 menit.
receipt-6	5	Angkat bakwan dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-7	1	Kupas ubi jalar dan iris tipis-tipis.
receipt-7	2	Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air hingga membentuk adonan yang kental.
receipt-7	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-7	4	Celupkan irisan ubi jalar ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.
receipt-7	5	Angkat gorengan ubi jalar dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-8	1	Kupas kentang dan rebus hingga empuk. Haluskan kentang yang sudah direbus.
receipt-8	2	Campurkan kentang yang sudah dihaluskan, daging ayam cincang, bawang putih, bawang merah, telur, garam, merica, dan penyedap rasa dalam mangkuk hingga merata.
receipt-8	3	Bentuk adonan menjadi bulatan dan pipihkan.
receipt-8	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-8	5	Goreng perkedel hingga kecokelatan, sekitar 3-5 menit di setiap sisi.
receipt-8	6	Angkat perkedel dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-9	1	Potong tahu menjadi kotak-kotak kecil.
receipt-9	2	Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air hingga membentuk adonan yang kental.
receipt-9	3	Buka lubang di setiap potongan tahu dan isi dengan adonan.
receipt-9	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-9	5	Goreng tahu hingga kecokelatan dan renyah, sekitar 3-5 menit.
receipt-9	6	Angkat tahu isi dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-10	1	Campurkan tepung terigu, mentega, gula, garam, dan telur dalam mangkuk hingga membentuk adonan kalis.
receipt-10	2	Pisahkan adonan menjadi beberapa bagian kecil. Giling setiap bagian adonan menjadi lembaran tipis.
receipt-10	3	Olesi lembaran adonan dengan selai nanas.
receipt-10	4	Gulung lembaran adonan seperti gulungan sushi dan potong-potong sesuai selera.
receipt-10	5	Panaskan minyak dalam wajan hingga cukup panas.
receipt-10	6	Goreng molen hingga kecokelatan, sekitar 3-5 menit.
receipt-10	7	Angkat molen dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-11	1	Campurkan tepung terigu, garam, gula, bawang putih bubuk, bawang merah, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-11	2	Ambil sebagian adonan dan bulatkan seperti bakso kecil. Ulangi hingga adonan habis.
receipt-11	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-11	4	Goreng cimol hingga kecokelatan dan renyah, sekitar 3-5 menit.
receipt-11	5	Angkat cimol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-12	1	Campurkan tepung kanji, tepung terigu, garam, gula, bawang putih bubuk, bawang merah, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-12	2	Bentuk adonan tipis seperti kulit lumpia.
receipt-12	3	Letakkan sepotong telur ayam di atas kulit lumpia dan bungkus rapi.
receipt-12	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-12	5	Goreng cilor hingga kecokelatan dan renyah, sekitar 3-5 menit.
receipt-12	6	Angkat cilor dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-13	1	Siapkan tahu putih bulat. Belah tahu menjadi dua bagian.
receipt-13	2	Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air dalam mangkuk hingga membentuk adonan yang kental.
receipt-13	3	Celupkan setengah bagian tahu ke dalam adonan tepung hingga rata.
receipt-13	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-13	5	Goreng tahu hingga kecokelatan dan renyah, sekitar 3-5 menit.
receipt-13	6	Angkat tahu bulat dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-14	1	Kupas sukun dan iris tipis-tipis.
receipt-14	2	Campurkan tepung terigu, garam, merica, bawang putih bubuk, dan air dalam mangkuk hingga membentuk adonan yang kental.
receipt-14	3	Celupkan irisan sukun ke dalam adonan tepung hingga rata.
receipt-14	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-14	5	Goreng sukun hingga kecokelatan dan renyah, sekitar 5-7 menit.
receipt-14	6	Angkat sukun goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-15	1	Kupas apel, buang bijinya, dan potong menjadi irisan setebal 1 cm.
receipt-15	2	Campurkan tepung terigu, gula, garam, kayu manis, telur, dan air dalam mangkuk hingga membentuk adonan yang kental.
receipt-15	3	Celupkan irisan apel ke dalam adonan tepung hingga rata.
receipt-15	4	Panaskan minyak dalam wajan hingga cukup panas.
receipt-15	5	Goreng irisan apel hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.
receipt-15	6	Angkat apel goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-15	7	Taburkan gula bubuk atau kayu manis bubuk sebagai hiasan jika diinginkan.
receipt-16	1	Potong roti tawar menjadi bentuk bantal atau sesuai selera.
receipt-16	2	Campurkan telur, susu, gula, dan garam dalam mangkuk.
receipt-16	3	Celupkan potongan roti ke dalam campuran telur.
receipt-16	5	Goreng roti bantal hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.
receipt-16	6	Angkat roti bantal dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-16	7	Taburkan gula bubuk atau topping sesuai selera sebelum disajikan.
receipt-17	1	Campurkan ragi dengan susu hangat dan 1 sendok makan gula. Biarkan ragi aktif selama 10-15 menit.
receipt-17	2	Campurkan tepung terigu, gula, garam, telur, dan mentega dalam mangkuk besar.
receipt-17	3	Tambahkan campuran ragi yang sudah aktif ke dalam mangkuk dan aduk hingga membentuk adonan kalis.
receipt-17	4	Tutup adonan dengan kain lembab dan diamkan selama 1-2 jam hingga mengembang.
receipt-17	5	Gulungkan adonan dan potong dengan cetakan donat atau gelas untuk membuat donat bundar.
receipt-17	6	Panaskan minyak dalam wajan hingga cukup panas.
receipt-17	7	Goreng donat hingga kecokelatan, sekitar 2-3 menit di setiap sisi.
receipt-17	8	Angkat donat dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-17	9	Olesi donat dengan selai strawberry dan taburi gula bubuk sebelum disajikan.
receipt-18	1	Campurkan terigu, air, bawang merah, bawang putih, gula, garam, dan teri dalam mangkuk hingga membentuk adonan kalis.
receipt-18	2	Panaskan minyak dalam wajan hingga cukup panas.
receipt-18	3	Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.
receipt-18	4	Goreng hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.
receipt-18	5	Angkat peyek teri dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-19	1	Campurkan tepung ketan, gula, dan daun pandan dalam mangkuk hingga tercampur rata.
receipt-19	2	Bentuk adonan menjadi bola-bola kecil dan letakkan sepotong gula merah di tengahnya. Bulatkan kembali hingga gula merah tertutup rapat.
receipt-19	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-19	4	Goreng onde-onde hingga kecokelatan, sekitar 3-4 menit.
receipt-19	5	Angkat onde-onde dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-20	1	Campurkan tepung terigu, bawang putih, garam, gula, merica, daun seledri, wortel, tauge, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-20	2	Panaskan minyak dalam wajan hingga cukup panas.
receipt-20	3	Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.
receipt-20	4	Goreng ote-ote hingga kecokelatan dan renyah, sekitar 3-4 menit.
receipt-20	5	Angkat ote-ote dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-21	1	Siapkan kulit lumpia dan letakkan selembar di permukaan datar.
receipt-21	2	Letakkan isian sayuran di tengah kulit lumpia.
receipt-21	3	Lipat kedua sisi kulit lumpia ke atas, lalu gulung hingga membentuk risol.
receipt-21	4	Campurkan tepung terigu, garam, dan air untuk membuat adonan lem tepung.
receipt-21	5	Celupkan risol dalam adonan lem tepung, lalu gulingkan dalam tepung panir.
receipt-21	6	Panaskan minyak dalam wajan hingga cukup panas.
receipt-21	7	Goreng risol hingga kecokelatan, sekitar 3-4 menit.
receipt-21	8	Angkat risol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-22	1	Campurkan tepung terigu, tepung beras, jagung pipil, gula, garam, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-22	2	Panaskan minyak dalam wajan hingga cukup panas.
receipt-22	3	Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.
receipt-22	4	Goreng dadar jagung hingga kecokelatan, sekitar 2-3 menit di setiap sisi.
receipt-22	5	Angkat dadar jagung dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-23	1	Campurkan tepung beras, tepung terigu, bawang putih, gula, garam, ketumbar, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-23	2	Panaskan minyak dalam wajan hingga cukup panas.
receipt-23	3	Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.
receipt-23	4	Goreng peyek kacang hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.
receipt-23	5	Angkat peyek kacang dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-24	1	Potong tahu (gehu) menjadi potongan-potongan kecil sesuai selera.
receipt-24	2	Campurkan tepung terigu, bawang putih, garam, lada, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-24	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-24	4	Celupkan potongan tahu ke dalam adonan tepung hingga rata.
receipt-24	5	Goreng tahu hingga kecokelatan dan renyah, sekitar 3-4 menit di setiap sisi.
receipt-24	6	Angkat tahu dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-24	7	Sajikan tahu pedas dengan saus cabai atau saus sambal sebagai pelengkap.
receipt-25	1	Campurkan tepung terigu, bawang putih, bawang merah, daun seledri, garam, merica, telur, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-25	2	Tambahkan potongan daging sosis ke dalam adonan.
receipt-25	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-25	4	Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.
receipt-25	5	Goreng sempol hingga kecokelatan dan matang, sekitar 3-4 menit.
receipt-25	6	Angkat sempol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
receipt-26	1	Campurkan tepung ketan, kelapa parut, daun bawang, daun kemangi, garam, merica, dan air dalam mangkuk hingga membentuk adonan kalis.
receipt-26	2	Bentuk adonan menjadi bulatan pipih dan letakkan sepotong oncom di tengahnya. Bulatkan kembali hingga oncom tertutup rapat.
receipt-26	3	Panaskan minyak dalam wajan hingga cukup panas.
receipt-26	4	Goreng combro hingga kecokelatan, sekitar 3-4 menit di setiap sisi.
receipt-26	5	Angkat combro dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.
\.


--
-- TOC entry 3750 (class 0 OID 28560)
-- Dependencies: 274
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, email, image_url) FROM stdin;
@id_userBPqBoCh_xILbpXln474bD	Asrofil Fachrul Riidlo	asrofil	asrofil@mail.com	https://placehold.co/200x200?text=\\n
@id_userEW3XETwzatHLUsLIhpdh8	Sari Puspita Hasna	hasna	hasna@mail.com	https://placehold.co/200x200?text=\\n
@id_user3HceBhx_jIfB_Xd5_04MU	Alya Hamida	alya	alya@mail.com	https://placehold.co/200x200?text=\\n
@id_user--E2er8FtN-4hyFIBgzfd	Riga Normanda Putra	riga	riga@mail.com	https://placehold.co/200x200?text=\\n
@id_user52nNBdoEinsLnYkhzHPcX	Surya Aditya Angga Siswanto	surya	surya@mail.com	https://placehold.co/200x200?text=\\n
@id_userUIjuDuhJ_QnJbdiA_z1F_	Ghina Faridah	ghina	ghina@mail.com	https://placehold.co/200x200?text=\\n
@id_userk3a8NtJBKgCPSkPPSaBaA	admin	admin	admin@mail.com	https://placehold.co/200x200?text=\\n
\.


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 278
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ratings_id_seq', 1, false);


--
-- TOC entry 3580 (class 2606 OID 28661)
-- Name: auth auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_pk PRIMARY KEY (user_id, password);


--
-- TOC entry 3574 (class 2606 OID 28570)
-- Name: users email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- TOC entry 3590 (class 2606 OID 28649)
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- TOC entry 3586 (class 2606 OID 28617)
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- TOC entry 3582 (class 2606 OID 28591)
-- Name: recipes receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 3584 (class 2606 OID 28593)
-- Name: recipes receipts_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_title_key UNIQUE (title);


--
-- TOC entry 3588 (class 2606 OID 28634)
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (recipe_id, step);


--
-- TOC entry 3576 (class 2606 OID 28568)
-- Name: users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 3578 (class 2606 OID 28566)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3591 (class 2606 OID 28576)
-- Name: auth auth_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3597 (class 2606 OID 28753)
-- Name: favourites favourites_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3598 (class 2606 OID 28650)
-- Name: favourites fk_fav_user_id_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT fk_fav_user_id_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3593 (class 2606 OID 28748)
-- Name: ingredients ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3594 (class 2606 OID 28743)
-- Name: ratings ratings_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3595 (class 2606 OID 28623)
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 3592 (class 2606 OID 28594)
-- Name: recipes receipts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_user_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3596 (class 2606 OID 28738)
-- Name: steps steps_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth TO anon;
GRANT ALL ON TABLE public.auth TO authenticated;
GRANT ALL ON TABLE public.auth TO service_role;


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE favourites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.favourites TO anon;
GRANT ALL ON TABLE public.favourites TO authenticated;
GRANT ALL ON TABLE public.favourites TO service_role;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE ingredients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ingredients TO anon;
GRANT ALL ON TABLE public.ingredients TO authenticated;
GRANT ALL ON TABLE public.ingredients TO service_role;


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE ratings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ratings TO anon;
GRANT ALL ON TABLE public.ratings TO authenticated;
GRANT ALL ON TABLE public.ratings TO service_role;


--
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 278
-- Name: SEQUENCE ratings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ratings_id_seq TO anon;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO service_role;


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE recipes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.recipes TO anon;
GRANT ALL ON TABLE public.recipes TO authenticated;
GRANT ALL ON TABLE public.recipes TO service_role;


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE steps; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.steps TO anon;
GRANT ALL ON TABLE public.steps TO authenticated;
GRANT ALL ON TABLE public.steps TO service_role;


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE user_auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_auth TO anon;
GRANT ALL ON TABLE public.user_auth TO authenticated;
GRANT ALL ON TABLE public.user_auth TO service_role;


--
-- TOC entry 2425 (class 826 OID 16484)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2426 (class 826 OID 16485)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2424 (class 826 OID 16483)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2428 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2423 (class 826 OID 16482)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2427 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


-- Completed on 2023-11-04 20:28:04 WIB

--
-- PostgreSQL database dump complete
--


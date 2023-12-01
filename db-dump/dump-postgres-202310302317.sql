--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-0ubuntu0.23.04.1)

-- Started on 2023-10-30 23:17:24 WIB

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
-- TOC entry 3756 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 269 (class 1259 OID 28571)
-- Name: auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth (
    user_id character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.auth OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 28643)
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id character varying NOT NULL,
    receipt_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 28599)
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients (
    receipt_id character varying(255) NOT NULL,
    qty character varying(255) NOT NULL,
    unit character varying(255) NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.ingredients OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 28610)
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    receipt_id character varying(255) NOT NULL,
    user_id character varying(255),
    stars integer NOT NULL,
    comment character varying(255)
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 28609)
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
-- TOC entry 3762 (class 0 OID 0)
-- Dependencies: 273
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- TOC entry 271 (class 1259 OID 28585)
-- Name: receipts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.receipts (
    id character varying(255) NOT NULL,
    author_id character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    category character varying(255) NOT NULL,
    imgurl character varying(255) NOT NULL,
    difficulty character varying(255) NOT NULL,
    portion integer NOT NULL,
    minute_duration integer NOT NULL,
    star_rating character varying NOT NULL
);


ALTER TABLE public.receipts OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 28628)
-- Name: steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.steps (
    receipt_id character varying(255) NOT NULL,
    number integer NOT NULL,
    step character varying(255) NOT NULL
);


ALTER TABLE public.steps OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 28560)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    image_url character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 28581)
-- Name: user_auth; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.user_auth AS
 SELECT users.id,
    users.username,
    users.name,
    auth.password,
    users.email
   FROM (public.users
     JOIN public.auth ON (((users.id)::text = (auth.user_id)::text)));


ALTER TABLE public.user_auth OWNER TO postgres;

--
-- TOC entry 3565 (class 2604 OID 28613)
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- TOC entry 3744 (class 0 OID 28571)
-- Dependencies: 269
-- Data for Name: auth; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auth (user_id, password) FROM stdin;
admin	$2b$10$ZnQJ6BiS.IOR./HY5bKQj.afRu4RWlWo2k0y2oDdthgs5cQlHC/hm
@id_userVeangubOW973XBCsyw02O	$2b$10$aGCopmemD58Fm4cb0eFxo.BcUjiEbVb2dcTaIEobf7cStNRF0BKgK
@id_userZO_qpVsZemY5ZF_lxgz00	$2b$10$qoM/hQsyX6xt5k/VDUMP6.OnbDVNiO71bd4pzYM/WczS7dbu5Nm2S
\.


--
-- TOC entry 3750 (class 0 OID 28643)
-- Dependencies: 276
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.favourites (id, receipt_id, user_id) FROM stdin;
\.


--
-- TOC entry 3746 (class 0 OID 28599)
-- Dependencies: 272
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredients (receipt_id, qty, unit, name) FROM stdin;
receipt-1	250	gram	tepung kanji
receipt-1	2	siung	bawang putih, haluskan
receipt-2	120	gram	mentega tawar (suhu ruang)
receipt-2	120	gram	dutch butter(suhu ruang)
receipt-2	110	gram	gula halus
receipt-2	1	sdt	perisa Vanila
receipt-2	1/8	sdt	garam
receipt-2	2	butir	telur
receipt-2	270	gram	tepung terigu protein sedang
receipt-2	55	gram 	maizena
receipt-2	100	gram 	kacang mede panggang
receipt-2	sesuai selera	""	Gula halus(dekstrosa)
receipt-3	500	gram	Ayam Paha Bawah
receipt-3	2	buah	Wortel
receipt-3	2	lembar	Bay Leaf
receipt-3	3	siung	bawang putih
receipt-3	1	liter	air
receipt-3	1/4	sdt	lada hitam
receipt-3	6	sdm	tepung terigu protein sedang
receipt-3	4	sdm 	mentega tawar
receipt-3	200	ml	cooking cream
receipt-3	1/2	sdt	garam
receipt-3	1	sdt	gula pasir
receipt-3	1	sdt	kaldu ayam bubuk
receipt-3	1/8	sdt	merica 
receipt-3	1/8	sdt	pala bubuk
receipt-3	550	ml	kuah kaldu ayam
receipt-3	1/2	buah	bawang bombay ukuran besar
receipt-3	150	gram	sosis ayam
receipt-3	195	gram	ayam
receipt-3	100	gram	kacang polong
receipt-3	0	sesuaikan dengan gelas	Puff Pastry
receipt-3	0	secukupnya	Telur untuk olesan 
receipt-3	0	secukupnya	wijen putih 
receipt-4	150	gram	Tepung Terigu
receipt-4	250	ml	air
receipt-4	1	butir	telur
receipt-4	50	gram	margarin
receipt-4	1	sdm	gula
receipt-4	1/4	sdt	garam
receipt-5	10	buah	tahu pong (cokelat)
receipt-5	250	gram	daging ayam dan kulit
receipt-5	4	sdm	tepung tapioka
receipt-5	3	siung 	bawang putih 
receipt-5	1	butir	telur
receipt-5	80	gram	es batu
receipt-5	1	sdt	garam
receipt-5	1	sdt	merica
receipt-5	""	secukupnya	kaldu jamur
receipt-6	300	gram	tepung serba guna
receipt-6	75	gram	tapioka
receipt-6	60	ml	air
receipt-6	50 	gram	margarin cair
receipt-6	1	butir	telur utuh
receipt-6	100	ml	putih telur
receipt-6	100	gram	keju parut
receipt-6	1/2	sdt	garam
receipt-6	2	batang 	seledri iris halus
receipt-6	8	siuang 	bawang putih haluskan
receipt-6	0	secukupnya	minyak goreng
\.


--
-- TOC entry 3748 (class 0 OID 28610)
-- Dependencies: 274
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ratings (id, receipt_id, user_id, stars, comment) FROM stdin;
\.


--
-- TOC entry 3745 (class 0 OID 28585)
-- Dependencies: 271
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receipts (id, author_id, title, category, imgurl, difficulty, portion, minute_duration, star_rating) FROM stdin;
receipt-1	admin	Cireng Pedas Nuklir	Aci		Mudah	3	30	4.5
receipt-2	@id_userZO_qpVsZemY5ZF_lxgz00	Cookies Putri Salju	Manis / Cookies		Sedang	85	180	4.5
receipt-3	@id_userZO_qpVsZemY5ZF_lxgz00	Zuppa Soup Ayam [Chicken Pot Pie]	Pastry		Sedang	9	120	4.5
receipt-4	@id_userZO_qpVsZemY5ZF_lxgz00	Churros	Manis		Mudah	10	30	4.5
receipt-5	@id_userZO_qpVsZemY5ZF_lxgz00	Tahu Kwalik Ayam	Aci		Mudah	20	60	4.5
receipt-6	@id_userZO_qpVsZemY5ZF_lxgz00	Cheese Stick	Keju		Mudah	500	60	4.5
\.


--
-- TOC entry 3749 (class 0 OID 28628)
-- Dependencies: 275
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.steps (receipt_id, number, step) FROM stdin;
receipt-1	1	Campur tepung kanji, tepung terigu, bawang putih, garam, gula, dan kaldu ayam bubuk (jika digunakan) dalam mangkuk besar
receipt-2	8	Bentuk adonan seperti bulan sabit kemudian susun ke dalam loyang yang telah dialasi baking paper 
receipt-2	3	Cincang kacang mede lalu masukkan ke dalam adonan, aduk rata
receipt-2	5	Gunakan sedikit tepung terigu supaya tidak lengket lalu potong miring. Bentuk seperti bulan sabit lalu susun ke dalam loyang yang sudah dialasi baking paper
receipt-2	11	Keluarkan dari panggangan lalu balurkan ke dalam gula donat
receipt-2	1	Kocok dutch butter, mentega, dan gula halus hingga pucat dan mengembang kemudian tambahkan perisa vanila, garam, dan kuning telur, kocok sesaat hingga menyatu
receipt-2	12	Kue putri salju siap dihidangkan
receipt-2	7	Masukkan ke dalam freezer selama 1 jam. Ambil 1 bagian adonan, taburkan sedikit tepung terigu kemudian potong-potong miring
receipt-2	2	Masukkan tepung terigu dan maizena sambil disaring, aduk rata secara perlahan dengan spatula
receipt-2	9	Panggang dengan api bawah selama 30 menit di api kecil lalu panggang dengan api atas bawah selama 10 menit 
receipt-2	6	Untuk cara kedua, masukkan adonan ke dalam wadah plastik kemudian ratakan kurang lebih ukuran 20 x 29 cm lalu bagi menjadi 5 bagian dengan benda tumpul
receipt-2	4	Untuk cara pertama, masukkan adonan ke dalam kulkas selama 1-2 jam kemudian ambil 1 kepal adonan, bentuk roll memanjang seukuran jempol 
receipt-2	10	Untuk penggunaan oven listrik, panggang di suhu 130 derajat celcius selama 30-40 menit api atas bawah
receipt-3	10	Chicken pot pie siap disajikan
receipt-3	3	Keluarkan wortel dari panci kemudian potong kotak-kotak
receipt-3	5	Masukkan mentega, tepung terigu, dan pala bubuk, aduk sesaat lalu masukkan kuah kaldu sambil disaring
receipt-3	7	Masukkan wortel, kacang polong, garam, gula pasir, merica, kaldu ayam, dan cooking cream, masak sesaat
receipt-3	9	Oles dengan telur dan taburkan wijen. Panggang di suhu 190 derajat celcius selama 15 menit 
receipt-3	4	Panaskan sedikit minyak, tumis bawang bombai hingga wangi kemudian masukkan chicken luncheon, dan sosis, tumis sesaat
receipt-3	2	Potong kotak bawang bombai, chicken luncheon dan sosis.
receipt-3	1	Rebus air, ayam,wortel, bawang putih, bay leaf, seledri, dan lada hitam. Masak hingga mendidih kemudian lanjut masak di api kecil selama 15 menit
receipt-3	6	Suwir ayam, potong-potong lalu masukkan ke dalam kuah
receipt-3	8	Tuang ke dalam wadah tahan panas kemudian bagi 4 puff pastry, simpan di atas cetakan
receipt-4	5	Angkat, tiriskan, dan biarkan hangat. Lalu gulingkan ke gula pasir lalu dicocol dengan saus cokelat.
receipt-4	4	Lalu goreng dengan minyak yang sudah dipanaskan sampai golden brown. (gunakan api kecil cenderung sedang)
receipt-4	1	Masak air, gula, garam, dan margarin sampai mendidih, kecilkan kompor lalu masukkan terigu lalu aduk sampai kalis, angkat lalu dinginkan
receipt-4	3	Masukkan ke plastik segitiga, spuitkan panjang-panjang di atas kertas roti lalu simpan di kulkas 1 jam
receipt-4	2	Setelah dingin masukkan telur sambil diaduk sampai rata
receipt-5	3	Abis kulit tahu, beri isian adonan ayam, lakukan sampai adonan habis.
receipt-5	1	Belah 2 tahu bentuk segitiga, kemudian balik tahu, ambil bagian dalam tahu, sisihkan
receipt-5	4	Kukus tahu 10 menit. Setelah agak dingin goreng tahu walik secukupnya, sisanya bisa disimpan di lemari es.
receipt-5	2	Masukkan di chooper semua bahan kecuali kulit tahu, tambahkan isian tahu (bagian putih), haluskan.
receipt-6	1	Campur margarin cair dan telur, aduk rata. Masukkan semua bahan kecuali air.
receipt-6	3	Giling adonan lalu potong memanjang.
receipt-6	4	Goreng sampai kuning keemasan.
receipt-6	2	Tuang air sedikit demi sedikit, uleni sampai kalis.
\.


--
-- TOC entry 3743 (class 0 OID 28560)
-- Dependencies: 268
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, username, email, image_url) FROM stdin;
@id_userVeangubOW973XBCsyw02O	anya	anya	anya@mail.com	\N
@id_userZO_qpVsZemY5ZF_lxgz00	Sari Puspita Hasna	hasna	saripuspitahasna@mail.com	\N
admin	admin	admin	admin@admin.com	\N
\.


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 273
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ratings_id_seq', 1, false);


--
-- TOC entry 3573 (class 2606 OID 28661)
-- Name: auth auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_pk PRIMARY KEY (user_id, password);


--
-- TOC entry 3567 (class 2606 OID 28570)
-- Name: users email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- TOC entry 3583 (class 2606 OID 28649)
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- TOC entry 3579 (class 2606 OID 28617)
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- TOC entry 3575 (class 2606 OID 28591)
-- Name: receipts receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 3577 (class 2606 OID 28593)
-- Name: receipts receipts_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_title_key UNIQUE (title);


--
-- TOC entry 3581 (class 2606 OID 28634)
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (receipt_id, step);


--
-- TOC entry 3569 (class 2606 OID 28568)
-- Name: users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 3571 (class 2606 OID 28566)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3584 (class 2606 OID 28576)
-- Name: auth auth_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3590 (class 2606 OID 28655)
-- Name: favourites fk_fav_receipt_id_receipts_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT fk_fav_receipt_id_receipts_id FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON DELETE CASCADE;


--
-- TOC entry 3591 (class 2606 OID 28650)
-- Name: favourites fk_fav_user_id_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT fk_fav_user_id_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3586 (class 2606 OID 28604)
-- Name: ingredients ingredients_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_ibfk_1 FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON DELETE CASCADE;


--
-- TOC entry 3587 (class 2606 OID 28618)
-- Name: ratings ratings_receipt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_receipt_id_fkey FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON DELETE CASCADE;


--
-- TOC entry 3588 (class 2606 OID 28623)
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 3585 (class 2606 OID 28594)
-- Name: receipts receipts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.receipts
    ADD CONSTRAINT receipts_user_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3589 (class 2606 OID 28635)
-- Name: steps steps_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_ibfk_1 FOREIGN KEY (receipt_id) REFERENCES public.receipts(id) ON DELETE CASCADE;


--
-- TOC entry 3757 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 3758 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth TO anon;
GRANT ALL ON TABLE public.auth TO authenticated;
GRANT ALL ON TABLE public.auth TO service_role;


--
-- TOC entry 3759 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE favourites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.favourites TO anon;
GRANT ALL ON TABLE public.favourites TO authenticated;
GRANT ALL ON TABLE public.favourites TO service_role;


--
-- TOC entry 3760 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE ingredients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ingredients TO anon;
GRANT ALL ON TABLE public.ingredients TO authenticated;
GRANT ALL ON TABLE public.ingredients TO service_role;


--
-- TOC entry 3761 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE ratings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ratings TO anon;
GRANT ALL ON TABLE public.ratings TO authenticated;
GRANT ALL ON TABLE public.ratings TO service_role;


--
-- TOC entry 3763 (class 0 OID 0)
-- Dependencies: 273
-- Name: SEQUENCE ratings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ratings_id_seq TO anon;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO service_role;


--
-- TOC entry 3764 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE receipts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.receipts TO anon;
GRANT ALL ON TABLE public.receipts TO authenticated;
GRANT ALL ON TABLE public.receipts TO service_role;


--
-- TOC entry 3765 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE steps; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.steps TO anon;
GRANT ALL ON TABLE public.steps TO authenticated;
GRANT ALL ON TABLE public.steps TO service_role;


--
-- TOC entry 3766 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE user_auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_auth TO anon;
GRANT ALL ON TABLE public.user_auth TO authenticated;
GRANT ALL ON TABLE public.user_auth TO service_role;


--
-- TOC entry 2419 (class 826 OID 16484)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2420 (class 826 OID 16485)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2418 (class 826 OID 16483)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2422 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2417 (class 826 OID 16482)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2421 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


-- Completed on 2023-10-30 23:17:30 WIB

--
-- PostgreSQL database dump complete
--


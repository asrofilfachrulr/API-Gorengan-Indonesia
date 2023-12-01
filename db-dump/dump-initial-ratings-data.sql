--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1 (Ubuntu 15.1-1.pgdg20.04+1)
-- Dumped by pg_dump version 15.4 (Ubuntu 15.4-0ubuntu0.23.04.1)

-- Started on 2023-11-07 18:17:33 WIB

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
-- TOC entry 3766 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C.UTF-8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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
-- TOC entry 3767 (class 0 OID 0)
-- Dependencies: 3766
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- TOC entry 3769 (class 0 OID 0)
-- Name: postgres; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE postgres SET "app.settings.jwt_secret" TO 'x7uR7IaTER6o3C9VupqnUwgmFITJHHdQDZEBhdWYTwWmveYLE6pgBD5Q8tWUzoVjQMhHT717H5pNoZuFhBZeCA==';
ALTER DATABASE postgres SET "app.settings.jwt_exp" TO '3600';


\connect postgres

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
-- TOC entry 3770 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 277 (class 1259 OID 28571)
-- Name: auth; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auth (
    user_id character varying(255) NOT NULL,
    password character varying(255) NOT NULL
);


ALTER TABLE public.auth OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 28643)
-- Name: favourites; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.favourites (
    id character varying NOT NULL,
    recipe_id character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.favourites OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 28599)
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
-- TOC entry 281 (class 1259 OID 28610)
-- Name: ratings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ratings (
    id integer NOT NULL,
    recipe_id character varying(255) NOT NULL,
    user_id character varying(255),
    stars integer NOT NULL,
    comment character varying(255),
    like_count integer DEFAULT 0,
    date timestamp with time zone NOT NULL
);


ALTER TABLE public.ratings OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 28609)
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
-- TOC entry 3776 (class 0 OID 0)
-- Dependencies: 280
-- Name: ratings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ratings_id_seq OWNED BY public.ratings.id;


--
-- TOC entry 278 (class 1259 OID 28585)
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
-- TOC entry 282 (class 1259 OID 28628)
-- Name: steps; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.steps (
    recipe_id character varying(255) NOT NULL,
    number integer NOT NULL,
    step character varying(255) NOT NULL
);


ALTER TABLE public.steps OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 28560)
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
-- TOC entry 284 (class 1259 OID 28662)
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
-- TOC entry 3574 (class 2604 OID 28613)
-- Name: ratings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings ALTER COLUMN id SET DEFAULT nextval('public.ratings_id_seq'::regclass);


--
-- TOC entry 3754 (class 0 OID 28571)
-- Dependencies: 277
-- Data for Name: auth; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auth VALUES ('@id_userBPqBoCh_xILbpXln474bD', '$2b$10$OcLMbxWRlLM/7H37wUMUKOnQgZ5jq.cGa03VbF.ZBuVmCsVUQhS6q');
INSERT INTO public.auth VALUES ('@id_userEW3XETwzatHLUsLIhpdh8', '$2b$10$4jUiUHpqnR2mkdQSXcLGmOaQHu9ok1eN5maPV13E2jWb8RoNgVHGW');
INSERT INTO public.auth VALUES ('@id_user3HceBhx_jIfB_Xd5_04MU', '$2b$10$dCd22v9KIxcq6weDLuccyOVbY.Mcz2TsQPPJTPQRpVSxDhfLF//uW');
INSERT INTO public.auth VALUES ('@id_user--E2er8FtN-4hyFIBgzfd', '$2b$10$Y0paW4X6wiJYH1Yjz3kc8uWZS53qpNElFkm4Np5wpgwC1makOIM5K');
INSERT INTO public.auth VALUES ('@id_user52nNBdoEinsLnYkhzHPcX', '$2b$10$cCtXZxmIAFjZpo01ejYTA.nxMkNotwQ7VQIzwSAJRoSuFJxU.cwme');
INSERT INTO public.auth VALUES ('@id_userUIjuDuhJ_QnJbdiA_z1F_', '$2b$10$G0eNR0hBVxJoMXuLBJyPS.AAzXekMmOIgR1EDeCC75QWQ1DTSHTVG');
INSERT INTO public.auth VALUES ('@id_userk3a8NtJBKgCPSkPPSaBaA', '$2b$10$bBTpBjUEcPxPCFDyma1mce1SxqHCJfqrEFlSTjqRU.hB.Dj.WZpWG');


--
-- TOC entry 3760 (class 0 OID 28643)
-- Dependencies: 283
-- Data for Name: favourites; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3756 (class 0 OID 28599)
-- Dependencies: 279
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ingredients VALUES ('receipt-1', '250', 'gram', 'tepung kanji');
INSERT INTO public.ingredients VALUES ('receipt-1', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-1', '½', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-1', '¼', 'sdt', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-1', '¼', 'sdt', 'kaldu bubuk (opsional)');
INSERT INTO public.ingredients VALUES ('receipt-1', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-1', '2', 'sdm', 'minyak goreng');
INSERT INTO public.ingredients VALUES ('receipt-1', '3', 'sdm', 'saus sambal manis (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-1', '1', 'sdm', 'saus tomat (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-1', '1', 'sdm', 'kecap manis (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-1', '1', 'sdt', 'gula (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-1', '½', 'sdt', 'garam (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-1', '1', 'sdm', 'air (untuk bumbu pedas manis)');
INSERT INTO public.ingredients VALUES ('receipt-2', '200', 'gram', 'tempe, potong tipis');
INSERT INTO public.ingredients VALUES ('receipt-2', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-2', '2', 'sdm', 'tepung beras');
INSERT INTO public.ingredients VALUES ('receipt-2', '½', 'sdt', 'merica bubuk');
INSERT INTO public.ingredients VALUES ('receipt-2', '¼', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-2', '200', 'ml', 'air es');
INSERT INTO public.ingredients VALUES ('receipt-3', '4', 'buah', 'pisang, potong sesuai selera');
INSERT INTO public.ingredients VALUES ('receipt-3', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-3', '50', 'gram', 'tepung beras');
INSERT INTO public.ingredients VALUES ('receipt-3', '½', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-3', '2', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-3', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-3', '', '~', 'minyak goreng');
INSERT INTO public.ingredients VALUES ('receipt-4', '4', 'buah', 'kentang, potong sesuai selera');
INSERT INTO public.ingredients VALUES ('receipt-4', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-4', '½', 'sdt', 'merica bubuk');
INSERT INTO public.ingredients VALUES ('receipt-4', '½', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-4', '½', 'sdt', 'bawang putih bubuk');
INSERT INTO public.ingredients VALUES ('receipt-4', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-4', '', '~', 'saus pedas sebagai pelengkap');
INSERT INTO public.ingredients VALUES ('receipt-5', '200', 'gram', 'tepung beras');
INSERT INTO public.ingredients VALUES ('receipt-5', '50', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-5', '100', 'gram', 'udang, kupas, cuci bersih, dan tiriskan');
INSERT INTO public.ingredients VALUES ('receipt-5', '150', 'ml', 'air es');
INSERT INTO public.ingredients VALUES ('receipt-5', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-5', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-5', '1/2', 'sdt', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-5', '1/4', 'sdt', 'kaldu bubuk');
INSERT INTO public.ingredients VALUES ('receipt-5', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-6', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-6', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-6', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-6', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-6', '1/2', 'sdt', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-6', '1/4', 'sdt', 'kaldu bubuk');
INSERT INTO public.ingredients VALUES ('receipt-6', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-6', '', '~', 'tauge');
INSERT INTO public.ingredients VALUES ('receipt-6', '', '~', 'wortel, potong korek api');
INSERT INTO public.ingredients VALUES ('receipt-6', '', '~', 'kol, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-6', '', '~', 'daun bawang, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-6', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-7', '500', 'gram', 'ubi jalar, kupas dan iris tipis');
INSERT INTO public.ingredients VALUES ('receipt-7', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-7', '1/2', 'sdt', 'bawang putih bubuk');
INSERT INTO public.ingredients VALUES ('receipt-7', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-7', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-7', '150', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-7', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-8', '500', 'gram', 'kentang, kupas dan rebus hingga empuk');
INSERT INTO public.ingredients VALUES ('receipt-8', '200', 'gram', 'daging ayam cincang');
INSERT INTO public.ingredients VALUES ('receipt-8', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-8', '4', 'btr', 'bawang merah, cincang halus');
INSERT INTO public.ingredients VALUES ('receipt-8', '1', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-8', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-8', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-8', '', '~', 'penyedap rasa ~');
INSERT INTO public.ingredients VALUES ('receipt-8', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-9', '4', 'buah', 'tahu, potong menjadi kotak-kotak kecil');
INSERT INTO public.ingredients VALUES ('receipt-9', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-9', '1/2', 'sdt', 'bawang putih bubuk');
INSERT INTO public.ingredients VALUES ('receipt-9', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-9', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-9', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-9', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-10', '250', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-10', '100', 'gram', 'mentega');
INSERT INTO public.ingredients VALUES ('receipt-10', '50', 'gram', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-10', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-10', '1', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-10', '', '~', 'selai nanas');
INSERT INTO public.ingredients VALUES ('receipt-10', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-11', '250', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-11', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-11', '1', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-11', '1/2', 'sdt', 'bawang putih bubuk');
INSERT INTO public.ingredients VALUES ('receipt-11', '2', 'btr', 'bawang merah, cincang halus');
INSERT INTO public.ingredients VALUES ('receipt-11', '1', 'btg', 'daun bawang, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-11', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-11', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-12', '150', 'gram', 'tepung kanji');
INSERT INTO public.ingredients VALUES ('receipt-12', '100', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-12', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-12', '1', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-12', '1/2', 'sdt', 'bawang putih bubuk');
INSERT INTO public.ingredients VALUES ('receipt-12', '2', 'btr', 'bawang merah, cincang halus');
INSERT INTO public.ingredients VALUES ('receipt-12', '1', 'btg', 'daun bawang, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-12', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-12', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-12', '', '~', 'telur ayam');
INSERT INTO public.ingredients VALUES ('receipt-13', '4', 'buah', 'tahu putih bulat, belah dua');
INSERT INTO public.ingredients VALUES ('receipt-13', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-13', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-13', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-13', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-13', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-14', '500', 'gram', 'sukun, kupas dan iris tipis');
INSERT INTO public.ingredients VALUES ('receipt-14', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-14', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-14', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-14', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-14', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-15', '2', 'buah', 'apel, kupas, buang biji, dan potong menjadi irisan setebal 1 cm');
INSERT INTO public.ingredients VALUES ('receipt-15', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-15', '1/4', 'cup', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-15', '1/4', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-15', '1/2', 'sdt', 'kayu manis');
INSERT INTO public.ingredients VALUES ('receipt-15', '1', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-15', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-15', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-15', '', '~', 'gula bubuk atau kayu manis bubuk untuk hiasan');
INSERT INTO public.ingredients VALUES ('receipt-16', '4', 'potong', 'roti tawar, potong menjadi bentuk bantal');
INSERT INTO public.ingredients VALUES ('receipt-16', '2', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-16', '50', 'ml', 'susu');
INSERT INTO public.ingredients VALUES ('receipt-16', '2', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-16', '1/4', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-16', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-16', '', '~', 'gula bubuk atau topping sesuai selera');
INSERT INTO public.ingredients VALUES ('receipt-17', '2 1/4', 'sdt', 'ragi instan');
INSERT INTO public.ingredients VALUES ('receipt-17', '120', 'ml', 'susu hangat');
INSERT INTO public.ingredients VALUES ('receipt-17', '2 1/2', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-17', '500', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-17', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-17', '1', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-17', '3', 'sdm', 'mentega');
INSERT INTO public.ingredients VALUES ('receipt-17', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-17', '', '~', 'selai strawberry sesuai selera');
INSERT INTO public.ingredients VALUES ('receipt-17', '', '~', 'gula bubuk untuk taburan');
INSERT INTO public.ingredients VALUES ('receipt-18', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-18', '100', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-18', '2', 'btr', 'bawang merah, cincang halus');
INSERT INTO public.ingredients VALUES ('receipt-18', '2', 'siung', 'bawang putih, cincang halus');
INSERT INTO public.ingredients VALUES ('receipt-18', '1', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-18', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-18', '200', 'gram', 'teri, sangrai');
INSERT INTO public.ingredients VALUES ('receipt-18', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-19', '250', 'gram', 'tepung ketan');
INSERT INTO public.ingredients VALUES ('receipt-19', '100', 'gram', 'gula pasir');
INSERT INTO public.ingredients VALUES ('receipt-19', '5', 'lbr', 'daun pandan, dihaluskan');
INSERT INTO public.ingredients VALUES ('receipt-19', '100', 'gram', 'gula merah, potong kecil-kecil');
INSERT INTO public.ingredients VALUES ('receipt-19', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-20', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-20', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-20', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-20', '1', 'sdt', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-20', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-20', '2', 'btg', 'daun seledri, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-20', '1', 'buah', 'wortel, parut halus');
INSERT INTO public.ingredients VALUES ('receipt-20', '100', 'gram', 'tauge (kecambah)');
INSERT INTO public.ingredients VALUES ('receipt-20', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-20', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-21', '12', 'lbr', 'kulit lumpia');
INSERT INTO public.ingredients VALUES ('receipt-21', '200', 'gram', 'sayuran (wortel, kentang, buncis), rebus dan potong kecil-kecil');
INSERT INTO public.ingredients VALUES ('receipt-21', '1', 'btr', 'telur, rebus dan potong kecil-kecil');
INSERT INTO public.ingredients VALUES ('receipt-21', '1', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-21', '100', 'gram', 'tepung panir');
INSERT INTO public.ingredients VALUES ('receipt-21', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-22', '100', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-22', '50', 'gram', 'tepung beras');
INSERT INTO public.ingredients VALUES ('receipt-22', '200', 'gram', 'jagung pipil (manis atau biasa)');
INSERT INTO public.ingredients VALUES ('receipt-22', '1', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-22', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-22', '2', 'btg', 'daun bawang, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-22', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-22', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-23', '150', 'gram', 'tepung beras');
INSERT INTO public.ingredients VALUES ('receipt-23', '50', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-23', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-23', '1', 'sdm', 'gula');
INSERT INTO public.ingredients VALUES ('receipt-23', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-23', '1/2', 'sdt', 'ketumbar bubuk');
INSERT INTO public.ingredients VALUES ('receipt-23', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-23', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-24', '250', 'gram', 'tahu (gehu)');
INSERT INTO public.ingredients VALUES ('receipt-24', '100', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-24', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-24', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-24', '1/4', 'sdt', 'lada');
INSERT INTO public.ingredients VALUES ('receipt-24', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-24', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-24', '', '~', 'saus cabai atau saus sambal sebagai pelengkap');
INSERT INTO public.ingredients VALUES ('receipt-25', '150', 'gram', 'tepung terigu');
INSERT INTO public.ingredients VALUES ('receipt-25', '2', 'siung', 'bawang putih, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-25', '2', 'siung', 'bawang merah, haluskan');
INSERT INTO public.ingredients VALUES ('receipt-25', '2', 'btg', 'daun seledri, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-25', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-25', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-25', '1', 'btr', 'telur');
INSERT INTO public.ingredients VALUES ('receipt-25', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-25', '2', 'buah', 'daging sosis, potong-potong');
INSERT INTO public.ingredients VALUES ('receipt-25', '', '~', 'minyak untuk menggoreng');
INSERT INTO public.ingredients VALUES ('receipt-26', '250', 'gram', 'tepung ketan');
INSERT INTO public.ingredients VALUES ('receipt-26', '100', 'gram', 'kelapa parut');
INSERT INTO public.ingredients VALUES ('receipt-26', '2', 'btg', 'daun bawang, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-26', '2', 'btg', 'daun kemangi, iris halus');
INSERT INTO public.ingredients VALUES ('receipt-26', '1/2', 'sdt', 'garam');
INSERT INTO public.ingredients VALUES ('receipt-26', '1/4', 'sdt', 'merica');
INSERT INTO public.ingredients VALUES ('receipt-26', '200', 'ml', 'air');
INSERT INTO public.ingredients VALUES ('receipt-26', '', '', 'sayur oncom');
INSERT INTO public.ingredients VALUES ('receipt-26', '', '~', 'minyak untuk menggoreng');


--
-- TOC entry 3758 (class 0 OID 28610)
-- Dependencies: 281
-- Data for Name: ratings; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ratings VALUES (36, 'receipt-2', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Cukup enak. Tempe mendoannya renyah, tapi agak terlalu gurih buat saya. Tetap mantap buat camilan sore.', 2, '2022-05-22 18:23:39.080596+00');
INSERT INTO public.ratings VALUES (64, 'receipt-6', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Bakwan ini enak, renyahnya pas, sayurannya juga fresh. Dijamin bikin nagih!', 8, '2022-07-17 12:12:04.903607+00');
INSERT INTO public.ratings VALUES (204, 'receipt-24', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Gehu pedas ini enak. Rasanya pedas dan gurih.', 4, '2022-08-27 22:43:47.19696+00');
INSERT INTO public.ratings VALUES (218, 'receipt-25', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Sempol ayam ini enak. Cocok sebagai cemilan.', 2, '2023-04-03 04:26:55.534979+00');
INSERT INTO public.ratings VALUES (211, 'receipt-26', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Combro ini enak. Cocok sebagai cemilan.', 1, '2023-08-21 09:49:58.529604+00');
INSERT INTO public.ratings VALUES (30, 'receipt-1', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Cireng pedas ini keren banget, guys! Pedesnya tuh nendang banget, enak buat cemilan sore. Aku jadi ketagihan.', 4, '2023-03-27 21:37:59.221544+00');
INSERT INTO public.ratings VALUES (37, 'receipt-2', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Tempe mendoannya super enak! Gurih dan renyah. Saya suka banget.', 6, '2023-04-17 08:16:49.95134+00');
INSERT INTO public.ratings VALUES (44, 'receipt-3', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Pisang gorengnya top, teksturnya renyah dan manis. Cocok buat teman minum teh.', 8, '2022-09-27 11:54:34.310395+00');
INSERT INTO public.ratings VALUES (113, 'receipt-13', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Tahu bulat ini biasa saja. Cukup enak.', 7, '2022-05-21 01:34:17.307082+00');
INSERT INTO public.ratings VALUES (51, 'receipt-4', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Wah, kentang gorengnya juara! Enak banget, teksturnya pas, dan gurih. Aku suka!', 4, '2023-09-03 01:31:49.330924+00');
INSERT INTO public.ratings VALUES (79, 'receipt-8', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Perkedel ini sempurna. Rasanya enak dan renyah. Bener-bener jadi favorit!', 1, '2023-08-21 00:12:35.751238+00');
INSERT INTO public.ratings VALUES (86, 'receipt-9', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Tahu isinya luar biasa. Enak, gurih, dan renyah. Suka banget jam rolexnya!', 2, '2022-03-09 21:01:53.272263+00');
INSERT INTO public.ratings VALUES (93, 'receipt-10', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Molen ini juara! Isiannya enak banget, bikin ketagihan.', 3, '2022-10-12 16:47:45.597088+00');
INSERT INTO public.ratings VALUES (100, 'receipt-11', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Cimol ini rasanya oke. Tidak terlalu pedas.', 1, '2023-04-13 08:52:51.147514+00');
INSERT INTO public.ratings VALUES (107, 'receipt-12', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Cilor ini rasanya oke. Tidak terlalu pedas.', 9, '2023-05-07 09:44:20.854875+00');
INSERT INTO public.ratings VALUES (114, 'receipt-13', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Tahu bulat ini rasanya lezat. Saya suka.', 7, '2022-11-11 04:28:35.819096+00');
INSERT INTO public.ratings VALUES (121, 'receipt-14', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Rasa gorengan sukun ini enak. Saya suka.', 2, '2022-01-12 05:05:50.772081+00');
INSERT INTO public.ratings VALUES (128, 'receipt-15', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Saya suka sekali dengan apel goreng ini. Rasanya lezat.', 3, '2023-03-21 13:39:53.61892+00');
INSERT INTO public.ratings VALUES (219, 'receipt-25', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Sempol ayam ini sangat lezat. Cocok sebagai cemilan favorit saya.', 8, '2022-09-28 21:03:15.57884+00');
INSERT INTO public.ratings VALUES (212, 'receipt-26', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Combro ini sangat lezat. Cocok sebagai cemilan favorit saya.', 6, '2023-01-16 13:06:39.878278+00');
INSERT INTO public.ratings VALUES (142, 'receipt-16', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Wah, roti bantal ini juara banget. Bikinnya gampang, rasanya enak, dan gurih. Suka banget deh!', 1, '2022-07-28 01:15:04.063487+00');
INSERT INTO public.ratings VALUES (156, 'receipt-17', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Wah, donat selai strawberry ini luar biasa! Manisnya pas, dan teksturnya lembut banget. Gak nyesel deh nyobain.', 9, '2023-07-31 22:11:58.370385+00');
INSERT INTO public.ratings VALUES (163, 'receipt-18', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Peyek teri ini enak banget! Crispy dan gurih. Cocok buat camilan.', 3, '2022-12-08 05:03:28.595503+00');
INSERT INTO public.ratings VALUES (170, 'receipt-19', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Onde-onde ini selalu jadi favorit saya. Rasanya luar biasa!', 9, '2022-08-31 14:38:46.639665+00');
INSERT INTO public.ratings VALUES (177, 'receipt-20', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Ote-ote ini selalu jadi favorit saya. Teksturnya renyah dan enak.', 3, '2022-09-03 15:35:57.426973+00');
INSERT INTO public.ratings VALUES (184, 'receipt-21', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Risol sayur ini selalu jadi favorit saya. Enak dan renyah.', 7, '2022-08-20 05:56:14.422239+00');
INSERT INTO public.ratings VALUES (191, 'receipt-22', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Dadar jagung ini enak. Saya suka rasanya.', 2, '2023-02-26 16:11:35.704796+00');
INSERT INTO public.ratings VALUES (198, 'receipt-23', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Peyek kacang ini enak. Saya suka rasanya.', 5, '2022-02-24 22:38:51.383194+00');
INSERT INTO public.ratings VALUES (205, 'receipt-24', '@id_userEW3XETwzatHLUsLIhpdh8', 3, 'Rasanya terlalu pedas untuk saya. Tapi tetap enak.', 6, '2022-12-19 04:29:11.982842+00');
INSERT INTO public.ratings VALUES (38, 'receipt-2', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Camilan yang oke. Tempe mendoannya renyah, meskipun agak gurih buat saya.', 10, '2023-11-03 18:06:24.219847+00');
INSERT INTO public.ratings VALUES (45, 'receipt-3', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Pisang gorengnya oke sih, tapi mungkin bisa lebih gurih ya. Tapi tetap enak kok!', 10, '2023-11-17 16:09:27.19925+00');
INSERT INTO public.ratings VALUES (52, 'receipt-4', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Kentang gorengnya lumayan enak, tapi kurang gurih menurutku. Tapi masih bisa dinikmati kok.', 4, '2022-11-11 21:55:58.03694+00');
INSERT INTO public.ratings VALUES (59, 'receipt-5', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Rempeyek udang ini lumayan enak, gurihnya pas, tapi agak terlalu asin buatku. Lebih baiknya lagi nih, bisa lebih tidak nepotisme.', 1, '2023-02-28 05:26:11.847186+00');
INSERT INTO public.ratings VALUES (66, 'receipt-6', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Bakwan ini oke, renyahnya pas, tapi mungkin sayurannya bisa lebih banyak. Selera saya sih lebih suka banyak sayuran.', 6, '2023-01-12 20:35:02.247747+00');
INSERT INTO public.ratings VALUES (73, 'receipt-7', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Rasanya biasa aja sih, gak terlalu spesial. Tapi lumayan buat cemilan ringan.', 5, '2023-03-09 16:54:58.169965+00');
INSERT INTO public.ratings VALUES (80, 'receipt-8', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Perkedelnya enak, meskipun kurang gurih. Tapi tetap lezat.', 4, '2022-02-01 11:53:25.835053+00');
INSERT INTO public.ratings VALUES (87, 'receipt-9', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Tahu isinya oke, walaupun kurang gurih. Tapi tetap enak-an bansos', 3, '2023-01-09 18:07:50.540016+00');
INSERT INTO public.ratings VALUES (94, 'receipt-10', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Molen biasa saja, tidak terlalu istimewa.', 3, '2023-05-02 07:16:14.492326+00');
INSERT INTO public.ratings VALUES (101, 'receipt-11', '@id_user3HceBhx_jIfB_Xd5_04MU', 2, 'Cimol biasa saja. Kurang gurih dan tidak terlalu istimewa.', 6, '2022-09-17 20:30:31.285272+00');
INSERT INTO public.ratings VALUES (108, 'receipt-12', '@id_user3HceBhx_jIfB_Xd5_04MU', 2, 'Cilor biasa saja. Kurang gurih dan tidak terlalu istimewa.', 3, '2023-02-28 19:15:30.796935+00');
INSERT INTO public.ratings VALUES (42, 'receipt-2', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-11-01 23:47:26.676469+00');
INSERT INTO public.ratings VALUES (49, 'receipt-3', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-03-08 22:01:26.430623+00');
INSERT INTO public.ratings VALUES (56, 'receipt-4', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-08-17 17:10:35.002068+00');
INSERT INTO public.ratings VALUES (63, 'receipt-5', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-08-18 10:03:11.488633+00');
INSERT INTO public.ratings VALUES (70, 'receipt-6', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-10-04 06:43:52.257841+00');
INSERT INTO public.ratings VALUES (77, 'receipt-7', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-01-13 20:45:40.373736+00');
INSERT INTO public.ratings VALUES (84, 'receipt-8', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-06-14 15:48:14.971419+00');
INSERT INTO public.ratings VALUES (29, 'receipt-1', '@id_userBPqBoCh_xILbpXln474bD', 5, 'Wuih, cireng pedes ini bener-bener juara! Bumbunya dapet banget, bikin nagih, pokoknya rekomendasi deh buat yang suka pedes.', 4, '2023-08-07 03:03:46.403228+00');
INSERT INTO public.ratings VALUES (43, 'receipt-3', '@id_userBPqBoCh_xILbpXln474bD', 5, 'Pisang goreng ini enak banget, rasanya pas, gurih diluar dan manis di dalam. Aku suka!', 3, '2023-10-03 13:04:35.792003+00');
INSERT INTO public.ratings VALUES (50, 'receipt-4', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Kentang goreng ini keren banget, enak, renyah, dan gurih. Cocok buat ngemil sambil nonton.', 10, '2023-07-24 04:18:28.519656+00');
INSERT INTO public.ratings VALUES (57, 'receipt-5', '@id_userBPqBoCh_xILbpXln474bD', 5, 'Wah, rempeyek udang ini enak banget! Bener-bener kriuk-kriuk, udangnya juga gurih. Cocok buat camilan sambil nonton Debat Capres nih. Mantap!', 4, '2023-05-22 23:25:37.714065+00');
INSERT INTO public.ratings VALUES (71, 'receipt-7', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Ubi tepung goreng ini biasa aja. Gak terlalu istimewa menurut saya.', 7, '2023-05-26 15:49:50.70294+00');
INSERT INTO public.ratings VALUES (78, 'receipt-8', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Perkedelnya enak, gurih, dan renyah. Cocok buat cemilan.', 8, '2022-11-15 09:18:00.047601+00');
INSERT INTO public.ratings VALUES (85, 'receipt-9', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Tahu isinya enak dan gurih. Cocok banget buat camilan saat nonton sidang DPR.', 8, '2022-05-10 09:00:24.528453+00');
INSERT INTO public.ratings VALUES (92, 'receipt-10', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Molen-nya enak. Isiannya manis dan lezat.', 10, '2022-08-01 02:50:41.953158+00');
INSERT INTO public.ratings VALUES (99, 'receipt-11', '@id_userBPqBoCh_xILbpXln474bD', 5, 'Cimol-nya enak banget! Gurih dan renyah.', 7, '2022-07-20 21:18:40.758786+00');
INSERT INTO public.ratings VALUES (106, 'receipt-12', '@id_userBPqBoCh_xILbpXln474bD', 5, 'Cilor-nya enak banget! Gurih dan renyah.', 3, '2023-02-09 05:01:57.597083+00');
INSERT INTO public.ratings VALUES (120, 'receipt-14', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Gorengan sukun ini so-so saja. Tidak terlalu istimewa.', 7, '2023-07-04 14:05:02.471202+00');
INSERT INTO public.ratings VALUES (127, 'receipt-15', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Apel goreng ini enak banget. Manis dan renyah!', 1, '2023-05-18 18:57:53.451219+00');
INSERT INTO public.ratings VALUES (141, 'receipt-16', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Roti bantal ini enak banget, teksturnya lembut, dan rasanya manis.', 10, '2023-03-12 09:57:17.184661+00');
INSERT INTO public.ratings VALUES (155, 'receipt-17', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Donat selai strawberry ini enak banget. Rasanya manis dan sempurna, jadi bikin nagih.', 7, '2022-11-25 13:03:54.245316+00');
INSERT INTO public.ratings VALUES (162, 'receipt-18', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Peyek teri ini so-so aja. Biasa-biasa aja rasanya.', 8, '2023-08-04 02:47:10.365018+00');
INSERT INTO public.ratings VALUES (169, 'receipt-19', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Onde-onde ini enak banget! Isi gula merahnya manis dan lezat.', 9, '2023-03-19 01:01:26.027723+00');
INSERT INTO public.ratings VALUES (115, 'receipt-13', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Tahu bulat-nya enak. Cocok untuk camilan.', 3, '2022-01-21 00:54:31.192423+00');
INSERT INTO public.ratings VALUES (122, 'receipt-14', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Gorengan sukun ini biasa saja. Tidak terlalu spesial.', 8, '2023-05-09 05:55:28.865928+00');
INSERT INTO public.ratings VALUES (129, 'receipt-15', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Apel goreng ini manis dan enak. Cocok sebagai cemilan.', 8, '2022-05-16 13:49:20.92935+00');
INSERT INTO public.ratings VALUES (143, 'receipt-16', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Roti bantal ini lumayan, enaknya pas, dan bisa jadi teman ngemil.', 3, '2023-03-09 10:06:11.347884+00');
INSERT INTO public.ratings VALUES (157, 'receipt-17', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Donat selai strawberry ini enak dan manisnya pas. Bener-bener rasanya cocok buat camilan.', 6, '2022-12-29 20:50:16.070792+00');
INSERT INTO public.ratings VALUES (164, 'receipt-18', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Peyek teri ini lumayan enak. Cukup gurih dan renyah.', 4, '2023-05-21 21:01:46.49142+00');
INSERT INTO public.ratings VALUES (171, 'receipt-19', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Onde-onde ini oke lah. Gula merahnya cukup manis.', 9, '2022-09-15 15:47:14.119233+00');
INSERT INTO public.ratings VALUES (178, 'receipt-20', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Ote-ote ini oke lah. Sayurnya cukup gurih.', 6, '2023-04-21 03:53:21.207705+00');
INSERT INTO public.ratings VALUES (185, 'receipt-21', '@id_user3HceBhx_jIfB_Xd5_04MU', 3, 'Risol sayur ini oke. Sayurnya cukup gurih.', 5, '2022-03-06 10:55:04.312524+00');
INSERT INTO public.ratings VALUES (192, 'receipt-22', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Dadar jagung ini cukup lezat. Saya suka isian sayurnya.', 9, '2023-10-21 07:41:33.456633+00');
INSERT INTO public.ratings VALUES (199, 'receipt-23', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Peyek kacang ini cukup lezat. Saya suka rasa kacangnya.', 6, '2022-06-23 06:43:06.951577+00');
INSERT INTO public.ratings VALUES (206, 'receipt-24', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Gehu pedas ini lumayan enak. Pedasnya pas.', 2, '2022-06-27 15:49:46.265101+00');
INSERT INTO public.ratings VALUES (220, 'receipt-25', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Sempol ayam ini lumayan enak. Rasanya enak dan cocok sebagai cemilan.', 9, '2022-07-20 19:39:48.252615+00');
INSERT INTO public.ratings VALUES (213, 'receipt-26', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Combro ini lumayan enak. Rasanya enak dan cocok sebagai cemilan.', 7, '2023-01-09 08:57:27.293332+00');
INSERT INTO public.ratings VALUES (32, 'receipt-1', '@id_user--E2er8FtN-4hyFIBgzfd', 3, 'Cireng pedas ini so-so aja buat aku. Gak terlalu terasa pedesnya sih. Mungkin butuh bumbu lebih nendang.', 6, '2022-11-08 05:32:03.550764+00');
INSERT INTO public.ratings VALUES (39, 'receipt-2', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka. Tempe mendoannya terlalu gurih dan tidak begitu enak menurut saya.', 4, '2022-07-15 12:12:46.00665+00');
INSERT INTO public.ratings VALUES (46, 'receipt-3', '@id_user--E2er8FtN-4hyFIBgzfd', 3, 'Pisang gorengnya biasa aja menurutku, rasanya standar, nggak ada yang istimewa.', 8, '2022-04-16 22:44:44.237594+00');
INSERT INTO public.ratings VALUES (176, 'receipt-20', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Ote-ote ini lumayan enak. Isian sayurnya terasa segar.', 4, '2022-09-08 17:40:19.463+00');
INSERT INTO public.ratings VALUES (183, 'receipt-21', '@id_userBPqBoCh_xILbpXln474bD', 4, 'Risol sayur ini lumayan enak. Isian sayurannya segar.', 8, '2023-04-11 22:12:47.453691+00');
INSERT INTO public.ratings VALUES (190, 'receipt-22', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Dadar jagung ini biasa saja, kurang gurih.', 6, '2022-01-18 13:46:53.297757+00');
INSERT INTO public.ratings VALUES (197, 'receipt-23', '@id_userBPqBoCh_xILbpXln474bD', 3, 'Peyek kacang ini biasa saja, kurang gurih.', 5, '2022-10-24 08:50:30.690297+00');
INSERT INTO public.ratings VALUES (53, 'receipt-4', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kentang gorengnya biasa aja, nggak ada yang istimewa menurutku.', 8, '2022-05-04 00:41:50.327783+00');
INSERT INTO public.ratings VALUES (60, 'receipt-5', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Agak kecewa sama rempeyek udang ini. Udangnya keras, gurihnya kurang, dan rasanya biasa aja. Boleh lebih baik cawapres diganti sama yang lain.', 7, '2023-11-14 10:15:52.409646+00');
INSERT INTO public.ratings VALUES (67, 'receipt-6', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Biasa aja sih, bakwan ini. Gak terlalu istimewa. Renyahnya biasa, sayurannya juga biasa. Mungkin butuh bumbu yang lebih enak.', 3, '2022-12-09 04:13:58.885956+00');
INSERT INTO public.ratings VALUES (74, 'receipt-7', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan ubi tepung goreng ini. Rasanya gak sepadan dengan kerjaannya bikin. Terlalu plain.', 6, '2022-04-15 08:01:39.127679+00');
INSERT INTO public.ratings VALUES (81, 'receipt-8', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka perkedel ini. Rasanya biasa aja dan terlalu plain.', 8, '2022-12-05 00:58:42.740083+00');
INSERT INTO public.ratings VALUES (88, 'receipt-9', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Tahu isinya biasa aja. Tidak terlalu istimewa. Yang istimewa hanya merangkap jabatan', 2, '2023-11-21 17:05:56.130919+00');
INSERT INTO public.ratings VALUES (95, 'receipt-10', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Tidak suka molen ini. Isiannya kurang manis dan terlalu biasa.', 2, '2023-01-03 20:07:04.169226+00');
INSERT INTO public.ratings VALUES (102, 'receipt-11', '@id_user--E2er8FtN-4hyFIBgzfd', 1, 'Tidak suka cimol ini. Terlalu hambar dan tidak enak.', 2, '2022-03-12 20:17:25.059197+00');
INSERT INTO public.ratings VALUES (109, 'receipt-12', '@id_user--E2er8FtN-4hyFIBgzfd', 1, 'Tidak suka cilor ini. Terlalu hambar dan tidak enak.', 1, '2023-06-01 00:23:59.562511+00');
INSERT INTO public.ratings VALUES (116, 'receipt-13', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Saya tidak terlalu suka dengan tahu bulat ini. Rasanya kurang istimewa.', 10, '2022-01-01 09:32:41.170245+00');
INSERT INTO public.ratings VALUES (123, 'receipt-14', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Rasa gorengan sukun ini kurang memuaskan. Terlalu garing.', 9, '2022-01-08 14:53:32.860444+00');
INSERT INTO public.ratings VALUES (130, 'receipt-15', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Apel goreng ini terlalu manis buat saya. Tidak terlalu suka.', 10, '2023-01-12 01:15:59.769263+00');
INSERT INTO public.ratings VALUES (144, 'receipt-16', '@id_user--E2er8FtN-4hyFIBgzfd', 3, 'Biasa saja, rasanya standar. Tidak ada yang istimewa. Bisa jadi camilan sehari-hari.', 3, '2022-08-26 20:14:52.977699+00');
INSERT INTO public.ratings VALUES (158, 'receipt-17', '@id_user--E2er8FtN-4hyFIBgzfd', 3, 'Donatnya biasa saja, gak ada yang istimewa. Kurang greget rasanya.', 7, '2023-05-03 07:41:15.680844+00');
INSERT INTO public.ratings VALUES (165, 'receipt-18', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan peyek teri ini. Terlalu asin buat saya.', 4, '2022-09-01 02:34:19.505392+00');
INSERT INTO public.ratings VALUES (172, 'receipt-19', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan onde-onde ini. Isinya terlalu manis buat saya.', 4, '2023-09-06 19:45:27.114111+00');
INSERT INTO public.ratings VALUES (179, 'receipt-20', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan ote-ote ini. Sayurnya terlalu banyak.', 9, '2023-09-08 23:59:54.82669+00');
INSERT INTO public.ratings VALUES (186, 'receipt-21', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan risol sayur ini. Sayurnya terlalu banyak.', 10, '2022-04-09 06:09:54.910819+00');
INSERT INTO public.ratings VALUES (193, 'receipt-22', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan dadar jagung ini. Terlalu banyak jagung.', 9, '2023-04-15 16:21:14.258635+00');
INSERT INTO public.ratings VALUES (200, 'receipt-23', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Kurang suka dengan peyek kacang ini. Terlalu gurih.', 6, '2023-08-17 13:17:41.147583+00');
INSERT INTO public.ratings VALUES (207, 'receipt-24', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Saya kurang suka dengan gehu pedas ini. Terlalu pedas dan tidak cocok untuk saya.', 5, '2022-06-18 07:15:06.745319+00');
INSERT INTO public.ratings VALUES (221, 'receipt-25', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Saya kurang suka dengan sempol ayam ini. Rasanya biasa saja. Tidak cocok sebagai cemilan.', 4, '2022-01-08 04:03:43.38261+00');
INSERT INTO public.ratings VALUES (214, 'receipt-26', '@id_user--E2er8FtN-4hyFIBgzfd', 2, 'Saya kurang suka dengan combro ini. Rasanya biasa saja. Tidak cocok sebagai cemilan.', 6, '2023-04-07 13:47:50.684448+00');
INSERT INTO public.ratings VALUES (33, 'receipt-1', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Cireng pedas ini kepedesan banget, bro! Buat aku terlalu kerasa pedesnya sampe gak bisa dinikmati.', 8, '2022-06-07 17:16:17.034211+00');
INSERT INTO public.ratings VALUES (40, 'receipt-2', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Gak enak banget. Tempe mendoannya keras dan terlalu gurih.', 9, '2023-02-11 00:30:56.586997+00');
INSERT INTO public.ratings VALUES (208, 'receipt-24', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Rasanya terlalu pedas dan tidak enak.', 1, '2023-09-28 21:51:50.998708+00');
INSERT INTO public.ratings VALUES (222, 'receipt-25', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Sempol ayam ini tidak enak. Tidak cocok sebagai cemilan.', 10, '2022-10-24 07:56:39.959521+00');
INSERT INTO public.ratings VALUES (215, 'receipt-26', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Combro ini tidak enak. Tidak cocok sebagai cemilan.', 9, '2023-02-28 18:00:03.474195+00');
INSERT INTO public.ratings VALUES (69, 'receipt-6', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Bakwan ini juara, sambelnya juga pedas banget. Pokoknya gak nyesel nyobain.', 7, '2023-08-02 04:55:14.899791+00');
INSERT INTO public.ratings VALUES (76, 'receipt-7', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Ubi tepung goreng ini enak, meskipun rasanya standar. Cocok buat cemilan sore.', 3, '2023-09-12 19:10:49.172822+00');
INSERT INTO public.ratings VALUES (83, 'receipt-8', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Perkedelnya enak meskipun biasa aja. Cocok buat cemilan.', 4, '2022-07-30 15:14:08.858959+00');
INSERT INTO public.ratings VALUES (90, 'receipt-9', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Tahu isinya oke, cocok buat camilan pas lagi demo di monas', 10, '2022-03-24 15:16:09.45458+00');
INSERT INTO public.ratings VALUES (97, 'receipt-10', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Molen-nya oke lah. Tidak terlalu istimewa.', 7, '2022-02-27 14:55:44.085709+00');
INSERT INTO public.ratings VALUES (104, 'receipt-11', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Cimol-nya lumayan enak. Pedasnya pas.', 3, '2023-10-29 16:52:23.066128+00');
INSERT INTO public.ratings VALUES (111, 'receipt-12', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Cilor-nya lumayan enak. Pedasnya pas.', 9, '2022-01-28 14:16:20.53676+00');
INSERT INTO public.ratings VALUES (118, 'receipt-13', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Rasa tahu bulat ini pas. Saya suka.', 8, '2022-10-01 08:37:36.418438+00');
INSERT INTO public.ratings VALUES (125, 'receipt-14', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Rasa gorengan sukun ini cukup enak. Saya suka.', 7, '2023-01-18 04:10:31.671774+00');
INSERT INTO public.ratings VALUES (132, 'receipt-15', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 3, 'Apel goreng ini biasa saja. Terlalu manis buat saya.', 5, '2023-06-30 06:19:27.158478+00');
INSERT INTO public.ratings VALUES (146, 'receipt-16', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Roti bantal ini luar biasa! Teksturnya lembut, rasa manisnya pas, dan toppingnya bikin nagih. Makin banyak, makin enak!', 9, '2022-05-28 06:04:40.028349+00');
INSERT INTO public.ratings VALUES (160, 'receipt-17', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Donat selai strawberry ini bener-bener juara! Gak nahan buat ngunyah. Teksturnya pas, rasanya top.', 2, '2023-06-20 23:34:21.752257+00');
INSERT INTO public.ratings VALUES (167, 'receipt-18', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Peyek teri ini gurih dan enak. Cocok sebagai camilan sambil nonton TV.', 3, '2022-08-17 05:52:11.848574+00');
INSERT INTO public.ratings VALUES (174, 'receipt-19', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Onde-onde ini enak dan gurih. Cocok sebagai camilan.', 1, '2023-10-24 21:59:33.619344+00');
INSERT INTO public.ratings VALUES (181, 'receipt-20', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Ote-ote ini enak dan cocok sebagai camilan.', 5, '2023-07-10 04:16:52.59694+00');
INSERT INTO public.ratings VALUES (58, 'receipt-5', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Rempeyek udang ini enak, udangnya gurih, tapi mungkin bisa sedikit lebih pedas. Tapi jangan bawa keluarga ke kursi.', 10, '2023-04-19 01:24:46.752282+00');
INSERT INTO public.ratings VALUES (65, 'receipt-6', '@id_userEW3XETwzatHLUsLIhpdh8', 5, 'Bakwan ini juara! Enak banget, sayurannya segar, dan pas banget sama sambelnya. Pokoknya top deh!', 9, '2022-11-10 00:54:38.666114+00');
INSERT INTO public.ratings VALUES (72, 'receipt-7', '@id_userEW3XETwzatHLUsLIhpdh8', 4, 'Ubi tepung goreng ini cukup enak. Tapi mungkin bisa lebih gurih lagi.', 6, '2022-03-04 07:07:13.691107+00');
INSERT INTO public.ratings VALUES (31, 'receipt-1', '@id_user3HceBhx_jIfB_Xd5_04MU', 4, 'Cireng pedasnya sih oke lah, pedesnya masih bisa dinikmati. Gak terlalu nekukin. Bagus buat temen-temen yang suka makan pedes.', 6, '2022-11-28 03:08:53.65414+00');
INSERT INTO public.ratings VALUES (47, 'receipt-3', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Jujur, aku nggak suka pisang goreng ini. Terlalu manis dan terlalu berminyak menurutku.', 3, '2022-06-25 22:49:21.390164+00');
INSERT INTO public.ratings VALUES (54, 'receipt-4', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Kentang goreng ini kebanyakan gurihnya, jadi nggak enak buatku. Lebih suka yang biasa.', 8, '2022-11-08 19:16:41.690845+00');
INSERT INTO public.ratings VALUES (61, 'receipt-5', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Nggak suka sama sekali. Rempeyek udang ini aneh banget rasanya. Udangnya keras dan aneh. Nggak bakal nyalon lagi deh.', 7, '2023-06-28 06:17:31.585933+00');
INSERT INTO public.ratings VALUES (68, 'receipt-6', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Nggak suka banget sama bakwan ini. Kenapa sayurannya dikasih terlalu banyak? Terlalu banyak wortel, kurang bakwannya.', 10, '2022-10-20 05:44:31.278423+00');
INSERT INTO public.ratings VALUES (75, 'receipt-7', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Ubi tepung goreng ini menurut saya gak enak sama sekali. Kurang gurih dan terlalu plain.', 6, '2022-11-11 20:34:56.454971+00');
INSERT INTO public.ratings VALUES (82, 'receipt-8', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Gak suka perkedel ini sama sekali. Terlalu plain dan gurihnya kurang.', 9, '2022-03-30 04:12:09.310408+00');
INSERT INTO public.ratings VALUES (89, 'receipt-9', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Tidak suka sama sekali. Tahu isinya tidak enak dan kurang gurih. Mending makan proyek menara BTS', 5, '2023-07-23 03:43:47.53287+00');
INSERT INTO public.ratings VALUES (55, 'receipt-4', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Kentang gorengnya enak, tapi mungkin kurang sedikit bumbu. Tapi masih lumayan enak.', 8, '2022-10-01 09:39:00.2917+00');
INSERT INTO public.ratings VALUES (62, 'receipt-5', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Rempeyek udang ini enak. Gurihnya pas, pedasnya pas, dan udangnya besar. Cuma mungkin bisa lebih ikhlas lagi ya.. kalau kalah.', 10, '2023-05-16 16:22:32.783121+00');
INSERT INTO public.ratings VALUES (188, 'receipt-21', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 5, 'Risol sayur ini enak dan cocok sebagai camilan.', 3, '2023-01-16 18:33:57.475837+00');
INSERT INTO public.ratings VALUES (195, 'receipt-22', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 3, 'Dadar jagung ini oke. Tapi terlalu banyak jagung.', 7, '2023-07-04 19:45:33.748193+00');
INSERT INTO public.ratings VALUES (202, 'receipt-23', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 3, 'Peyek kacang ini oke. Tapi terlalu gurih.', 8, '2023-05-31 10:19:19.707849+00');
INSERT INTO public.ratings VALUES (209, 'receipt-24', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 2, 'Gehu pedas ini tidak enak. Terlalu pedas.', 1, '2023-10-08 06:51:50.299501+00');
INSERT INTO public.ratings VALUES (223, 'receipt-25', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 2, 'Sempol ayam ini rasanya biasa saja. Tidak cocok sebagai cemilan.', 6, '2023-04-11 18:25:41.798783+00');
INSERT INTO public.ratings VALUES (216, 'receipt-26', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 2, 'Combro ini rasanya biasa saja. Tidak cocok sebagai cemilan.', 1, '2022-08-25 12:51:53.919112+00');
INSERT INTO public.ratings VALUES (35, 'receipt-1', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-12-05 09:47:30.417476+00');
INSERT INTO public.ratings VALUES (91, 'receipt-9', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-09-08 09:12:19.533652+00');
INSERT INTO public.ratings VALUES (98, 'receipt-10', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-08-05 06:04:37.206287+00');
INSERT INTO public.ratings VALUES (105, 'receipt-11', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-10-23 19:03:54.193059+00');
INSERT INTO public.ratings VALUES (112, 'receipt-12', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-09-12 08:13:43.356248+00');
INSERT INTO public.ratings VALUES (119, 'receipt-13', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-01-13 15:10:15.236247+00');
INSERT INTO public.ratings VALUES (126, 'receipt-14', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-01-28 12:05:18.354707+00');
INSERT INTO public.ratings VALUES (133, 'receipt-15', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-12-24 05:51:24.46309+00');
INSERT INTO public.ratings VALUES (147, 'receipt-16', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-07-18 04:57:41.12384+00');
INSERT INTO public.ratings VALUES (161, 'receipt-17', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-12-20 13:33:28.252703+00');
INSERT INTO public.ratings VALUES (168, 'receipt-18', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-06-05 18:04:13.284573+00');
INSERT INTO public.ratings VALUES (175, 'receipt-19', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-10-23 14:20:07.880771+00');
INSERT INTO public.ratings VALUES (182, 'receipt-20', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-06-26 09:15:15.780533+00');
INSERT INTO public.ratings VALUES (189, 'receipt-21', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-06-12 07:06:40.121273+00');
INSERT INTO public.ratings VALUES (196, 'receipt-22', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-02-28 14:19:18.244816+00');
INSERT INTO public.ratings VALUES (203, 'receipt-23', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-04-25 01:08:31.048764+00');
INSERT INTO public.ratings VALUES (210, 'receipt-24', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2022-02-01 06:53:34.343866+00');
INSERT INTO public.ratings VALUES (224, 'receipt-25', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, '', 0, '2023-11-26 01:31:29.587861+00');
INSERT INTO public.ratings VALUES (217, 'receipt-26', '@id_userk3a8NtJBKgCPSkPPSaBaA', 5, 'Cemilan yang enak.', 0, '2022-08-31 20:26:57.990561+00');
INSERT INTO public.ratings VALUES (96, 'receipt-10', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Molen ini sangat mengecewakan. Tidak enak sama sekali.', 10, '2022-02-11 08:13:10.1199+00');
INSERT INTO public.ratings VALUES (103, 'receipt-11', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Cimol ini terlalu pedas. Tidak bisa saya makan.', 3, '2022-08-17 07:20:10.45948+00');
INSERT INTO public.ratings VALUES (110, 'receipt-12', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Cilor ini terlalu pedas. Tidak bisa saya makan.', 2, '2022-08-09 09:36:34.427599+00');
INSERT INTO public.ratings VALUES (117, 'receipt-13', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Tahu bulat ini terlalu garing dan tidak enak.', 7, '2023-10-10 06:41:53.50736+00');
INSERT INTO public.ratings VALUES (124, 'receipt-14', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Saya tidak suka dengan gorengan sukun ini. Terlalu keras.', 9, '2022-03-31 12:56:30.977149+00');
INSERT INTO public.ratings VALUES (131, 'receipt-15', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Saya tidak suka dengan apel goreng ini. Terlalu manis dan berminyak.', 1, '2023-08-17 15:14:46.604157+00');
INSERT INTO public.ratings VALUES (145, 'receipt-16', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Jujur, saya kurang suka dengan roti bantal ini. Terlalu manis dan teksturnya aneh. Tidak cocok bagi saya.', 2, '2022-05-02 17:25:29.800484+00');
INSERT INTO public.ratings VALUES (159, 'receipt-17', '@id_user52nNBdoEinsLnYkhzHPcX', 2, 'Menurut saya, donat selai strawberry ini terlalu manis dan gak sebanding sama rasanya.', 5, '2023-04-08 17:20:20.277848+00');
INSERT INTO public.ratings VALUES (166, 'receipt-18', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Peyek teri ini rasanya terlalu asin dan kurang enak. Tidak cocok di lidah saya.', 5, '2023-04-21 16:30:20.061708+00');
INSERT INTO public.ratings VALUES (173, 'receipt-19', '@id_user52nNBdoEinsLnYkhzHPcX', 4, 'Onde-onde ini biasa saja. Tidak terlalu istimewa.', 2, '2023-05-01 01:58:08.332176+00');
INSERT INTO public.ratings VALUES (180, 'receipt-20', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Ote-ote ini terlalu berminyak dan tidak enak.', 10, '2022-03-01 09:31:56.387836+00');
INSERT INTO public.ratings VALUES (187, 'receipt-21', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Risol sayur ini terlalu berminyak dan tidak enak.', 5, '2022-10-28 10:50:58.519951+00');
INSERT INTO public.ratings VALUES (194, 'receipt-22', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Dadar jagung ini terlalu berminyak dan tidak enak.', 2, '2022-01-28 02:50:44.418938+00');
INSERT INTO public.ratings VALUES (201, 'receipt-23', '@id_user52nNBdoEinsLnYkhzHPcX', 1, 'Peyek kacang ini terlalu keras dan tidak enak.', 5, '2023-10-02 00:31:56.836707+00');
INSERT INTO public.ratings VALUES (34, 'receipt-1', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Cireng pedas ini oke, bro! Pedesnya ngejuara, mantap buat yang suka makanan pedes.', 5, '2022-08-22 16:37:48.730241+00');
INSERT INTO public.ratings VALUES (41, 'receipt-2', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Camilan yang lumayan. Tempe mendoannya renyah dan gurih.', 1, '2022-03-20 01:10:55.269531+00');
INSERT INTO public.ratings VALUES (48, 'receipt-3', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 4, 'Pisang gorengnya enak, walaupun mungkin agak berminyak. Tapi aku suka gurihnya.', 7, '2022-10-30 17:16:40.949508+00');


--
-- TOC entry 3755 (class 0 OID 28585)
-- Dependencies: 278
-- Data for Name: recipes; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.recipes VALUES ('receipt-23', '@id_user--E2er8FtN-4hyFIBgzfd', 'Peyek Kacang', 'Buah', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_kacang.jpg', 'Mudah', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-24', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 'Gehu Pedas UGD', 'Kedelai', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/gehu_pedas.jpg', 'Sedang', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-26', '@id_userEW3XETwzatHLUsLIhpdh8', 'Combro', 'Isian Sayur', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/combro.jpg', 'Mudah', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-25', '@id_userEW3XETwzatHLUsLIhpdh8', 'Sempol Chicken Kentucky', 'Aci', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/sempol.png', 'Mudah', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-19', '@id_userEW3XETwzatHLUsLIhpdh8', 'Onde-Onde Ibukota', 'Manis', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/onde_onde.jpg', 'Mudah', 20, 60, '4.5');
INSERT INTO public.recipes VALUES ('receipt-1', '@id_user52nNBdoEinsLnYkhzHPcX', 'Cireng Pedas Nuklir', 'Aci', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cireng.jpg', 'Mudah', 3, 30, '4.75');
INSERT INTO public.recipes VALUES ('receipt-2', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 'Tempe Mendoan KFC', 'Kedelai', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/mendoan.jpg', 'Mudah', 6, 30, '4.2');
INSERT INTO public.recipes VALUES ('receipt-3', '@id_user--E2er8FtN-4hyFIBgzfd', 'Pisang Goreng Starbucks', 'Buah', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/pisang_goreng.jpg', 'Mudah', 10, 30, '4.1');
INSERT INTO public.recipes VALUES ('receipt-4', '@id_user--E2er8FtN-4hyFIBgzfd', 'Kentang Goreng Istana Negara', 'Kentang', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/kentang_goreng_pedas.jpg', 'Sedang', 40, 45, '4.3');
INSERT INTO public.recipes VALUES ('receipt-5', '@id_user52nNBdoEinsLnYkhzHPcX', 'Rempeyek Udang Cak Owi', 'Ikan', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_udang.jpg', 'Sedang', 20, 45, '4.2');
INSERT INTO public.recipes VALUES ('receipt-6', '@id_userUIjuDuhJ_QnJbdiA_z1F_', 'Bakwan Sahabat Kolesterol', 'Isian Sayur', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/bakwan.jpg', 'Mudah', 10, 40, '4.0');
INSERT INTO public.recipes VALUES ('receipt-7', '@id_user3HceBhx_jIfB_Xd5_04MU', 'Ubi Jalar yang diberi Tepung', 'Manis', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/ubi_jalar.jpg', 'Mudah', 5, 40, '3.8');
INSERT INTO public.recipes VALUES ('receipt-8', '@id_userEW3XETwzatHLUsLIhpdh8', 'Perkedel (Persatuan Kentang dan Telur)', 'Kentang', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/perkedel.jpg', 'Sedang', 7, 40, '2.9');
INSERT INTO public.recipes VALUES ('receipt-9', '@id_userEW3XETwzatHLUsLIhpdh8', 'Tahu Isi Harapan Rakyat', 'Kedelai', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/tahu_isi.jpg', 'Mudah', 8, 30, '4.9');
INSERT INTO public.recipes VALUES ('receipt-10', '@id_userBPqBoCh_xILbpXln474bD', 'Molen', 'Manis', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/molen.jpg', 'Sulit', 10, 40, '4');
INSERT INTO public.recipes VALUES ('receipt-11', '@id_userEW3XETwzatHLUsLIhpdh8', 'Cimol', 'Aci', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cimol.jpg', 'Mudah', 5, 40, '4.0');
INSERT INTO public.recipes VALUES ('receipt-12', '@id_user52nNBdoEinsLnYkhzHPcX', 'Cilor', 'Aci', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/cilor.jpg', 'Sedang', 3, 45, '4.2');
INSERT INTO public.recipes VALUES ('receipt-13', '@id_user52nNBdoEinsLnYkhzHPcX', 'Tahu Bulat Digoreng Dadakan', 'Kedelai', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/tahu_bulat.jpg', 'Sedang', 3, 30, '4.6');
INSERT INTO public.recipes VALUES ('receipt-14', '@id_user52nNBdoEinsLnYkhzHPcX', 'Sukun', 'Buah', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/sukun.jpg', 'Mudah', 2, 45, '4.1');
INSERT INTO public.recipes VALUES ('receipt-15', '@id_userk3a8NtJBKgCPSkPPSaBaA', 'Apel Goreng Pak Newton', 'Buah', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/apel_goreng.jpg', 'Mudah', 4, 30, '4.3');
INSERT INTO public.recipes VALUES ('receipt-16', '@id_userk3a8NtJBKgCPSkPPSaBaA', 'Roti Bantal Tidur', 'Manis', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/roti_bantal.jpg', 'Mudah', 4, 30, '4.5');
INSERT INTO public.recipes VALUES ('receipt-17', '@id_user3HceBhx_jIfB_Xd5_04MU', 'Donat Strawberry', 'Manis', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/donat_strawberry.jpg', 'Sedang', 12, 60, '4.5');
INSERT INTO public.recipes VALUES ('receipt-18', '@id_userk3a8NtJBKgCPSkPPSaBaA', 'Peyek Teri Ma Kasih', 'Ikan', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/peyek_teri.jpg', 'Mudah', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-20', '@id_user52nNBdoEinsLnYkhzHPcX', 'Ote-Ote', 'Isian Sayur', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/ote_ote.jpg', 'Mudah', 4, 45, '4.5');
INSERT INTO public.recipes VALUES ('receipt-21', '@id_userBPqBoCh_xILbpXln474bD', 'Risol Sayur', 'Isian Sayur', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/risol_sayur.jpg', 'Sedang', 12, 60, '4.5');
INSERT INTO public.recipes VALUES ('receipt-22', '@id_userk3a8NtJBKgCPSkPPSaBaA', 'Dadar Jagung', 'Isian sayur', 'https://kcdozmuijfkbhixjccgw.supabase.co/storage/v1/object/public/gorenganindonesia/dadar_jagung.jpg', 'Mudah', 4, 45, '4.5');


--
-- TOC entry 3759 (class 0 OID 28628)
-- Dependencies: 282
-- Data for Name: steps; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.steps VALUES ('receipt-1', 1, 'Campur tepung kanji, tepung terigu, bawang putih, garam, gula, dan kaldu ayam bubuk (jika digunakan) dalam mangkuk besar.');
INSERT INTO public.steps VALUES ('receipt-1', 2, 'Tambahkan air perlahan-lahan sambil terus diaduk hingga membentuk adonan yang kental dan elastis. Pastikan tidak ada gumpalan.');
INSERT INTO public.steps VALUES ('receipt-1', 3, 'Bentuk adonan menjadi silinder panjang dan potong-potong menjadi bagian berukuran sekitar 5 cm.');
INSERT INTO public.steps VALUES ('receipt-1', 4, 'Panaskan minyak dalam wajan hingga cukup panas. Goreng cireng hingga kecokelatan dan mengembang, sekitar 4-5 menit.');
INSERT INTO public.steps VALUES ('receipt-1', 5, 'Angkat cireng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-1', 6, 'Untuk bumbu pedas manis (opsional), campur semua bahan bumbu dalam mangkuk kecil dan aduk rata.');
INSERT INTO public.steps VALUES ('receipt-1', 7, 'Celupkan cireng dalam bumbu pedas manis atau sajikan bumbu tersebut sebagai saus.');
INSERT INTO public.steps VALUES ('receipt-2', 1, 'Campur tepung terigu, tepung beras, merica bubuk, dan garam dalam mangkuk.');
INSERT INTO public.steps VALUES ('receipt-2', 2, 'Tambahkan air es ke dalam campuran tepung sambil terus diaduk hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-2', 3, 'Celupkan potongan tempe ke dalam adonan tepung.');
INSERT INTO public.steps VALUES ('receipt-2', 4, 'Panaskan minyak dalam wajan dan goreng tempe yang telah dicelupkan ke dalam adonan tepung hingga kecokelatan dan renyah, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-3', 1, 'Kupas pisang dan potong sesuai selera.');
INSERT INTO public.steps VALUES ('receipt-3', 2, 'Campur tepung terigu, tepung beras, garam, gula, dan air hingga membentuk adonan yang kental dan melekat pada pisang.');
INSERT INTO public.steps VALUES ('receipt-3', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-3', 4, 'Celupkan potongan pisang ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-3', 5, 'Angkat pisang goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-4', 1, 'Kupas kentang dan potong sesuai selera.');
INSERT INTO public.steps VALUES ('receipt-4', 2, 'Campurkan tepung terigu, merica bubuk, garam, dan bawang putih bubuk dalam mangkuk.');
INSERT INTO public.steps VALUES ('receipt-4', 3, 'Celupkan potongan kentang ke dalam adonan tepung hingga rata.');
INSERT INTO public.steps VALUES ('receipt-4', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-4', 5, 'Goreng kentang hingga kecokelatan dan renyah, sekitar 5-7 menit.');
INSERT INTO public.steps VALUES ('receipt-4', 6, 'Tiriskan kentang goreng di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-4', 7, 'Sajikan kentang goreng dengan saus pedas sebagai pelengkap.');
INSERT INTO public.steps VALUES ('receipt-16', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-5', 1, 'Campur tepung beras, tepung terigu, udang, air, bawang putih, garam, gula, dan kaldu bubuk dalam mangkuk hingga membentuk adonan yang kental dan melekat pada udang.');
INSERT INTO public.steps VALUES ('receipt-5', 2, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-5', 3, 'Celupkan udang ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-5', 4, 'Angkat peyek udang dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-6', 1, 'Campur tepung terigu, air, bawang putih, garam, gula, kaldu bubuk, dan garam dalam mangkuk hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-6', 2, 'Tambahkan tauge, wortel, kol, dan daun bawang ke dalam adonan. Aduk rata.');
INSERT INTO public.steps VALUES ('receipt-6', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-6', 4, 'Ambil satu sendok sayur adonan dan goreng hingga kecokelatan, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-6', 5, 'Angkat bakwan dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-7', 1, 'Kupas ubi jalar dan iris tipis-tipis.');
INSERT INTO public.steps VALUES ('receipt-7', 2, 'Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-7', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-7', 4, 'Celupkan irisan ubi jalar ke dalam adonan tepung dan goreng hingga kecokelatan, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-7', 5, 'Angkat gorengan ubi jalar dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-8', 1, 'Kupas kentang dan rebus hingga empuk. Haluskan kentang yang sudah direbus.');
INSERT INTO public.steps VALUES ('receipt-8', 2, 'Campurkan kentang yang sudah dihaluskan, daging ayam cincang, bawang putih, bawang merah, telur, garam, merica, dan penyedap rasa dalam mangkuk hingga merata.');
INSERT INTO public.steps VALUES ('receipt-8', 3, 'Bentuk adonan menjadi bulatan dan pipihkan.');
INSERT INTO public.steps VALUES ('receipt-8', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-8', 5, 'Goreng perkedel hingga kecokelatan, sekitar 3-5 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-8', 6, 'Angkat perkedel dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-9', 1, 'Potong tahu menjadi kotak-kotak kecil.');
INSERT INTO public.steps VALUES ('receipt-9', 2, 'Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-9', 3, 'Buka lubang di setiap potongan tahu dan isi dengan adonan.');
INSERT INTO public.steps VALUES ('receipt-9', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-9', 5, 'Goreng tahu hingga kecokelatan dan renyah, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-9', 6, 'Angkat tahu isi dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-10', 1, 'Campurkan tepung terigu, mentega, gula, garam, dan telur dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-10', 2, 'Pisahkan adonan menjadi beberapa bagian kecil. Giling setiap bagian adonan menjadi lembaran tipis.');
INSERT INTO public.steps VALUES ('receipt-10', 3, 'Olesi lembaran adonan dengan selai nanas.');
INSERT INTO public.steps VALUES ('receipt-10', 4, 'Gulung lembaran adonan seperti gulungan sushi dan potong-potong sesuai selera.');
INSERT INTO public.steps VALUES ('receipt-10', 5, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-10', 6, 'Goreng molen hingga kecokelatan, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-10', 7, 'Angkat molen dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-11', 1, 'Campurkan tepung terigu, garam, gula, bawang putih bubuk, bawang merah, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-11', 2, 'Ambil sebagian adonan dan bulatkan seperti bakso kecil. Ulangi hingga adonan habis.');
INSERT INTO public.steps VALUES ('receipt-11', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-11', 4, 'Goreng cimol hingga kecokelatan dan renyah, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-11', 5, 'Angkat cimol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-12', 1, 'Campurkan tepung kanji, tepung terigu, garam, gula, bawang putih bubuk, bawang merah, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-12', 2, 'Bentuk adonan tipis seperti kulit lumpia.');
INSERT INTO public.steps VALUES ('receipt-12', 3, 'Letakkan sepotong telur ayam di atas kulit lumpia dan bungkus rapi.');
INSERT INTO public.steps VALUES ('receipt-12', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-12', 5, 'Goreng cilor hingga kecokelatan dan renyah, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-12', 6, 'Angkat cilor dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-13', 1, 'Siapkan tahu putih bulat. Belah tahu menjadi dua bagian.');
INSERT INTO public.steps VALUES ('receipt-13', 2, 'Campurkan tepung terigu, bawang putih bubuk, garam, merica, dan air dalam mangkuk hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-13', 3, 'Celupkan setengah bagian tahu ke dalam adonan tepung hingga rata.');
INSERT INTO public.steps VALUES ('receipt-13', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-13', 5, 'Goreng tahu hingga kecokelatan dan renyah, sekitar 3-5 menit.');
INSERT INTO public.steps VALUES ('receipt-13', 6, 'Angkat tahu bulat dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-14', 1, 'Kupas sukun dan iris tipis-tipis.');
INSERT INTO public.steps VALUES ('receipt-14', 2, 'Campurkan tepung terigu, garam, merica, bawang putih bubuk, dan air dalam mangkuk hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-14', 3, 'Celupkan irisan sukun ke dalam adonan tepung hingga rata.');
INSERT INTO public.steps VALUES ('receipt-14', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-14', 5, 'Goreng sukun hingga kecokelatan dan renyah, sekitar 5-7 menit.');
INSERT INTO public.steps VALUES ('receipt-14', 6, 'Angkat sukun goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-15', 1, 'Kupas apel, buang bijinya, dan potong menjadi irisan setebal 1 cm.');
INSERT INTO public.steps VALUES ('receipt-15', 2, 'Campurkan tepung terigu, gula, garam, kayu manis, telur, dan air dalam mangkuk hingga membentuk adonan yang kental.');
INSERT INTO public.steps VALUES ('receipt-15', 3, 'Celupkan irisan apel ke dalam adonan tepung hingga rata.');
INSERT INTO public.steps VALUES ('receipt-15', 4, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-15', 5, 'Goreng irisan apel hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-15', 6, 'Angkat apel goreng dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-15', 7, 'Taburkan gula bubuk atau kayu manis bubuk sebagai hiasan jika diinginkan.');
INSERT INTO public.steps VALUES ('receipt-16', 1, 'Potong roti tawar menjadi bentuk bantal atau sesuai selera.');
INSERT INTO public.steps VALUES ('receipt-16', 2, 'Campurkan telur, susu, gula, dan garam dalam mangkuk.');
INSERT INTO public.steps VALUES ('receipt-16', 3, 'Celupkan potongan roti ke dalam campuran telur.');
INSERT INTO public.steps VALUES ('receipt-16', 5, 'Goreng roti bantal hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-16', 6, 'Angkat roti bantal dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-16', 7, 'Taburkan gula bubuk atau topping sesuai selera sebelum disajikan.');
INSERT INTO public.steps VALUES ('receipt-17', 1, 'Campurkan ragi dengan susu hangat dan 1 sendok makan gula. Biarkan ragi aktif selama 10-15 menit.');
INSERT INTO public.steps VALUES ('receipt-17', 2, 'Campurkan tepung terigu, gula, garam, telur, dan mentega dalam mangkuk besar.');
INSERT INTO public.steps VALUES ('receipt-17', 3, 'Tambahkan campuran ragi yang sudah aktif ke dalam mangkuk dan aduk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-17', 4, 'Tutup adonan dengan kain lembab dan diamkan selama 1-2 jam hingga mengembang.');
INSERT INTO public.steps VALUES ('receipt-17', 5, 'Gulungkan adonan dan potong dengan cetakan donat atau gelas untuk membuat donat bundar.');
INSERT INTO public.steps VALUES ('receipt-17', 6, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-17', 7, 'Goreng donat hingga kecokelatan, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-17', 8, 'Angkat donat dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-17', 9, 'Olesi donat dengan selai strawberry dan taburi gula bubuk sebelum disajikan.');
INSERT INTO public.steps VALUES ('receipt-18', 1, 'Campurkan terigu, air, bawang merah, bawang putih, gula, garam, dan teri dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-18', 2, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-18', 3, 'Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.');
INSERT INTO public.steps VALUES ('receipt-18', 4, 'Goreng hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-18', 5, 'Angkat peyek teri dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-19', 1, 'Campurkan tepung ketan, gula, dan daun pandan dalam mangkuk hingga tercampur rata.');
INSERT INTO public.steps VALUES ('receipt-19', 2, 'Bentuk adonan menjadi bola-bola kecil dan letakkan sepotong gula merah di tengahnya. Bulatkan kembali hingga gula merah tertutup rapat.');
INSERT INTO public.steps VALUES ('receipt-19', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-19', 4, 'Goreng onde-onde hingga kecokelatan, sekitar 3-4 menit.');
INSERT INTO public.steps VALUES ('receipt-19', 5, 'Angkat onde-onde dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-20', 1, 'Campurkan tepung terigu, bawang putih, garam, gula, merica, daun seledri, wortel, tauge, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-20', 2, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-20', 3, 'Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.');
INSERT INTO public.steps VALUES ('receipt-20', 4, 'Goreng ote-ote hingga kecokelatan dan renyah, sekitar 3-4 menit.');
INSERT INTO public.steps VALUES ('receipt-20', 5, 'Angkat ote-ote dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-21', 1, 'Siapkan kulit lumpia dan letakkan selembar di permukaan datar.');
INSERT INTO public.steps VALUES ('receipt-21', 2, 'Letakkan isian sayuran di tengah kulit lumpia.');
INSERT INTO public.steps VALUES ('receipt-21', 3, 'Lipat kedua sisi kulit lumpia ke atas, lalu gulung hingga membentuk risol.');
INSERT INTO public.steps VALUES ('receipt-21', 4, 'Campurkan tepung terigu, garam, dan air untuk membuat adonan lem tepung.');
INSERT INTO public.steps VALUES ('receipt-21', 5, 'Celupkan risol dalam adonan lem tepung, lalu gulingkan dalam tepung panir.');
INSERT INTO public.steps VALUES ('receipt-21', 6, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-21', 7, 'Goreng risol hingga kecokelatan, sekitar 3-4 menit.');
INSERT INTO public.steps VALUES ('receipt-21', 8, 'Angkat risol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-22', 1, 'Campurkan tepung terigu, tepung beras, jagung pipil, gula, garam, daun bawang, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-22', 2, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-22', 3, 'Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.');
INSERT INTO public.steps VALUES ('receipt-22', 4, 'Goreng dadar jagung hingga kecokelatan, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-22', 5, 'Angkat dadar jagung dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-23', 1, 'Campurkan tepung beras, tepung terigu, bawang putih, gula, garam, ketumbar, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-23', 2, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-23', 3, 'Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.');
INSERT INTO public.steps VALUES ('receipt-23', 4, 'Goreng peyek kacang hingga kecokelatan dan renyah, sekitar 2-3 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-23', 5, 'Angkat peyek kacang dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-24', 1, 'Potong tahu (gehu) menjadi potongan-potongan kecil sesuai selera.');
INSERT INTO public.steps VALUES ('receipt-24', 2, 'Campurkan tepung terigu, bawang putih, garam, lada, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-24', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-24', 4, 'Celupkan potongan tahu ke dalam adonan tepung hingga rata.');
INSERT INTO public.steps VALUES ('receipt-24', 5, 'Goreng tahu hingga kecokelatan dan renyah, sekitar 3-4 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-24', 6, 'Angkat tahu dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-24', 7, 'Sajikan tahu pedas dengan saus cabai atau saus sambal sebagai pelengkap.');
INSERT INTO public.steps VALUES ('receipt-25', 1, 'Campurkan tepung terigu, bawang putih, bawang merah, daun seledri, garam, merica, telur, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-25', 2, 'Tambahkan potongan daging sosis ke dalam adonan.');
INSERT INTO public.steps VALUES ('receipt-25', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-25', 4, 'Ambil sebagian adonan dengan sendok dan letakkan ke dalam minyak panas.');
INSERT INTO public.steps VALUES ('receipt-25', 5, 'Goreng sempol hingga kecokelatan dan matang, sekitar 3-4 menit.');
INSERT INTO public.steps VALUES ('receipt-25', 6, 'Angkat sempol dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');
INSERT INTO public.steps VALUES ('receipt-26', 1, 'Campurkan tepung ketan, kelapa parut, daun bawang, daun kemangi, garam, merica, dan air dalam mangkuk hingga membentuk adonan kalis.');
INSERT INTO public.steps VALUES ('receipt-26', 2, 'Bentuk adonan menjadi bulatan pipih dan letakkan sepotong oncom di tengahnya. Bulatkan kembali hingga oncom tertutup rapat.');
INSERT INTO public.steps VALUES ('receipt-26', 3, 'Panaskan minyak dalam wajan hingga cukup panas.');
INSERT INTO public.steps VALUES ('receipt-26', 4, 'Goreng combro hingga kecokelatan, sekitar 3-4 menit di setiap sisi.');
INSERT INTO public.steps VALUES ('receipt-26', 5, 'Angkat combro dan tiriskan di atas tisu dapur untuk menghilangkan kelebihan minyak.');


--
-- TOC entry 3753 (class 0 OID 28560)
-- Dependencies: 276
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES ('@id_userBPqBoCh_xILbpXln474bD', 'Asrofil Fachrul Riidlo', 'asrofil', 'asrofil@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_userEW3XETwzatHLUsLIhpdh8', 'Sari Puspita Hasna', 'hasna', 'hasna@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_user3HceBhx_jIfB_Xd5_04MU', 'Alya Hamida', 'alya', 'alya@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_user--E2er8FtN-4hyFIBgzfd', 'Riga Normanda Putra', 'riga', 'riga@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_user52nNBdoEinsLnYkhzHPcX', 'Surya Aditya Angga Siswanto', 'surya', 'surya@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_userUIjuDuhJ_QnJbdiA_z1F_', 'Ghina Faridah', 'ghina', 'ghina@mail.com', 'https://placehold.co/200x200?text=\n');
INSERT INTO public.users VALUES ('@id_userk3a8NtJBKgCPSkPPSaBaA', 'admin', 'admin', 'admin@mail.com', 'https://placehold.co/200x200?text=\n');


--
-- TOC entry 3782 (class 0 OID 0)
-- Dependencies: 280
-- Name: ratings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ratings_id_seq', 224, true);


--
-- TOC entry 3583 (class 2606 OID 28661)
-- Name: auth auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_pk PRIMARY KEY (user_id, password);


--
-- TOC entry 3577 (class 2606 OID 28570)
-- Name: users email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT email_unique UNIQUE (email);


--
-- TOC entry 3593 (class 2606 OID 28649)
-- Name: favourites favourites_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_pkey PRIMARY KEY (id);


--
-- TOC entry 3589 (class 2606 OID 28617)
-- Name: ratings ratings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_pkey PRIMARY KEY (id);


--
-- TOC entry 3585 (class 2606 OID 28591)
-- Name: recipes receipts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_pkey PRIMARY KEY (id);


--
-- TOC entry 3587 (class 2606 OID 28593)
-- Name: recipes receipts_title_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_title_key UNIQUE (title);


--
-- TOC entry 3591 (class 2606 OID 28634)
-- Name: steps steps_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_pkey PRIMARY KEY (recipe_id, step);


--
-- TOC entry 3579 (class 2606 OID 28568)
-- Name: users username_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username_unique UNIQUE (username);


--
-- TOC entry 3581 (class 2606 OID 28566)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3594 (class 2606 OID 28576)
-- Name: auth auth_ibfk_1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auth
    ADD CONSTRAINT auth_ibfk_1 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3600 (class 2606 OID 28753)
-- Name: favourites favourites_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT favourites_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3601 (class 2606 OID 28650)
-- Name: favourites fk_fav_user_id_users_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.favourites
    ADD CONSTRAINT fk_fav_user_id_users_id FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3596 (class 2606 OID 28748)
-- Name: ingredients ingredients_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT ingredients_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3597 (class 2606 OID 28743)
-- Name: ratings ratings_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3598 (class 2606 OID 28623)
-- Name: ratings ratings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ratings
    ADD CONSTRAINT ratings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- TOC entry 3595 (class 2606 OID 28594)
-- Name: recipes receipts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recipes
    ADD CONSTRAINT receipts_user_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 3599 (class 2606 OID 28738)
-- Name: steps steps_recipe_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.steps
    ADD CONSTRAINT steps_recipe_id_fkey FOREIGN KEY (recipe_id) REFERENCES public.recipes(id) ON DELETE CASCADE;


--
-- TOC entry 3768 (class 0 OID 0)
-- Dependencies: 3766
-- Name: DATABASE postgres; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON DATABASE postgres TO dashboard_user;


--
-- TOC entry 3771 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 3772 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.auth TO anon;
GRANT ALL ON TABLE public.auth TO authenticated;
GRANT ALL ON TABLE public.auth TO service_role;


--
-- TOC entry 3773 (class 0 OID 0)
-- Dependencies: 283
-- Name: TABLE favourites; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.favourites TO anon;
GRANT ALL ON TABLE public.favourites TO authenticated;
GRANT ALL ON TABLE public.favourites TO service_role;


--
-- TOC entry 3774 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE ingredients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ingredients TO anon;
GRANT ALL ON TABLE public.ingredients TO authenticated;
GRANT ALL ON TABLE public.ingredients TO service_role;


--
-- TOC entry 3775 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE ratings; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ratings TO anon;
GRANT ALL ON TABLE public.ratings TO authenticated;
GRANT ALL ON TABLE public.ratings TO service_role;


--
-- TOC entry 3777 (class 0 OID 0)
-- Dependencies: 280
-- Name: SEQUENCE ratings_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.ratings_id_seq TO anon;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.ratings_id_seq TO service_role;


--
-- TOC entry 3778 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE recipes; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.recipes TO anon;
GRANT ALL ON TABLE public.recipes TO authenticated;
GRANT ALL ON TABLE public.recipes TO service_role;


--
-- TOC entry 3779 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE steps; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.steps TO anon;
GRANT ALL ON TABLE public.steps TO authenticated;
GRANT ALL ON TABLE public.steps TO service_role;


--
-- TOC entry 3780 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO anon;
GRANT ALL ON TABLE public.users TO authenticated;
GRANT ALL ON TABLE public.users TO service_role;


--
-- TOC entry 3781 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE user_auth; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_auth TO anon;
GRANT ALL ON TABLE public.user_auth TO authenticated;
GRANT ALL ON TABLE public.user_auth TO service_role;


--
-- TOC entry 2427 (class 826 OID 16484)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2428 (class 826 OID 16485)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2426 (class 826 OID 16483)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2430 (class 826 OID 16487)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2425 (class 826 OID 16482)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2429 (class 826 OID 16486)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


-- Completed on 2023-11-07 18:17:43 WIB

--
-- PostgreSQL database dump complete
--


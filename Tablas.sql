--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Debian 17.0-1.pgdg120+1)
-- Dumped by pg_dump version 17.0 (Debian 17.0-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: demo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.demo (
    id integer NOT NULL,
    name character varying(200) DEFAULT ''::character varying NOT NULL,
    hint text DEFAULT ''::text NOT NULL
);


--
-- Name: demo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.demo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: demo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.demo_id_seq OWNED BY public.demo.id;


--
-- Name: institucion; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institucion (
    idinstitucion integer NOT NULL,
    nombre character varying(60) NOT NULL,
    colorprincipal character varying(60) NOT NULL,
    colorsecundario character varying(60) NOT NULL,
    urllmglogo text NOT NULL,
    sede character varying(60),
    calle character varying(60),
    numerolugar character varying(60),
    ciudad character varying(60),
    correo character varying(60) NOT NULL,
    estado character varying(60)
);


--
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institucion_idinstitucion_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institucion_idinstitucion_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institucion_idinstitucion_seq OWNED BY public.institucion.idinstitucion;


--
-- Name: demo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.demo ALTER COLUMN id SET DEFAULT nextval('public.demo_id_seq'::regclass);


--
-- Name: institucion idinstitucion; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion ALTER COLUMN idinstitucion SET DEFAULT nextval('public.institucion_idinstitucion_seq'::regclass);


--
-- Name: demo demo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.demo
    ADD CONSTRAINT demo_pkey PRIMARY KEY (id);


--
-- Name: institucion institucion_correo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_correo_key UNIQUE (correo);


--
-- Name: institucion institucion_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institucion
    ADD CONSTRAINT institucion_pkey PRIMARY KEY (idinstitucion);


--
-- PostgreSQL database dump complete
--


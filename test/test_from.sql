--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: cuebyte; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    amount integer,
    credit_id text
);


ALTER TABLE orders OWNER TO cuebyte;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: cuebyte
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO cuebyte;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuebyte
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cuebyte; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    password_digest text,
    mobile text,
    email text
);


ALTER TABLE users OWNER TO cuebyte;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cuebyte
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO cuebyte;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cuebyte
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cuebyte
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cuebyte
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: cuebyte
--

COPY orders (id, amount, credit_id) FROM stdin;
1	1111	11111111111
2	22222	3333333333333
3	4	5454545454544545
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuebyte
--

SELECT pg_catalog.setval('orders_id_seq', 3, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cuebyte
--

COPY users (id, password_digest, mobile, email) FROM stdin;
1	343434343434343434	18888888888	ha@zhihu.com
2	ha@zhihu.com	18787878787	ha@zhihu.com
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cuebyte
--

SELECT pg_catalog.setval('users_id_seq', 2, true);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: cuebyte; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: cuebyte; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: cuebyte
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM cuebyte;
GRANT ALL ON SCHEMA public TO cuebyte;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


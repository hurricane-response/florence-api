SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_stat_statements IS 'track execution statistics of all SQL statements executed';


--
-- Name: shelter_accepting_value; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.shelter_accepting_value AS ENUM (
    'yes',
    'no',
    'unknown'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: amazon_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.amazon_products (
    id bigint NOT NULL,
    need character varying,
    amazon_title character varying,
    asin character varying,
    detail_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    priority boolean DEFAULT false,
    disabled boolean DEFAULT false,
    category_specific character varying DEFAULT ''::character varying,
    category_general character varying DEFAULT ''::character varying,
    price_in_cents integer DEFAULT 0
);


--
-- Name: amazon_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.amazon_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.amazon_products_id_seq OWNED BY public.amazon_products.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: charitable_organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.charitable_organizations (
    id bigint NOT NULL,
    name character varying,
    services character varying,
    food_bank boolean,
    donation_website character varying,
    phone_number character varying,
    email character varying,
    physical_address character varying,
    city character varying,
    state character varying,
    zip character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true NOT NULL
);


--
-- Name: charitable_organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.charitable_organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charitable_organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.charitable_organizations_id_seq OWNED BY public.charitable_organizations.id;


--
-- Name: connect_markers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.connect_markers (
    id bigint NOT NULL,
    marker_type character varying NOT NULL,
    name character varying DEFAULT ''::character varying NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    phone character varying DEFAULT ''::character varying NOT NULL,
    resolved boolean DEFAULT false NOT NULL,
    latitude double precision DEFAULT 0.0 NOT NULL,
    longitude double precision DEFAULT 0.0 NOT NULL,
    address character varying DEFAULT ''::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    email character varying,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    device_uuid character varying DEFAULT ''::character varying NOT NULL,
    categories jsonb DEFAULT '{}'::jsonb NOT NULL
);


--
-- Name: connect_markers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.connect_markers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connect_markers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.connect_markers_id_seq OWNED BY public.connect_markers.id;


--
-- Name: distribution_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.distribution_points (
    id bigint NOT NULL,
    facility_name character varying,
    address character varying,
    city character varying,
    county character varying,
    state character varying,
    zip character varying,
    phone character varying,
    updated_by character varying,
    notes character varying,
    source character varying,
    longitude double precision,
    latitude double precision,
    google_place_id character varying,
    active boolean DEFAULT true,
    archived boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: distribution_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.distribution_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: distribution_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.distribution_points_id_seq OWNED BY public.distribution_points.id;


--
-- Name: drafts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.drafts (
    id bigint NOT NULL,
    info jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    record_type character varying,
    record_id bigint,
    accepted_by_id bigint,
    denied_by_id bigint,
    created_by_id integer
);


--
-- Name: drafts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.drafts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.drafts_id_seq OWNED BY public.drafts.id;


--
-- Name: ignored_amazon_product_needs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ignored_amazon_product_needs (
    id bigint NOT NULL,
    need character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ignored_amazon_product_needs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ignored_amazon_product_needs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ignored_amazon_product_needs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ignored_amazon_product_needs_id_seq OWNED BY public.ignored_amazon_product_needs.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.locations (
    id bigint NOT NULL,
    name character varying,
    address character varying,
    city character varying,
    state character varying,
    zip character varying,
    phone character varying,
    active boolean DEFAULT true NOT NULL,
    organization character varying,
    legacy_table_name character varying,
    legacy_data jsonb DEFAULT '{}'::jsonb NOT NULL,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.locations_id_seq OWNED BY public.locations.id;


--
-- Name: mucked_homes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.mucked_homes (
    id bigint NOT NULL,
    name character varying,
    description text,
    phone character varying,
    pin character varying,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mucked_homes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.mucked_homes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mucked_homes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.mucked_homes_id_seq OWNED BY public.mucked_homes.id;


--
-- Name: needs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.needs (
    id bigint NOT NULL,
    updated_by character varying,
    "timestamp" character varying,
    location_name character varying,
    location_address character varying,
    longitude double precision,
    latitude double precision,
    contact_for_this_location_name character varying,
    contact_for_this_location_phone_number character varying,
    are_volunteers_needed boolean,
    tell_us_about_the_volunteer_needs character varying,
    are_supplies_needed boolean,
    tell_us_about_the_supply_needs character varying,
    anything_else_you_would_like_to_tell_us character varying,
    source character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true
);


--
-- Name: needs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.needs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: needs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.needs_id_seq OWNED BY public.needs.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    key character varying DEFAULT ''::character varying NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shelters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.shelters (
    id bigint NOT NULL,
    county character varying,
    shelter character varying,
    address character varying,
    city character varying,
    pets character varying,
    phone character varying,
    accepting public.shelter_accepting_value,
    last_updated character varying,
    updated_by character varying,
    notes character varying,
    volunteer_needs character varying,
    longitude double precision,
    latitude double precision,
    supply_needs character varying,
    source character varying,
    address_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    active boolean DEFAULT true,
    private_notes text,
    distribution_center text,
    food_pantry text,
    state character varying,
    zip character varying,
    google_place_id character varying,
    special_needs boolean,
    private_email character varying,
    allow_pets boolean,
    private_sms character varying,
    private_volunteer_data_mgr character varying,
    unofficial boolean,
    accessibility text
);


--
-- Name: shelters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.shelters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shelters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.shelters_id_seq OWNED BY public.shelters.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    admin boolean,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.volunteers (
    id bigint NOT NULL,
    name character varying,
    description text,
    phone character varying,
    pin character varying,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: volunteers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.volunteers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.volunteers_id_seq OWNED BY public.volunteers.id;


--
-- Name: amazon_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_products ALTER COLUMN id SET DEFAULT nextval('public.amazon_products_id_seq'::regclass);


--
-- Name: charitable_organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charitable_organizations ALTER COLUMN id SET DEFAULT nextval('public.charitable_organizations_id_seq'::regclass);


--
-- Name: connect_markers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connect_markers ALTER COLUMN id SET DEFAULT nextval('public.connect_markers_id_seq'::regclass);


--
-- Name: distribution_points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.distribution_points ALTER COLUMN id SET DEFAULT nextval('public.distribution_points_id_seq'::regclass);


--
-- Name: drafts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drafts ALTER COLUMN id SET DEFAULT nextval('public.drafts_id_seq'::regclass);


--
-- Name: ignored_amazon_product_needs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignored_amazon_product_needs ALTER COLUMN id SET DEFAULT nextval('public.ignored_amazon_product_needs_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations ALTER COLUMN id SET DEFAULT nextval('public.locations_id_seq'::regclass);


--
-- Name: mucked_homes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mucked_homes ALTER COLUMN id SET DEFAULT nextval('public.mucked_homes_id_seq'::regclass);


--
-- Name: needs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs ALTER COLUMN id SET DEFAULT nextval('public.needs_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: shelters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shelters ALTER COLUMN id SET DEFAULT nextval('public.shelters_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteers ALTER COLUMN id SET DEFAULT nextval('public.volunteers_id_seq'::regclass);


--
-- Name: amazon_products amazon_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.amazon_products
    ADD CONSTRAINT amazon_products_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: charitable_organizations charitable_organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.charitable_organizations
    ADD CONSTRAINT charitable_organizations_pkey PRIMARY KEY (id);


--
-- Name: connect_markers connect_markers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.connect_markers
    ADD CONSTRAINT connect_markers_pkey PRIMARY KEY (id);


--
-- Name: distribution_points distribution_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.distribution_points
    ADD CONSTRAINT distribution_points_pkey PRIMARY KEY (id);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (id);


--
-- Name: ignored_amazon_product_needs ignored_amazon_product_needs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ignored_amazon_product_needs
    ADD CONSTRAINT ignored_amazon_product_needs_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mucked_homes mucked_homes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.mucked_homes
    ADD CONSTRAINT mucked_homes_pkey PRIMARY KEY (id);


--
-- Name: needs needs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.needs
    ADD CONSTRAINT needs_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shelters shelters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.shelters
    ADD CONSTRAINT shelters_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- Name: index_connect_markers_on_categories; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_categories ON public.connect_markers USING gin (categories);


--
-- Name: index_connect_markers_on_device_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_device_uuid ON public.connect_markers USING btree (device_uuid);


--
-- Name: index_connect_markers_on_latitude_and_longitude; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_latitude_and_longitude ON public.connect_markers USING btree (latitude, longitude);


--
-- Name: index_connect_markers_on_unresolved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_unresolved ON public.connect_markers USING btree (resolved) WHERE (resolved IS FALSE);


--
-- Name: index_drafts_on_accepted_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_accepted_by_id ON public.drafts USING btree (accepted_by_id);


--
-- Name: index_drafts_on_denied_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_denied_by_id ON public.drafts USING btree (denied_by_id);


--
-- Name: index_drafts_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_record_type_and_record_id ON public.drafts USING btree (record_type, record_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: drafts fk_rails_52f0256db1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT fk_rails_52f0256db1 FOREIGN KEY (accepted_by_id) REFERENCES public.users(id);


--
-- Name: drafts fk_rails_687f4d113b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.drafts
    ADD CONSTRAINT fk_rails_687f4d113b FOREIGN KEY (denied_by_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20170831193310'),
('20170831193314'),
('20170831220720'),
('20170901185804'),
('20170901194923'),
('20170901201514'),
('20170901224459'),
('20170902123713'),
('20170902140452'),
('20170902203116'),
('20170902213139'),
('20170902222739'),
('20170903113333'),
('20170903230413'),
('20170903231428'),
('20170904025322'),
('20170904165336'),
('20170905114546'),
('20170905201043'),
('20170906160409'),
('20170907032253'),
('20170907070934'),
('20170907152426'),
('20170908152859'),
('20170909061551'),
('20170909080422'),
('20170909082334'),
('20170909082743'),
('20170909174720'),
('20170909175503'),
('20170909193921'),
('20170910045633'),
('20180914132709'),
('20180915035427'),
('20180919043949');



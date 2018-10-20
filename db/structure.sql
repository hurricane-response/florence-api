SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
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


SET search_path = public, pg_catalog;

--
-- Name: shelter_accepting_value; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE shelter_accepting_value AS ENUM (
    'yes',
    'no',
    'unknown'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: amazon_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE amazon_products (
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

CREATE SEQUENCE amazon_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: amazon_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE amazon_products_id_seq OWNED BY amazon_products.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: charitable_organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE charitable_organizations (
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

CREATE SEQUENCE charitable_organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: charitable_organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE charitable_organizations_id_seq OWNED BY charitable_organizations.id;


--
-- Name: connect_markers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE connect_markers (
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

CREATE SEQUENCE connect_markers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: connect_markers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE connect_markers_id_seq OWNED BY connect_markers.id;


--
-- Name: distribution_points; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE distribution_points (
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
    longitude character varying,
    latitude character varying,
    google_place_id character varying,
    active boolean,
    archived boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: distribution_points_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE distribution_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: distribution_points_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE distribution_points_id_seq OWNED BY distribution_points.id;


--
-- Name: drafts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE drafts (
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

CREATE SEQUENCE drafts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: drafts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE drafts_id_seq OWNED BY drafts.id;


--
-- Name: ignored_amazon_product_needs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ignored_amazon_product_needs (
    id bigint NOT NULL,
    need character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ignored_amazon_product_needs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ignored_amazon_product_needs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ignored_amazon_product_needs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ignored_amazon_product_needs_id_seq OWNED BY ignored_amazon_product_needs.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE locations (
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

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: mucked_homes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mucked_homes (
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

CREATE SEQUENCE mucked_homes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mucked_homes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mucked_homes_id_seq OWNED BY mucked_homes.id;


--
-- Name: needs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE needs (
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

CREATE SEQUENCE needs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: needs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE needs_id_seq OWNED BY needs.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE pages (
    id bigint NOT NULL,
    key character varying DEFAULT ''::character varying NOT NULL,
    content text DEFAULT ''::text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: shelters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE shelters (
    id bigint NOT NULL,
    county character varying,
    shelter character varying,
    address character varying,
    city character varying,
    pets character varying,
    phone character varying,
    accepting shelter_accepting_value,
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

CREATE SEQUENCE shelters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: shelters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE shelters_id_seq OWNED BY shelters.id;


--
-- Name: trashes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE trashes (
    id bigint NOT NULL,
    trashable_type character varying NOT NULL,
    trashable_id bigint NOT NULL,
    data jsonb,
    user_id bigint,
    reason text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: trashes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE trashes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: trashes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE trashes_id_seq OWNED BY trashes.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
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

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: volunteers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE volunteers (
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

CREATE SEQUENCE volunteers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: volunteers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE volunteers_id_seq OWNED BY volunteers.id;


--
-- Name: amazon_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY amazon_products ALTER COLUMN id SET DEFAULT nextval('amazon_products_id_seq'::regclass);


--
-- Name: charitable_organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY charitable_organizations ALTER COLUMN id SET DEFAULT nextval('charitable_organizations_id_seq'::regclass);


--
-- Name: connect_markers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY connect_markers ALTER COLUMN id SET DEFAULT nextval('connect_markers_id_seq'::regclass);


--
-- Name: distribution_points id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY distribution_points ALTER COLUMN id SET DEFAULT nextval('distribution_points_id_seq'::regclass);


--
-- Name: drafts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY drafts ALTER COLUMN id SET DEFAULT nextval('drafts_id_seq'::regclass);


--
-- Name: ignored_amazon_product_needs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ignored_amazon_product_needs ALTER COLUMN id SET DEFAULT nextval('ignored_amazon_product_needs_id_seq'::regclass);


--
-- Name: locations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: mucked_homes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mucked_homes ALTER COLUMN id SET DEFAULT nextval('mucked_homes_id_seq'::regclass);


--
-- Name: needs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY needs ALTER COLUMN id SET DEFAULT nextval('needs_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: shelters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY shelters ALTER COLUMN id SET DEFAULT nextval('shelters_id_seq'::regclass);


--
-- Name: trashes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY trashes ALTER COLUMN id SET DEFAULT nextval('trashes_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: volunteers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY volunteers ALTER COLUMN id SET DEFAULT nextval('volunteers_id_seq'::regclass);


--
-- Name: amazon_products amazon_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY amazon_products
    ADD CONSTRAINT amazon_products_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: charitable_organizations charitable_organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY charitable_organizations
    ADD CONSTRAINT charitable_organizations_pkey PRIMARY KEY (id);


--
-- Name: connect_markers connect_markers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY connect_markers
    ADD CONSTRAINT connect_markers_pkey PRIMARY KEY (id);


--
-- Name: distribution_points distribution_points_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY distribution_points
    ADD CONSTRAINT distribution_points_pkey PRIMARY KEY (id);


--
-- Name: drafts drafts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drafts
    ADD CONSTRAINT drafts_pkey PRIMARY KEY (id);


--
-- Name: ignored_amazon_product_needs ignored_amazon_product_needs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ignored_amazon_product_needs
    ADD CONSTRAINT ignored_amazon_product_needs_pkey PRIMARY KEY (id);


--
-- Name: locations locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: mucked_homes mucked_homes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mucked_homes
    ADD CONSTRAINT mucked_homes_pkey PRIMARY KEY (id);


--
-- Name: needs needs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY needs
    ADD CONSTRAINT needs_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: shelters shelters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY shelters
    ADD CONSTRAINT shelters_pkey PRIMARY KEY (id);


--
-- Name: trashes trashes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trashes
    ADD CONSTRAINT trashes_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: volunteers volunteers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY volunteers
    ADD CONSTRAINT volunteers_pkey PRIMARY KEY (id);


--
-- Name: index_connect_markers_on_categories; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_categories ON connect_markers USING gin (categories);


--
-- Name: index_connect_markers_on_device_uuid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_device_uuid ON connect_markers USING btree (device_uuid);


--
-- Name: index_connect_markers_on_latitude_and_longitude; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_latitude_and_longitude ON connect_markers USING btree (latitude, longitude);


--
-- Name: index_connect_markers_on_unresolved; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_connect_markers_on_unresolved ON connect_markers USING btree (resolved) WHERE (resolved IS FALSE);


--
-- Name: index_drafts_on_accepted_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_accepted_by_id ON drafts USING btree (accepted_by_id);


--
-- Name: index_drafts_on_denied_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_denied_by_id ON drafts USING btree (denied_by_id);


--
-- Name: index_drafts_on_record_type_and_record_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_drafts_on_record_type_and_record_id ON drafts USING btree (record_type, record_id);


--
-- Name: index_trashes_on_trashable_type_and_trashable_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trashes_on_trashable_type_and_trashable_id ON trashes USING btree (trashable_type, trashable_id);


--
-- Name: index_trashes_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_trashes_on_user_id ON trashes USING btree (user_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: drafts fk_rails_52f0256db1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drafts
    ADD CONSTRAINT fk_rails_52f0256db1 FOREIGN KEY (accepted_by_id) REFERENCES users(id);


--
-- Name: drafts fk_rails_687f4d113b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY drafts
    ADD CONSTRAINT fk_rails_687f4d113b FOREIGN KEY (denied_by_id) REFERENCES users(id);


--
-- Name: trashes fk_rails_7d97d072f5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY trashes
    ADD CONSTRAINT fk_rails_7d97d072f5 FOREIGN KEY (user_id) REFERENCES users(id);


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
('20180919043949'),
('20181013222410');



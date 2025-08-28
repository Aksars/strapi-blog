--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.10
-- Dumped by pg_dump version 9.6.10

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: _admin_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._admin_permissions (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    action character varying(55) DEFAULT NULL::character varying,
    action_parameters character varying(2) DEFAULT NULL::character varying,
    subject character varying(30) DEFAULT NULL::character varying,
    properties character varying(123) DEFAULT NULL::character varying,
    conditions character varying(21) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._admin_permissions OWNER TO strapi;

--
-- Name: _admin_permissions_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._admin_permissions_role_lnk (
    id smallint,
    permission_id smallint,
    role_id smallint,
    permission_ord numeric(3,1) DEFAULT NULL::numeric
);


ALTER TABLE public._admin_permissions_role_lnk OWNER TO strapi;

--
-- Name: _admin_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._admin_roles (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(11) DEFAULT NULL::character varying,
    code character varying(18) DEFAULT NULL::character varying,
    description character varying(71) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._admin_roles OWNER TO strapi;

--
-- Name: _admin_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._admin_users (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    firstname character varying(4) DEFAULT NULL::character varying,
    lastname character varying(1) DEFAULT NULL::character varying,
    username character varying(1) DEFAULT NULL::character varying,
    email character varying(19) DEFAULT NULL::character varying,
    password character varying(60) DEFAULT NULL::character varying,
    reset_password_token character varying(1) DEFAULT NULL::character varying,
    registration_token character varying(1) DEFAULT NULL::character varying,
    is_active smallint,
    blocked smallint,
    prefered_language character varying(1) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._admin_users OWNER TO strapi;

--
-- Name: _admin_users_roles_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._admin_users_roles_lnk (
    id smallint,
    user_id smallint,
    role_id smallint,
    role_ord numeric(2,1) DEFAULT NULL::numeric,
    user_ord numeric(2,1) DEFAULT NULL::numeric
);


ALTER TABLE public._admin_users_roles_lnk OWNER TO strapi;

--
-- Name: _categories; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._categories (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(7) DEFAULT NULL::character varying,
    description character varying(1) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id smallint,
    updated_by_id smallint,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._categories OWNER TO strapi;

--
-- Name: _comments; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._comments (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    autor character varying(1) DEFAULT NULL::character varying,
    content character varying(1) DEFAULT NULL::character varying,
    publish_date character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._comments OWNER TO strapi;

--
-- Name: _comments_post_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._comments_post_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    comment_id character varying(1) DEFAULT NULL::character varying,
    post_id character varying(1) DEFAULT NULL::character varying,
    comment_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._comments_post_lnk OWNER TO strapi;

--
-- Name: _files; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._files (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(26) DEFAULT NULL::character varying,
    alternative_text character varying(1) DEFAULT NULL::character varying,
    caption character varying(1) DEFAULT NULL::character varying,
    width character varying(4) DEFAULT NULL::character varying,
    height character varying(4) DEFAULT NULL::character varying,
    formats character varying(951) DEFAULT NULL::character varying,
    hash character varying(35) DEFAULT NULL::character varying,
    ext character varying(5) DEFAULT NULL::character varying,
    mime character varying(10) DEFAULT NULL::character varying,
    size numeric(6,2) DEFAULT NULL::numeric,
    url character varying(48) DEFAULT NULL::character varying,
    preview_url character varying(1) DEFAULT NULL::character varying,
    provider character varying(5) DEFAULT NULL::character varying,
    provider_metadata character varying(36) DEFAULT NULL::character varying,
    folder_path character varying(1) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id smallint,
    updated_by_id smallint,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._files OWNER TO strapi;

--
-- Name: _files_folder_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._files_folder_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    file_id character varying(1) DEFAULT NULL::character varying,
    folder_id character varying(1) DEFAULT NULL::character varying,
    file_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._files_folder_lnk OWNER TO strapi;

--
-- Name: _files_related_mph; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._files_related_mph (
    id smallint,
    file_id smallint,
    related_id smallint,
    related_type character varying(14) DEFAULT NULL::character varying,
    field character varying(5) DEFAULT NULL::character varying,
    "order" numeric(2,1) DEFAULT NULL::numeric
);


ALTER TABLE public._files_related_mph OWNER TO strapi;

--
-- Name: _i18n_locale; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._i18n_locale (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(12) DEFAULT NULL::character varying,
    code character varying(2) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._i18n_locale OWNER TO strapi;

--
-- Name: _posts; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._posts (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    title character varying(34) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id smallint,
    updated_by_id smallint,
    locale character varying(1) DEFAULT NULL::character varying,
    likes character varying(1) DEFAULT NULL::character varying,
    content character varying(1327) DEFAULT NULL::character varying,
    publish_date character varying(10) DEFAULT NULL::character varying,
    slug character varying(8) DEFAULT NULL::character varying,
    test_field character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._posts OWNER TO strapi;

--
-- Name: _posts_category_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._posts_category_lnk (
    id smallint,
    post_id smallint,
    category_id smallint,
    post_ord numeric(2,1) DEFAULT NULL::numeric
);


ALTER TABLE public._posts_category_lnk OWNER TO strapi;

--
-- Name: _sqlite_sequence; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._sqlite_sequence (
    name character varying(46) DEFAULT NULL::character varying,
    seq smallint
);


ALTER TABLE public._sqlite_sequence OWNER TO strapi;

--
-- Name: _strapi_api_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_api_token_permissions (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    action character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_api_token_permissions OWNER TO strapi;

--
-- Name: _strapi_api_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_api_token_permissions_token_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    api_token_permission_id character varying(1) DEFAULT NULL::character varying,
    api_token_id character varying(1) DEFAULT NULL::character varying,
    api_token_permission_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_api_token_permissions_token_lnk OWNER TO strapi;

--
-- Name: _strapi_api_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_api_tokens (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(11) DEFAULT NULL::character varying,
    description character varying(91) DEFAULT NULL::character varying,
    type character varying(11) DEFAULT NULL::character varying,
    access_key character varying(128) DEFAULT NULL::character varying,
    encrypted_key character varying(581) DEFAULT NULL::character varying,
    last_used_at character varying(1) DEFAULT NULL::character varying,
    expires_at character varying(1) DEFAULT NULL::character varying,
    lifespan character varying(1) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_api_tokens OWNER TO strapi;

--
-- Name: _strapi_core_store_settings; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_core_store_settings (
    id smallint,
    key character varying(91) DEFAULT NULL::character varying,
    value character varying(52602) DEFAULT NULL::character varying,
    type character varying(6) DEFAULT NULL::character varying,
    environment character varying(1) DEFAULT NULL::character varying,
    tag character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_core_store_settings OWNER TO strapi;

--
-- Name: _strapi_database_schema; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_database_schema (
    id smallint,
    schema character varying(60701) DEFAULT NULL::character varying,
    "time" character varying(10) DEFAULT NULL::character varying,
    hash character varying(64) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_database_schema OWNER TO strapi;

--
-- Name: _strapi_history_versions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_history_versions (
    id character varying(1) DEFAULT NULL::character varying,
    content_type character varying(1) DEFAULT NULL::character varying,
    related_document_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying,
    status character varying(1) DEFAULT NULL::character varying,
    data character varying(1) DEFAULT NULL::character varying,
    schema character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_history_versions OWNER TO strapi;

--
-- Name: _strapi_migrations; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_migrations (
    id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    "time" character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_migrations OWNER TO strapi;

--
-- Name: _strapi_migrations_internal; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_migrations_internal (
    id smallint,
    name character varying(47) DEFAULT NULL::character varying,
    "time" character varying(10) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_migrations_internal OWNER TO strapi;

--
-- Name: _strapi_release_actions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_release_actions (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    type character varying(1) DEFAULT NULL::character varying,
    content_type character varying(1) DEFAULT NULL::character varying,
    entry_document_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying,
    is_entry_valid character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_release_actions OWNER TO strapi;

--
-- Name: _strapi_release_actions_release_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_release_actions_release_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    release_action_id character varying(1) DEFAULT NULL::character varying,
    release_id character varying(1) DEFAULT NULL::character varying,
    release_action_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_release_actions_release_lnk OWNER TO strapi;

--
-- Name: _strapi_releases; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_releases (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    released_at character varying(1) DEFAULT NULL::character varying,
    scheduled_at character varying(1) DEFAULT NULL::character varying,
    timezone character varying(1) DEFAULT NULL::character varying,
    status character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_releases OWNER TO strapi;

--
-- Name: _strapi_transfer_token_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_transfer_token_permissions (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    action character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_transfer_token_permissions OWNER TO strapi;

--
-- Name: _strapi_transfer_token_permissions_token_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_transfer_token_permissions_token_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    transfer_token_permission_id character varying(1) DEFAULT NULL::character varying,
    transfer_token_id character varying(1) DEFAULT NULL::character varying,
    transfer_token_permission_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_transfer_token_permissions_token_lnk OWNER TO strapi;

--
-- Name: _strapi_transfer_tokens; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_transfer_tokens (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    description character varying(1) DEFAULT NULL::character varying,
    access_key character varying(1) DEFAULT NULL::character varying,
    last_used_at character varying(1) DEFAULT NULL::character varying,
    expires_at character varying(1) DEFAULT NULL::character varying,
    lifespan character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_transfer_tokens OWNER TO strapi;

--
-- Name: _strapi_webhooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_webhooks (
    id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    url character varying(1) DEFAULT NULL::character varying,
    headers character varying(1) DEFAULT NULL::character varying,
    events character varying(1) DEFAULT NULL::character varying,
    enabled character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_webhooks OWNER TO strapi;

--
-- Name: _strapi_workflows; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_workflows (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    content_types character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_workflows OWNER TO strapi;

--
-- Name: _strapi_workflows_stage_required_to_publish_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_workflows_stage_required_to_publish_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    workflow_id character varying(1) DEFAULT NULL::character varying,
    workflow_stage_id character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_workflows_stage_required_to_publish_lnk OWNER TO strapi;

--
-- Name: _strapi_workflows_stages; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_workflows_stages (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    color character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_workflows_stages OWNER TO strapi;

--
-- Name: _strapi_workflows_stages_permissions_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_workflows_stages_permissions_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    workflow_stage_id character varying(1) DEFAULT NULL::character varying,
    permission_id character varying(1) DEFAULT NULL::character varying,
    permission_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_workflows_stages_permissions_lnk OWNER TO strapi;

--
-- Name: _strapi_workflows_stages_workflow_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._strapi_workflows_stages_workflow_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    workflow_stage_id character varying(1) DEFAULT NULL::character varying,
    workflow_id character varying(1) DEFAULT NULL::character varying,
    workflow_stage_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._strapi_workflows_stages_workflow_lnk OWNER TO strapi;

--
-- Name: _up_permissions; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._up_permissions (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    action character varying(52) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._up_permissions OWNER TO strapi;

--
-- Name: _up_permissions_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._up_permissions_role_lnk (
    id smallint,
    permission_id smallint,
    role_id smallint,
    permission_ord numeric(3,1) DEFAULT NULL::numeric
);


ALTER TABLE public._up_permissions_role_lnk OWNER TO strapi;

--
-- Name: _up_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._up_roles (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    name character varying(13) DEFAULT NULL::character varying,
    description character varying(43) DEFAULT NULL::character varying,
    type character varying(13) DEFAULT NULL::character varying,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._up_roles OWNER TO strapi;

--
-- Name: _up_users; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._up_users (
    id smallint,
    document_id character varying(24) DEFAULT NULL::character varying,
    username character varying(6) DEFAULT NULL::character varying,
    email character varying(30) DEFAULT NULL::character varying,
    provider character varying(5) DEFAULT NULL::character varying,
    password character varying(60) DEFAULT NULL::character varying,
    reset_password_token character varying(1) DEFAULT NULL::character varying,
    confirmation_token character varying(1) DEFAULT NULL::character varying,
    confirmed smallint,
    blocked smallint,
    created_at character varying(10) DEFAULT NULL::character varying,
    updated_at character varying(10) DEFAULT NULL::character varying,
    published_at character varying(10) DEFAULT NULL::character varying,
    created_by_id smallint,
    updated_by_id smallint,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._up_users OWNER TO strapi;

--
-- Name: _up_users_role_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._up_users_role_lnk (
    id smallint,
    user_id smallint,
    role_id smallint,
    user_ord numeric(2,1) DEFAULT NULL::numeric
);


ALTER TABLE public._up_users_role_lnk OWNER TO strapi;

--
-- Name: _upload_folders; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._upload_folders (
    id character varying(1) DEFAULT NULL::character varying,
    document_id character varying(1) DEFAULT NULL::character varying,
    name character varying(1) DEFAULT NULL::character varying,
    path_id character varying(1) DEFAULT NULL::character varying,
    path character varying(1) DEFAULT NULL::character varying,
    created_at character varying(1) DEFAULT NULL::character varying,
    updated_at character varying(1) DEFAULT NULL::character varying,
    published_at character varying(1) DEFAULT NULL::character varying,
    created_by_id character varying(1) DEFAULT NULL::character varying,
    updated_by_id character varying(1) DEFAULT NULL::character varying,
    locale character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._upload_folders OWNER TO strapi;

--
-- Name: _upload_folders_parent_lnk; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public._upload_folders_parent_lnk (
    id character varying(1) DEFAULT NULL::character varying,
    folder_id character varying(1) DEFAULT NULL::character varying,
    inv_folder_id character varying(1) DEFAULT NULL::character varying,
    folder_ord character varying(1) DEFAULT NULL::character varying
);


ALTER TABLE public._upload_folders_parent_lnk OWNER TO strapi;

--
-- Data for Name: _admin_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._admin_permissions (id, document_id, action, action_parameters, subject, properties, conditions, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	xyi8crk5zgmmf254j65bn14t	plugin::upload.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
2	f516vin1ym73u487d5qireon	plugin::upload.configure-view	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
3	kzen3yqtldgfz7xdc8fjd87g	plugin::upload.assets.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
4	dfbg6lh7onorbw6z3ow91cnt	plugin::upload.assets.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
5	p8oca4nr5pn93kziakdniimf	plugin::upload.assets.download	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
6	bdrbajcqm97jz05r6se1f6l0	plugin::upload.assets.copy-link	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
7	ehcbupvsp8r11uzz9uodbv51	plugin::upload.read	{}		{}	["admin::is-creator"]	2025-07-07	2025-07-07	2025-07-07			
8	n5imc8lo93ei2yt4339i8otg	plugin::upload.configure-view	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
9	saj3lbhn6nyb1sooqcruhve3	plugin::upload.assets.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
10	nxhyg0wpv2dgqfjy1kme30z7	plugin::upload.assets.update	{}		{}	["admin::is-creator"]	2025-07-07	2025-07-07	2025-07-07			
11	w85b1074mgre5vp18e6sofvo	plugin::upload.assets.download	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
12	gb8s66fxtjdwqkhi8ax7zej0	plugin::upload.assets.copy-link	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
13	og59goge4llyw7t5byetchhj	plugin::content-manager.explorer.create	{}	plugin::users-permissions.user	{"fields":["username","email","provider","password","resetPasswordToken","confirmationToken","confirmed","blocked","role"]}	[]	2025-07-07	2025-07-07	2025-07-07			
14	g6h0j1bfxpqycghs6irfpy6y	plugin::content-manager.explorer.read	{}	plugin::users-permissions.user	{"fields":["username","email","provider","password","resetPasswordToken","confirmationToken","confirmed","blocked","role"]}	[]	2025-07-07	2025-07-07	2025-07-07			
15	zcawhxfhcdy4v5pdh927o0g6	plugin::content-manager.explorer.update	{}	plugin::users-permissions.user	{"fields":["username","email","provider","password","resetPasswordToken","confirmationToken","confirmed","blocked","role"]}	[]	2025-07-07	2025-07-07	2025-07-07			
16	g40du3503s0s7rvmv42qokql	plugin::content-manager.explorer.delete	{}	plugin::users-permissions.user	{}	[]	2025-07-07	2025-07-07	2025-07-07			
17	e3yirk5cqs7qgt29edxcvqxc	plugin::content-manager.explorer.publish	{}	plugin::users-permissions.user	{}	[]	2025-07-07	2025-07-07	2025-07-07			
18	thmgyml9c0mgdrol9o9aplil	plugin::content-manager.single-types.configure-view	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
19	sbg3x43hynicfbra8qagwewb	plugin::content-manager.collection-types.configure-view	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
20	udvx10ifudqkyjprf2a041rc	plugin::content-manager.components.configure-layout	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
21	xdl8wl2rwieef6ts22te4bhr	plugin::content-type-builder.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
22	spwyciluix1v8112lbrsf9l4	plugin::email.settings.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
23	oo33copr5o3w3tk2lggldfpk	plugin::upload.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
24	e01cmx9tgcsy7sjxql80pt2x	plugin::upload.assets.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
25	bifs1l4rp907yd4le2yu11go	plugin::upload.assets.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
26	a06k2k7yst2yw9cvjkk7vun3	plugin::upload.assets.download	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
27	y4l5x1tezgb5e1k4qyblaais	plugin::upload.assets.copy-link	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
28	uf0tq7a82h2ihokxc4oyq29b	plugin::upload.configure-view	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
29	buv347vldxjhexmed7z6upym	plugin::upload.settings.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
30	etkgpwywjja3p0oi4961tdfh	plugin::i18n.locale.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
31	kewmt60254bxl137hd8lksm0	plugin::i18n.locale.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
32	g6tliui8roivm3fm4ox97c8p	plugin::i18n.locale.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
33	d3pvdmr3f1fti5icygg8gd10	plugin::i18n.locale.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
34	e3xml8jlarp84py225w1gcve	plugin::users-permissions.roles.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
35	ffq1aw0pj2yboty7wxisdfst	plugin::users-permissions.roles.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
36	pei0mvf4lyc5wym1atu4dj77	plugin::users-permissions.roles.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
37	oo5gh3he2g0gkdkzm4aib40m	plugin::users-permissions.roles.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
38	s2v84wzkebwggnsss5v3d4ig	plugin::users-permissions.providers.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
39	s5pl2hnmbfihvzi741881y7f	plugin::users-permissions.providers.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
40	yecvdkj8zkyiytajc1vhz6ba	plugin::users-permissions.email-templates.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
41	gj7ft6n3emu0p1viwfdvvh9y	plugin::users-permissions.email-templates.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
42	h6wwul4k9dif3h417j0yq76z	plugin::users-permissions.advanced-settings.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
43	nx8m6fvcgumqjbobaddgco9u	plugin::users-permissions.advanced-settings.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
44	q953ol62m1fw17sykoavm3lz	admin::marketplace.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
45	qervq2jx0gvbtga5dki7wcst	admin::webhooks.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
46	gq2q77mg4w9m8obhzyybd0bg	admin::webhooks.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
47	x4vp0jsf956c6jjhzfidrdan	admin::webhooks.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
48	fqvvk0z10r39m7xpy6f1q9vd	admin::webhooks.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
49	ix24xxcibikbzsdetfrfrf0k	admin::users.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
50	ta8esso2u6oixw838kt588y1	admin::users.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
51	f99c14zqows6ygqf9xb739p7	admin::users.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
52	ra21kkiab75psjc7ju085ib6	admin::users.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
53	bvnp2k4eakbu4kbs89549ofs	admin::roles.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
54	pjufj71kgzmcgek3nwf5qla5	admin::roles.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
55	nevgznt2hkdw55ilzig57gur	admin::roles.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
56	f53ynhudjh390izxas4iv1y3	admin::roles.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
57	zipp7ztzo41wg90x6d8jec1r	admin::api-tokens.access	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
58	y9kinigka51t7ht4ac3bfp1g	admin::api-tokens.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
59	kx84xbom390j8cvuj4u7qe7d	admin::api-tokens.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
60	mk23qbj5mfkofu6cyidriay1	admin::api-tokens.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
61	rzo35gckzpm6eezrdl3vewi1	admin::api-tokens.regenerate	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
62	ydkpfz9sustlz5f7ii8sde1j	admin::api-tokens.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
63	xxc3tmnknf9z5k0tly3mbsxn	admin::project-settings.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
64	wllqzmwsmy8mqopgumu450w1	admin::project-settings.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
65	uuquicv9h2prppf3lm4enn48	admin::transfer.tokens.access	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
66	aa13uo9q0sjxq1ll0lyp4ftr	admin::transfer.tokens.create	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
67	jdvk75o19w3jzksuhaep2lol	admin::transfer.tokens.read	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
68	jcj5kafqdi5c9j9tsovvnlej	admin::transfer.tokens.update	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
69	jhxk237p0zxgaefjzj0ds3w6	admin::transfer.tokens.regenerate	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
70	fdh4cmmbyhi53jrkhhxuwbwx	admin::transfer.tokens.delete	{}		{}	[]	2025-07-07	2025-07-07	2025-07-07			
74	a9bnf5y9sbkku9egrk7l87ed	plugin::content-manager.explorer.delete	{}	api::post.post	{}	[]	2025-07-09	2025-07-09	2025-07-09			
75	xyyn1ps8h7a42qtf5ydvj7kw	plugin::content-manager.explorer.publish	{}	api::post.post	{}	[]	2025-07-09	2025-07-09	2025-07-09			
88	gi6qtcu5mc52918l9ludqsiv	plugin::content-manager.explorer.delete	{}	api::category.category	{}	[]	2025-07-09	2025-07-09	2025-07-09			
89	lgggmglzzq4iw4wdo49d937h	plugin::content-manager.explorer.publish	{}	api::category.category	{}	[]	2025-07-09	2025-07-09	2025-07-09			
93	gzmt5te204hle5nmo0uroctf	plugin::content-manager.explorer.delete	{}	api::comment.comment	{}	[]	2025-07-09	2025-07-09	2025-07-09			
94	bxvp21t98g8gegwjv5qk2fkt	plugin::content-manager.explorer.publish	{}	api::comment.comment	{}	[]	2025-07-09	2025-07-09	2025-07-09			
95	oa0033o10hszvlrr9o2lx4o1	plugin::content-manager.explorer.create	{}	api::category.category	{"fields":["name","description","posts"]}	[]	2025-07-09	2025-07-09	2025-07-09			
96	jiev6fwqeoznt9jzgura86yx	plugin::content-manager.explorer.create	{}	api::comment.comment	{"fields":["autor","content","publish_date","post"]}	[]	2025-07-09	2025-07-09	2025-07-09			
98	iv4fewfx7dpohxzx57ir5fia	plugin::content-manager.explorer.read	{}	api::category.category	{"fields":["name","description","posts"]}	[]	2025-07-09	2025-07-09	2025-07-09			
99	xyx8rbizk6mmfk9dqa6cvvpn	plugin::content-manager.explorer.read	{}	api::comment.comment	{"fields":["autor","content","publish_date","post"]}	[]	2025-07-09	2025-07-09	2025-07-09			
101	oc898qx9ayaqwxb2f0nox9q2	plugin::content-manager.explorer.update	{}	api::category.category	{"fields":["name","description","posts"]}	[]	2025-07-09	2025-07-09	2025-07-09			
102	vo3cr00ickevix54g2svcsjt	plugin::content-manager.explorer.update	{}	api::comment.comment	{"fields":["autor","content","publish_date","post"]}	[]	2025-07-09	2025-07-09	2025-07-09			
104	fzryd5scrllcrn6zpqfviq4x	plugin::content-manager.explorer.create	{}	api::post.post	{"fields":["title","image","content","publish_date","likes","slug","category","comments","test_field"]}	[]	2025-08-22	2025-08-22	2025-08-22			
105	kjw0ze6wt1fnv20qcn3hj4ob	plugin::content-manager.explorer.read	{}	api::post.post	{"fields":["title","image","content","publish_date","likes","slug","category","comments","test_field"]}	[]	2025-08-22	2025-08-22	2025-08-22			
106	bwyvk42i53y80r6xl4t4bgrv	plugin::content-manager.explorer.update	{}	api::post.post	{"fields":["title","image","content","publish_date","likes","slug","category","comments","test_field"]}	[]	2025-08-22	2025-08-22	2025-08-22			
\.


--
-- Data for Name: _admin_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._admin_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	2	1.0
2	2	2	2.0
3	3	2	3.0
4	4	2	4.0
5	5	2	5.0
6	6	2	6.0
7	7	3	1.0
8	8	3	2.0
9	9	3	3.0
10	10	3	4.0
11	11	3	5.0
12	12	3	6.0
13	13	1	1.0
14	14	1	2.0
15	15	1	3.0
16	16	1	4.0
17	17	1	5.0
18	18	1	6.0
19	19	1	7.0
20	20	1	8.0
21	21	1	9.0
22	22	1	10.0
23	23	1	11.0
24	24	1	12.0
25	25	1	13.0
26	26	1	14.0
27	27	1	15.0
28	28	1	16.0
29	29	1	17.0
30	30	1	18.0
31	31	1	19.0
32	32	1	20.0
33	33	1	21.0
34	34	1	22.0
35	35	1	23.0
36	36	1	24.0
37	37	1	25.0
38	38	1	26.0
39	39	1	27.0
40	40	1	28.0
41	41	1	29.0
42	42	1	30.0
43	43	1	31.0
44	44	1	32.0
45	45	1	33.0
46	46	1	34.0
47	47	1	35.0
48	48	1	36.0
49	49	1	37.0
50	50	1	38.0
51	51	1	39.0
52	52	1	40.0
53	53	1	41.0
54	54	1	42.0
55	55	1	43.0
56	56	1	44.0
57	57	1	45.0
58	58	1	46.0
59	59	1	47.0
60	60	1	48.0
61	61	1	49.0
62	62	1	50.0
63	63	1	51.0
64	64	1	52.0
65	65	1	53.0
66	66	1	54.0
67	67	1	55.0
68	68	1	56.0
69	69	1	57.0
70	70	1	58.0
74	74	1	62.0
75	75	1	63.0
88	88	1	70.0
89	89	1	71.0
93	93	1	75.0
94	94	1	76.0
95	95	1	77.0
96	96	1	78.0
98	98	1	80.0
99	99	1	81.0
101	101	1	83.0
102	102	1	84.0
104	104	1	85.0
105	105	1	86.0
106	106	1	87.0
\.


--
-- Data for Name: _admin_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._admin_roles (id, document_id, name, code, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	ikloow32c9ncc5j0s1vdsfa5	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2025-07-07	2025-07-07	2025-07-07			
2	n5edw9sc12jfj0b78cmycfd7	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2025-07-07	2025-07-07	2025-07-07			
3	kh65jkylg0wooycky4h8vkns	Author	strapi-author	Authors can manage the content they have created.	2025-07-07	2025-07-07	2025-07-07			
\.


--
-- Data for Name: _admin_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._admin_users (id, document_id, firstname, lastname, username, email, password, reset_password_token, registration_token, is_active, blocked, prefered_language, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	a56c7eo0bjmg0eq0cdhbcnyx	Dima			artas2014@gmail.com	$2a$10$DsR5RpsCQbymxgjCaa.Zw.DL/gXPLkBuQ7c0dbHtm1Q2d1gL9.6mm			1	0		2025-07-07	2025-07-07	2025-07-07			
\.


--
-- Data for Name: _admin_users_roles_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._admin_users_roles_lnk (id, user_id, role_id, role_ord, user_ord) FROM stdin;
1	1	1	1.0	1.0
\.


--
-- Data for Name: _categories; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.categories (id, document_id, name, description, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	g541ze3uzy7mjp81gqtklp71	pets		2025-07-09	2025-07-09		1	1	
2	g541ze3uzy7mjp81gqtklp71	pets		2025-07-09	2025-07-09	2025-07-09	1	1	
3	j9t4dvsczhbn3i6ua2da0040	recepie		2025-07-09	2025-07-09		1	1	
4	j9t4dvsczhbn3i6ua2da0040	recepie		2025-07-09	2025-07-09	2025-07-09	1	1	
\.


--
-- Data for Name: _comments; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._comments (id, document_id, autor, content, publish_date, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _comments_post_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._comments_post_lnk (id, comment_id, post_id, comment_ord) FROM stdin;
\.


--
-- Data for Name: _files; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._files (id, document_id, name, alternative_text, caption, width, height, formats, hash, ext, mime, size, url, preview_url, provider, provider_metadata, folder_path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	it66cy7yn4o4h10diyq85bri	Новый точечный рисунок.bmp						Novyj_tochechnyj_risunok_a2760bc5a0	.bmp	image/bmp	3034.41	/uploads/Novyj_tochechnyj_risunok_a2760bc5a0.bmp		local	unknown_value_please_contact_support	/	2025-07-07	2025-07-07	2025-07-07	1	1	
2	xjof2sahq27og7priy9yvkbj	Безымянный.png			1280	1022	{"thumbnail":{"name":"thumbnail_Безымянный.png","hash":"thumbnail_Bezymyannyj_1eb397dbd0","ext":".png","mime":"image/png","path":null,"width":195,"height":156,"size":80.06,"sizeInBytes":80061,"url":"/uploads/thumbnail_Bezymyannyj_1eb397dbd0.png"},"small":{"name":"small_Безымянный.png","hash":"small_Bezymyannyj_1eb397dbd0","ext":".png","mime":"image/png","path":null,"width":500,"height":399,"size":487.87,"sizeInBytes":487872,"url":"/uploads/small_Bezymyannyj_1eb397dbd0.png"},"medium":{"name":"medium_Безымянный.png","hash":"medium_Bezymyannyj_1eb397dbd0","ext":".png","mime":"image/png","path":null,"width":750,"height":599,"size":1075.44,"sizeInBytes":1075438,"url":"/uploads/medium_Bezymyannyj_1eb397dbd0.png"},"large":{"name":"large_Безымянный.png","hash":"large_Bezymyannyj_1eb397dbd0","ext":".png","mime":"image/png","path":null,"width":1000,"height":798,"size":1872.8,"sizeInBytes":1872803,"url":"/uploads/large_Bezymyannyj_1eb397dbd0.png"}}	Bezymyannyj_1eb397dbd0	.png	image/png	726.56	/uploads/Bezymyannyj_1eb397dbd0.png		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
3	vapfulgh5bbyye3h69nm1zpt	photo15688152515.webp			700	366	{"thumbnail":{"name":"thumbnail_photo15688152515.webp","hash":"thumbnail_photo15688152515_050840f40b","ext":".webp","mime":"image/webp","path":null,"width":245,"height":128,"size":3.99,"sizeInBytes":3986,"url":"/uploads/thumbnail_photo15688152515_050840f40b.webp"},"small":{"name":"small_photo15688152515.webp","hash":"small_photo15688152515_050840f40b","ext":".webp","mime":"image/webp","path":null,"width":500,"height":261,"size":10.83,"sizeInBytes":10832,"url":"/uploads/small_photo15688152515_050840f40b.webp"}}	photo15688152515_050840f40b	.webp	image/webp	17.00	/uploads/photo15688152515_050840f40b.webp		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
4	c85fow3yaj7ljicb9v2pwhdn	images			221	228	{"thumbnail":{"name":"thumbnail_images","hash":"thumbnail_images_81628eafe1","ext":".jpeg","mime":"image/jpeg","path":null,"width":151,"height":156,"size":5.95,"sizeInBytes":5950,"url":"/uploads/thumbnail_images_81628eafe1.jpeg"}}	images_81628eafe1	.jpeg	image/jpeg	8.83	/uploads/images_81628eafe1.jpeg		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
5	mkq3agaa679keaqtgwcbdx2k	Безымянный.png			739	370	{"thumbnail":{"name":"thumbnail_Безымянный.png","hash":"thumbnail_Bezymyannyj_675c49fe1e","ext":".png","mime":"image/png","path":null,"width":245,"height":123,"size":48.97,"sizeInBytes":48973,"url":"/uploads/thumbnail_Bezymyannyj_675c49fe1e.png"},"small":{"name":"small_Безымянный.png","hash":"small_Bezymyannyj_675c49fe1e","ext":".png","mime":"image/png","path":null,"width":500,"height":250,"size":179.99,"sizeInBytes":179989,"url":"/uploads/small_Bezymyannyj_675c49fe1e.png"}}	Bezymyannyj_675c49fe1e	.png	image/png	126.80	/uploads/Bezymyannyj_675c49fe1e.png		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
6	sotcqm4mbyd2nmcawa990tan	images			232	217	{"thumbnail":{"name":"thumbnail_images","hash":"thumbnail_images_6feae267a1","ext":".jpeg","mime":"image/jpeg","path":null,"width":167,"height":156,"size":5.87,"sizeInBytes":5874,"url":"/uploads/thumbnail_images_6feae267a1.jpeg"}}	images_6feae267a1	.jpeg	image/jpeg	10.08	/uploads/images_6feae267a1.jpeg		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
7	vsnhyw3ccixjj1z4vmf1u0af	images			184	275	{"thumbnail":{"name":"thumbnail_images","hash":"thumbnail_images_b3152fe668","ext":".jpeg","mime":"image/jpeg","path":null,"width":104,"height":156,"size":2.71,"sizeInBytes":2709,"url":"/uploads/thumbnail_images_b3152fe668.jpeg"}}	images_b3152fe668	.jpeg	image/jpeg	5.93	/uploads/images_b3152fe668.jpeg		local	unknown_value_please_contact_support	/	2025-07-09	2025-07-09	2025-07-09	1	1	
\.


--
-- Data for Name: _files_folder_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._files_folder_lnk (id, file_id, folder_id, file_ord) FROM stdin;
\.


--
-- Data for Name: _files_related_mph; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._files_related_mph (id, file_id, related_id, related_type, field, "order") FROM stdin;
1	2	1	api::post.post	image	1.0
2	2	2	api::post.post	image	1.0
3	5	3	api::post.post	image	1.0
4	5	4	api::post.post	image	1.0
\.


--
-- Data for Name: _i18n_locale; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._i18n_locale (id, document_id, name, code, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	pw7mh2vbh88pxuooh21q53fc	English (en)	en	2025-07-07	2025-07-07	2025-07-07			
\.


--
-- Data for Name: _posts; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._posts (id, document_id, title, created_at, updated_at, published_at, created_by_id, updated_by_id, locale, likes, content, publish_date, slug, test_field) FROM stdin;
1	sxtop0bbnep8ji5oqx9drfxb	Oposum are the greatest TRASH RAT!	2025-07-09	2025-08-27		1	1		4	# Hug it!\n\n>Omg look at this gorgeous creature! It can stink and eat trash like a avatar of **Nurgl** himself!\n>цитаты великих людей( меня )\nОпоссумы – самые недооценённые санитары природы! Эти милые сумчатые не просто жрут мусор – они делают это с удивительной эффективностью и пользой для экосистемы. Опоссумы всеядны и с радостью поедают всё, что люди небрежно выбрасывают: от объедков и подгнивших фруктов до насекомых и мелких грызунов. Они даже помогают бороться с вредителями, уничтожая тысячи клещей за сезон! А их феноменальная устойчивость к ядам позволяет им лакомиться змеями, включая ядовитых, без вреда для здоровья.\n![images](http://46.173.18.108:1337/uploads/images_81628eafe1.jpeg)\n\nНо главное – опоссумы восхитительны в своей нелепости! Их реакция на стресс – притвориться мёртвым, причём так убедительно, что хищники теряют к ним интерес. А ещё они виртуозно лазают по деревьям, цепляясь хвостом, как пятой лапой, и выглядят при этом одновременно смешно и трогательно. Их детёныши путешествуют в маминой сумке, а взрослые особи – одиночки с философским взглядом на жизнь. Кто ещё может похвастаться такой комбинацией полезности и обаяния? Опоссумы – настоящие герои городских джунглей, скромные, но незаменимые! ð¾\n\n![photo15688152515.webp](http://46.173.18.108:1337/uploads/photo15688152515_050840f40b.web	2025-07-08	opposume	
2	sxtop0bbnep8ji5oqx9drfxb	Oposum are the greatest TRASH RAT!	2025-07-09	2025-07-09	2025-07-09	1	1		1	# Hug it!\n\n>Omg look at this gorgeous creature! It can stink and eat trash like a avatar of **Nurgl** himself!\n>цитаты великих людей( меня )\nОпоссумы – самые недооценённые санитары природы! Эти милые сумчатые не просто жрут мусор – они делают это с удивительной эффективностью и пользой для экосистемы. Опоссумы всеядны и с радостью поедают всё, что люди небрежно выбрасывают: от объедков и подгнивших фруктов до насекомых и мелких грызунов. Они даже помогают бороться с вредителями, уничтожая тысячи клещей за сезон! А их феноменальная устойчивость к ядам позволяет им лакомиться змеями, включая ядовитых, без вреда для здоровья.\n![images](http://46.173.18.108:1337/uploads/images_81628eafe1.jpeg)\n\nНо главное – опоссумы восхитительны в своей нелепости! Их реакция на стресс – притвориться мёртвым, причём так убедительно, что хищники теряют к ним интерес. А ещё они виртуозно лазают по деревьям, цепляясь хвостом, как пятой лапой, и выглядят при этом одновременно смешно и трогательно. Их детёныши путешествуют в маминой сумке, а взрослые особи – одиночки с философским взглядом на жизнь. Кто ещё может похвастаться такой комбинацией полезности и обаяния? Опоссумы – настоящие герои городских джунглей, скромные, но незаменимые! ð¾\n\n![photo15688152515.webp](http://46.173.18.108:1337/uploads/photo15688152515_050840f40b.web	2025-07-08	opposume	
3	barmdx9nrr9se9nx38u4so1u	Poltys — пауки-невидимки	2025-07-09	2025-07-09		1	1			Poltys — это пауки-«невидимки», которые словно сошли со страниц космического хоррора! Их причудливая форма и умение маскироваться под сухие ветки делают их похожими на тех самых лицехватов из «Чужого» — стоит лишь на секунду отвлечься, и вот уже кажется, что мертвый сучок на дереве вдруг шевельнулся. Эти пауки настолько мастерски сливаются с окружающей средой, что их почти невозможно заметить, пока они не решают пошевелиться. А когда они всё-таки двигаются, возникает жутковатое ощущение, будто сама природа вдруг ожила и смотрит прямо на тебя.\n![images](http://46.173.18.108:1337/uploads/images_6feae267a1.jpeg)\n\nИх внешность только усиливает впечатление чего-то инопланетно-опасного. Длинное, угловатое тело, покрытое шипами и наростами, неестественные позы и резкие движения — Poltys словно созданы для того, чтобы вызывать первобытный страх. Если бы эти пауки были размером с кошку, они бы точно стали прототипами для нового фильма ужасов! К счастью, они безобидны для человека, но их вид настолько пугающий, что даже арахнофилы порой содрогаются. Природа доказала: иногда самое страшное — это не зубы и яд, а жутковатая, почти сверхъестественная способность быть невидимкой… пока не станет слишком поздно.** ð±\n![images](http://46.173.18.108:1337/uploads/images_b3152fe668.jp	2025-07-08	Poltys	
4	barmdx9nrr9se9nx38u4so1u	Poltys — пауки-невидимки	2025-07-09	2025-07-09	2025-07-09	1	1			Poltys — это пауки-«невидимки», которые словно сошли со страниц космического хоррора! Их причудливая форма и умение маскироваться под сухие ветки делают их похожими на тех самых лицехватов из «Чужого» — стоит лишь на секунду отвлечься, и вот уже кажется, что мертвый сучок на дереве вдруг шевельнулся. Эти пауки настолько мастерски сливаются с окружающей средой, что их почти невозможно заметить, пока они не решают пошевелиться. А когда они всё-таки двигаются, возникает жутковатое ощущение, будто сама природа вдруг ожила и смотрит прямо на тебя.\n![images](http://46.173.18.108:1337/uploads/images_6feae267a1.jpeg)\n\nИх внешность только усиливает впечатление чего-то инопланетно-опасного. Длинное, угловатое тело, покрытое шипами и наростами, неестественные позы и резкие движения — Poltys словно созданы для того, чтобы вызывать первобытный страх. Если бы эти пауки были размером с кошку, они бы точно стали прототипами для нового фильма ужасов! К счастью, они безобидны для человека, но их вид настолько пугающий, что даже арахнофилы порой содрогаются. Природа доказала: иногда самое страшное — это не зубы и яд, а жутковатая, почти сверхъестественная способность быть невидимкой… пока не станет слишком поздно.** ð±\n![images](http://46.173.18.108:1337/uploads/images_b3152fe668.jp	2025-07-08	Poltys	
\.


--
-- Data for Name: _posts_category_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._posts_category_lnk (id, post_id, category_id, post_ord) FROM stdin;
1	1	1	1.0
2	2	2	1.0
3	3	1	2.0
4	4	2	2.0
\.


--
-- Data for Name: _sqlite_sequence; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._sqlite_sequence (name, seq) FROM stdin;
strapi_migrations_internal	6
files	7
upload_folders	0
i18n_locale	1
strapi_releases	0
strapi_release_actions	0
strapi_workflows	0
strapi_workflows_stages	0
up_permissions	17
up_roles	2
up_users	1
admin_permissions	108
admin_users	1
admin_roles	3
strapi_api_tokens	2
strapi_api_token_permissions	0
strapi_transfer_tokens	0
strapi_transfer_token_permissions	0
strapi_history_versions	0
files_related_mph	4
files_folder_lnk	0
upload_folders_parent_lnk	0
strapi_release_actions_release_lnk	0
strapi_workflows_stage_required_to_publish_lnk	0
strapi_workflows_stages_workflow_lnk	0
strapi_workflows_stages_permissions_lnk	0
up_permissions_role_lnk	17
up_users_role_lnk	1
admin_permissions_role_lnk	108
admin_users_roles_lnk	1
strapi_api_token_permissions_token_lnk	0
strapi_transfer_token_permissions_token_lnk	0
strapi_database_schema	31
strapi_core_store_settings	29
posts	4
categories	4
comments	0
comments_post_lnk	0
posts_category_lnk	4
\.


--
-- Data for Name: _strapi_api_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_api_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_api_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_api_token_permissions_token_lnk (id, api_token_permission_id, api_token_id, api_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: _strapi_api_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_api_tokens (id, document_id, name, description, type, access_key, encrypted_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	i3lwxbqfbdmrdcavlm68iojt	Read Only	A default API token with read-only permissions, only used for accessing resources	read-only	6a73aff7b9eb4973215fb2b8baabeb55e0b12f134ccdb7729a4f4c0b1561734d47d88ad7278d9b5acd40fbc8ac2189c740dc030415b39bf6e2080945b0ec6ef8	v1:ebb75f991bb262fbddaa3c3f6605c0e0:a587d3dc3dd8c7ffcfc0e39d1a0dea85b444f2bb510de994ab2615cc5e5ea9ce5ec061899ef3f5c611324d3d27b43949125928019002ea8b459115c69d6590f17d9c7ae59538d1423c2cefe52874012a845b04d9b2d94941e935a387f692fcaba01d5abbd3665d16bd42ae6e4beed16e6e6a434b00943258af59cd2da89f89f16df93e4353efbdcb37f8b10016ca0131114c63f952cd72c395a3bc43afaec9be8666e29fe6ae05437aae61a8f30242a1eb1a915cc8f2735269895f8266f9308918aa66640377285cd832694805de1a58613229a89eee1bfc7055eb6c572bf11c98393e3eeec7221d867ce3c6017b8865db03eecb766b7c37745a5205005e56a9:3d897b9432b77d63cc50e53702562197				2025-07-07	2025-07-07	2025-07-07			
2	puar4ai17kw0duf41epsqd5h	Full Access	A default API token with full access permissions, used for accessing or modifying resources	full-access	d7f92a0079394a83d76c4b61f6bf877a21c66c8718ca4bb6da69d938525998f6229aaeee9872501fdd8c665feab7d992ccfa6af1836b719f05e96d4f0f9374a7	v1:deab4b4c96537de32d993bfc1a7285f4:f4db90efa8921b67ae1c200a84e2d36497a323b169c936f775806486d640dd859a13aa1cf212e1a742207979f8bdaab76544c065e37d1ce966735babc0abd74f6ebed080d6d31657b9cd30d0df8e8a7b5be9745b708e8cb4a78fb96015681942e15c930474137303de8231bb24f0b1cbf20e2efabb3aca64e580c006d72422be234f3196ded96748d8e5fb5a7d397ac778c1bf977c458c44133dee097473ad71c43262c11f521c4f32fa8f64e06ce41b7f27282425d28f571e822280518dd49eed8b0c7bc8e1d6d647e62a5cc5db4820fa82759bd390158ea47f70b8c790eafa3bedf339d0a4db4d634d5bdd48ca0915213e5ab9983a232b32c2db08c5ad7cd9:e9be115b3f9508963b5a402022491c10				2025-07-07	2025-07-07	2025-07-07			
\.


--
-- Data for Name: _strapi_core_store_settings; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_core_store_settings (id, key, value, type, environment, tag) FROM stdin;
1	strapi_content_types_schema	{"plugin::upload.file":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"files"}}},"indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null}],"plugin":"upload","globalId":"UploadFile","uid":"plugin::upload.file","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"files","info":{"singularName":"file","pluralName":"files","displayName":"File","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"type":"relation","relation":"morphToMany","configurable":false},"folder":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"files","private":true},"folderPath":{"type":"string","minLength":1,"required":true,"private":true,"searchable":false}},"kind":"collectionType"},"modelName":"file"},"plugin::upload.folder":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"upload_folders"}}},"indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"}],"plugin":"upload","globalId":"UploadFolder","uid":"plugin::upload.folder","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"upload_folders","info":{"singularName":"folder","pluralName":"folders","displayName":"Folder"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"required":true},"pathId":{"type":"integer","unique":true,"required":true},"parent":{"type":"relation","relation":"manyToOne","target":"plugin::upload.folder","inversedBy":"children"},"children":{"type":"relation","relation":"oneToMany","target":"plugin::upload.folder","mappedBy":"parent"},"files":{"type":"relation","relation":"oneToMany","target":"plugin::upload.file","mappedBy":"folder"},"path":{"type":"string","minLength":1,"required":true}},"kind":"collectionType"},"modelName":"folder"},"plugin::i18n.locale":{"info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::i18n.locale","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"i18n_locale"}}},"plugin":"i18n","collectionName":"i18n_locale","globalId":"I18NLocale","uid":"plugin::i18n.locale","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"i18n_locale","info":{"singularName":"locale","pluralName":"locales","collectionName":"locales","displayName":"Locale","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false}},"kind":"collectionType"},"modelName":"locale"},"plugin::content-releases.release":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_releases"}}},"plugin":"content-releases","globalId":"ContentReleasesRelease","uid":"plugin::content-releases.release","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_releases","info":{"singularName":"release","pluralName":"releases","displayName":"Release"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true},"releasedAt":{"type":"datetime"},"scheduledAt":{"type":"datetime"},"timezone":{"type":"string"},"status":{"type":"enumeration","enum":["ready","blocked","failed","done","empty"],"required":true},"actions":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","mappedBy":"release"}},"kind":"collectionType"},"modelName":"release"},"plugin::content-releases.release-action":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::content-releases.release-action","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_release_actions"}}},"plugin":"content-releases","globalId":"ContentReleasesReleaseAction","uid":"plugin::content-releases.release-action","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_release_actions","info":{"singularName":"release-action","pluralName":"release-actions","displayName":"Release Action"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"type":{"type":"enumeration","enum":["publish","unpublish"],"required":true},"contentType":{"type":"string","required":true},"entryDocumentId":{"type":"string"},"locale":{"type":"string"},"release":{"type":"relation","relation":"manyToOne","target":"plugin::content-releases.release","inversedBy":"actions"},"isEntryValid":{"type":"boolean"}},"kind":"collectionType"},"modelName":"release-action"},"plugin::review-workflows.workflow":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflow","uid":"plugin::review-workflows.workflow","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows","info":{"name":"Workflow","description":"","singularName":"workflow","pluralName":"workflows","displayName":"Workflow"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","required":true,"unique":true},"stages":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToMany","mappedBy":"workflow"},"stageRequiredToPublish":{"type":"relation","target":"plugin::review-workflows.workflow-stage","relation":"oneToOne","required":false},"contentTypes":{"type":"json","required":true,"default":"[]"}},"kind":"collectionType"},"modelName":"workflow"},"plugin::review-workflows.workflow-stage":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0","draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::review-workflows.workflow-stage","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_workflows_stages"}}},"plugin":"review-workflows","globalId":"ReviewWorkflowsWorkflowStage","uid":"plugin::review-workflows.workflow-stage","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_workflows_stages","info":{"name":"Workflow Stage","description":"","singularName":"workflow-stage","pluralName":"workflow-stages","displayName":"Stages"},"options":{"version":"1.1.0"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false},"color":{"type":"string","configurable":false,"default":"#4945FF"},"workflow":{"type":"relation","target":"plugin::review-workflows.workflow","relation":"manyToOne","inversedBy":"stages","configurable":false},"permissions":{"type":"relation","target":"admin::permission","relation":"manyToMany","configurable":false}},"kind":"collectionType"},"modelName":"workflow-stage"},"plugin::users-permissions.permission":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_permissions"}}},"plugin":"users-permissions","globalId":"UsersPermissionsPermission","uid":"plugin::users-permissions.permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_permissions","info":{"name":"permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","required":true,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"permissions","configurable":false}},"kind":"collectionType"},"modelName":"permission","options":{"draftAndPublish":false}},"plugin::users-permissions.role":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_roles"}}},"plugin":"users-permissions","globalId":"UsersPermissionsRole","uid":"plugin::users-permissions.role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_roles","info":{"name":"role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.permission","mappedBy":"role","configurable":false},"users":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","mappedBy":"role","configurable":false}},"kind":"collectionType"},"modelName":"role","options":{"draftAndPublish":false}},"plugin::users-permissions.user":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true,"draftAndPublish":false},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"plugin::users-permissions.user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"up_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"confirmationToken":{"hidden":true},"provider":{"hidden":true}}},"plugin":"users-permissions","globalId":"UsersPermissionsUser","uid":"plugin::users-permissions.user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"up_users","info":{"name":"user","description":"","singularName":"user","pluralName":"users","displayName":"User"},"options":{"timestamps":true},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"type":"relation","relation":"manyToOne","target":"plugin::users-permissions.role","inversedBy":"users","configurable":false}},"kind":"collectionType"},"modelName":"user"},"api::category.category":{"kind":"collectionType","collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"name":{"type":"string"},"description":{"type":"text"},"posts":{"type":"relation","relation":"oneToMany","target":"api::post.post","mappedBy":"category"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::category.category","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"categories"}}},"apiName":"category","globalId":"Category","uid":"api::category.category","modelType":"contentType","__schema__":{"collectionName":"categories","info":{"singularName":"category","pluralName":"categories","displayName":"Category"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"name":{"type":"string"},"description":{"type":"text"},"posts":{"type":"relation","relation":"oneToMany","target":"api::post.post","mappedBy":"category"}},"kind":"collectionType"},"modelName":"category","actions":{},"lifecycles":{}},"api::comment.comment":{"kind":"collectionType","collectionName":"comments","info":{"singularName":"comment","pluralName":"comments","displayName":"Comment"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"autor":{"type":"string"},"content":{"type":"text"},"publish_date":{"type":"datetime"},"post":{"type":"relation","relation":"manyToOne","target":"api::post.post","inversedBy":"comments"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::comment.comment","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"comments"}}},"apiName":"comment","globalId":"Comment","uid":"api::comment.comment","modelType":"contentType","__schema__":{"collectionName":"comments","info":{"singularName":"comment","pluralName":"comments","displayName":"Comment"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"autor":{"type":"string"},"content":{"type":"text"},"publish_date":{"type":"datetime"},"post":{"type":"relation","relation":"manyToOne","target":"api::post.post","inversedBy":"comments"}},"kind":"collectionType"},"modelName":"comment","actions":{},"lifecycles":{}},"api::post.post":{"kind":"collectionType","collectionName":"posts","info":{"singularName":"post","pluralName":"posts","displayName":"Post"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string"},"image":{"type":"media","multiple":false,"allowedTypes":["images","files","videos","audios"]},"content":{"type":"richtext"},"publish_date":{"type":"datetime"},"likes":{"type":"integer"},"slug":{"type":"uid"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category","inversedBy":"posts"},"comments":{"type":"relation","relation":"oneToMany","target":"api::comment.comment","mappedBy":"post"},"test_field":{"type":"string"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"api::post.post","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"posts"}}},"apiName":"post","globalId":"Post","uid":"api::post.post","modelType":"contentType","__schema__":{"collectionName":"posts","info":{"singularName":"post","pluralName":"posts","displayName":"Post"},"options":{"draftAndPublish":true},"pluginOptions":{},"attributes":{"title":{"type":"string"},"image":{"type":"media","multiple":false,"allowedTypes":["images","files","videos","audios"]},"content":{"type":"richtext"},"publish_date":{"type":"datetime"},"likes":{"type":"integer"},"slug":{"type":"uid"},"category":{"type":"relation","relation":"manyToOne","target":"api::category.category","inversedBy":"posts"},"comments":{"type":"relation","relation":"oneToMany","target":"api::comment.comment","mappedBy":"post"},"test_field":{"type":"string"}},"kind":"collectionType"},"modelName":"post","actions":{},"lifecycles":{}},"admin::permission":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_permissions"}}},"plugin":"admin","globalId":"AdminPermission","uid":"admin::permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_permissions","info":{"name":"Permission","description":"","singularName":"permission","pluralName":"permissions","displayName":"Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"actionParameters":{"type":"json","configurable":false,"required":false,"default":{}},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::role"}},"kind":"collectionType"},"modelName":"permission"},"admin::user":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::user","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_users"}}},"config":{"attributes":{"resetPasswordToken":{"hidden":true},"registrationToken":{"hidden":true}}},"plugin":"admin","globalId":"AdminUser","uid":"admin::user","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_users","info":{"name":"User","description":"","singularName":"user","pluralName":"users","displayName":"User"},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true,"searchable":false},"resetPasswordToken":{"type":"string","configurable":false,"private":true,"searchable":false},"registrationToken":{"type":"string","configurable":false,"private":true,"searchable":false},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"configurable":false,"private":true,"type":"relation","relation":"manyToMany","inversedBy":"users","target":"admin::role","collectionName":"strapi_users_roles"},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false,"searchable":false}},"kind":"collectionType"},"modelName":"user","options":{"draftAndPublish":false}},"admin::role":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::role","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"admin_roles"}}},"plugin":"admin","globalId":"AdminRole","uid":"admin::role","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"admin_roles","info":{"name":"Role","description":"","singularName":"role","pluralName":"roles","displayName":"Role"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"type":"relation","relation":"manyToMany","mappedBy":"roles","target":"admin::user"},"permissions":{"configurable":false,"type":"relation","relation":"oneToMany","mappedBy":"role","target":"admin::permission"}},"kind":"collectionType"},"modelName":"role"},"admin::api-token":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_tokens"}}},"plugin":"admin","globalId":"AdminApiToken","uid":"admin::api-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_tokens","info":{"name":"Api Token","singularName":"api-token","pluralName":"api-tokens","displayName":"Api Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"type":{"type":"enumeration","enum":["read-only","full-access","custom"],"configurable":false,"required":true,"default":"read-only"},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true,"searchable":false},"encryptedKey":{"type":"text","minLength":1,"configurable":false,"required":false,"searchable":false},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::api-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"api-token"},"admin::api-token-permission":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::api-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_api_token_permissions"}}},"plugin":"admin","globalId":"AdminApiTokenPermission","uid":"admin::api-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_api_token_permissions","info":{"name":"API Token Permission","description":"","singularName":"api-token-permission","pluralName":"api-token-permissions","displayName":"API Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::api-token"}},"kind":"collectionType"},"modelName":"api-token-permission"},"admin::transfer-token":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_tokens"}}},"plugin":"admin","globalId":"AdminTransferToken","uid":"admin::transfer-token","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_tokens","info":{"name":"Transfer Token","singularName":"transfer-token","pluralName":"transfer-tokens","displayName":"Transfer Token","description":""},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"configurable":false,"required":true,"unique":true},"description":{"type":"string","minLength":1,"configurable":false,"required":false,"default":""},"accessKey":{"type":"string","minLength":1,"configurable":false,"required":true},"lastUsedAt":{"type":"datetime","configurable":false,"required":false},"permissions":{"type":"relation","target":"admin::transfer-token-permission","relation":"oneToMany","mappedBy":"token","configurable":false,"required":false},"expiresAt":{"type":"datetime","configurable":false,"required":false},"lifespan":{"type":"biginteger","configurable":false,"required":false}},"kind":"collectionType"},"modelName":"transfer-token"},"admin::transfer-token-permission":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{"draftAndPublish":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"},"createdAt":{"type":"datetime"},"updatedAt":{"type":"datetime"},"publishedAt":{"type":"datetime","configurable":false,"writable":true,"visible":false},"createdBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"updatedBy":{"type":"relation","relation":"oneToOne","target":"admin::user","configurable":false,"writable":false,"visible":false,"useJoinTable":false,"private":true},"locale":{"writable":true,"private":true,"configurable":false,"visible":false,"type":"string"},"localizations":{"type":"relation","relation":"oneToMany","target":"admin::transfer-token-permission","writable":false,"private":true,"configurable":false,"visible":false,"unstable_virtual":true,"joinColumn":{"name":"document_id","referencedColumn":"document_id","referencedTable":"strapi_transfer_token_permissions"}}},"plugin":"admin","globalId":"AdminTransferTokenPermission","uid":"admin::transfer-token-permission","modelType":"contentType","kind":"collectionType","__schema__":{"collectionName":"strapi_transfer_token_permissions","info":{"name":"Transfer Token Permission","description":"","singularName":"transfer-token-permission","pluralName":"transfer-token-permissions","displayName":"Transfer Token Permission"},"options":{},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"token":{"configurable":false,"type":"relation","relation":"manyToOne","inversedBy":"permissions","target":"admin::transfer-token"}},"kind":"collectionType"},"modelName":"transfer-token-permission"}}	object		
2	plugin_content_manager_configuration_content_types::plugin::upload.file	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"alternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"alternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"width","searchable":true,"sortable":true}},"height":{"edit":{"label":"height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"size","searchable":true,"sortable":true}},"url":{"edit":{"label":"url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"previewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"previewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"provider_metadata","searchable":false,"sortable":false}},"folder":{"edit":{"label":"folder","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"folder","searchable":true,"sortable":true}},"folderPath":{"edit":{"label":"folderPath","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"folderPath","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}],[{"name":"folder","size":6},{"name":"folderPath","size":6}]]},"uid":"plugin::upload.file"}	object		
3	plugin_content_manager_configuration_content_types::plugin::upload.folder	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"pathId":{"edit":{"label":"pathId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"pathId","searchable":true,"sortable":true}},"parent":{"edit":{"label":"parent","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"parent","searchable":true,"sortable":true}},"children":{"edit":{"label":"children","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"children","searchable":false,"sortable":false}},"files":{"edit":{"label":"files","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"files","searchable":false,"sortable":false}},"path":{"edit":{"label":"path","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"path","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","pathId","parent"],"edit":[[{"name":"name","size":6},{"name":"pathId","size":4}],[{"name":"parent","size":6},{"name":"children","size":6}],[{"name":"files","size":6},{"name":"path","size":6}]]},"uid":"plugin::upload.folder"}	object		
4	plugin_content_manager_configuration_content_types::plugin::i18n.locale	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","createdAt"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]},"uid":"plugin::i18n.locale"}	object		
5	plugin_content_manager_configuration_content_types::plugin::content-releases.release	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"releasedAt":{"edit":{"label":"releasedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"releasedAt","searchable":true,"sortable":true}},"scheduledAt":{"edit":{"label":"scheduledAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"scheduledAt","searchable":true,"sortable":true}},"timezone":{"edit":{"label":"timezone","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"timezone","searchable":true,"sortable":true}},"status":{"edit":{"label":"status","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"status","searchable":true,"sortable":true}},"actions":{"edit":{"label":"actions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"contentType"},"list":{"label":"actions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","releasedAt","scheduledAt"],"edit":[[{"name":"name","size":6},{"name":"releasedAt","size":6}],[{"name":"scheduledAt","size":6},{"name":"timezone","size":6}],[{"name":"status","size":6},{"name":"actions","size":6}]]},"uid":"plugin::content-releases.release"}	object		
6	plugin_content_manager_configuration_content_types::plugin::content-releases.release-action	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"contentType","defaultSortBy":"contentType","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"contentType":{"edit":{"label":"contentType","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentType","searchable":true,"sortable":true}},"entryDocumentId":{"edit":{"label":"entryDocumentId","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"entryDocumentId","searchable":true,"sortable":true}},"release":{"edit":{"label":"release","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"release","searchable":true,"sortable":true}},"isEntryValid":{"edit":{"label":"isEntryValid","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isEntryValid","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","contentType","entryDocumentId"],"edit":[[{"name":"type","size":6},{"name":"contentType","size":6}],[{"name":"entryDocumentId","size":6},{"name":"release","size":6}],[{"name":"isEntryValid","size":4}]]},"uid":"plugin::content-releases.release-action"}	object		
7	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"stages":{"edit":{"label":"stages","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stages","searchable":false,"sortable":false}},"stageRequiredToPublish":{"edit":{"label":"stageRequiredToPublish","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"stageRequiredToPublish","searchable":true,"sortable":true}},"contentTypes":{"edit":{"label":"contentTypes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"contentTypes","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","stages","stageRequiredToPublish"],"edit":[[{"name":"name","size":6},{"name":"stages","size":6}],[{"name":"stageRequiredToPublish","size":6}],[{"name":"contentTypes","size":12}]]},"uid":"plugin::review-workflows.workflow"}	object		
8	plugin_content_manager_configuration_content_types::plugin::review-workflows.workflow-stage	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"color":{"edit":{"label":"color","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"color","searchable":true,"sortable":true}},"workflow":{"edit":{"label":"workflow","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"workflow","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","color","workflow"],"edit":[[{"name":"name","size":6},{"name":"color","size":6}],[{"name":"workflow","size":6},{"name":"permissions","size":6}]]},"uid":"plugin::review-workflows.workflow-stage"}	object		
9	plugin_content_manager_configuration_content_types::plugin::users-permissions.permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","role","createdAt"],"edit":[[{"name":"action","size":6},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.permission"}	object		
10	plugin_content_manager_configuration_content_types::plugin::users-permissions.role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"users","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"permissions","size":6}],[{"name":"users","size":6}]]},"uid":"plugin::users-permissions.role"}	object		
11	plugin_content_manager_configuration_content_types::plugin::users-permissions.user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"confirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"confirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4},{"name":"role","size":6}]]},"uid":"plugin::users-permissions.user"}	object		
12	plugin_content_manager_configuration_content_types::admin::permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"actionParameters":{"edit":{"label":"actionParameters","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"actionParameters","searchable":false,"sortable":false}},"subject":{"edit":{"label":"subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"role","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"edit":[[{"name":"action","size":6}],[{"name":"actionParameters","size":12}],[{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}],[{"name":"role","size":6}]]},"uid":"admin::permission"}	object		
13	plugin_content_manager_configuration_content_types::admin::user	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"username","searchable":true,"sortable":true}},"email":{"edit":{"label":"email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"email","searchable":true,"sortable":true}},"password":{"edit":{"label":"password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"resetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"resetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"registrationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"registrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"isActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"isActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"preferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"preferedLanguage","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"isActive","size":4}],[{"name":"roles","size":6},{"name":"blocked","size":4}],[{"name":"preferedLanguage","size":6}]]},"uid":"admin::user"}	object		
14	plugin_content_manager_configuration_content_types::admin::role	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"code":{"edit":{"label":"code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"code","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"users":{"edit":{"label":"users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6},{"name":"users","size":6}],[{"name":"permissions","size":6}]]},"uid":"admin::role"}	object		
15	plugin_content_manager_configuration_content_types::admin::api-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"type":{"edit":{"label":"type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"type","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"encryptedKey":{"edit":{"label":"encryptedKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"encryptedKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","type"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6},{"name":"accessKey","size":6}],[{"name":"encryptedKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::api-token"}	object		
16	plugin_content_manager_configuration_content_types::admin::api-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::api-token-permission"}	object		
17	plugin_content_manager_configuration_content_types::admin::transfer-token	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"accessKey":{"edit":{"label":"accessKey","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"accessKey","searchable":true,"sortable":true}},"lastUsedAt":{"edit":{"label":"lastUsedAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lastUsedAt","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"permissions","searchable":false,"sortable":false}},"expiresAt":{"edit":{"label":"expiresAt","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"expiresAt","searchable":true,"sortable":true}},"lifespan":{"edit":{"label":"lifespan","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"lifespan","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","accessKey"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"accessKey","size":6},{"name":"lastUsedAt","size":6}],[{"name":"permissions","size":6},{"name":"expiresAt","size":6}],[{"name":"lifespan","size":4}]]},"uid":"admin::transfer-token"}	object		
18	plugin_content_manager_configuration_content_types::admin::transfer-token-permission	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"action":{"edit":{"label":"action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"action","searchable":true,"sortable":true}},"token":{"edit":{"label":"token","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"token","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","token","createdAt"],"edit":[[{"name":"action","size":6},{"name":"token","size":6}]]},"uid":"admin::transfer-token-permission"}	object		
19	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true,"autoOrientation":false}	object		
20	plugin_upload_view_configuration	{"pageSize":10,"sort":"createdAt:DESC"}	object		
21	plugin_upload_metrics	{"weeklySchedule":"44 39 15 * * 2","lastWeeklyUpdate":1756222784026}	object		
22	plugin_i18n_default_locale	"en"	string		
23	plugin_users-permissions_grant	{"email":{"icon":"envelope","enabled":true},"discord":{"icon":"discord","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/discord/callback","scope":["identify","email"]},"facebook":{"icon":"facebook-square","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/facebook/callback","scope":["email"]},"google":{"icon":"google","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/google/callback","scope":["email"]},"github":{"icon":"github","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/github/callback","scope":["user","user:email"]},"microsoft":{"icon":"windows","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/microsoft/callback","scope":["user.read"]},"twitter":{"icon":"twitter","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitter/callback"},"instagram":{"icon":"instagram","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/instagram/callback","scope":["user_profile"]},"vk":{"icon":"vk","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/vk/callback","scope":["email"]},"twitch":{"icon":"twitch","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"icon":"linkedin","enabled":false,"key":"","secret":"","callbackUrl":"api/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"icon":"aws","enabled":false,"key":"","secret":"","subdomain":"my.subdomain.com","callback":"api/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"icon":"reddit","enabled":false,"key":"","secret":"","callback":"api/auth/reddit/callback","scope":["identity"]},"auth0":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"my-tenant.eu","callback":"api/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"icon":"book","enabled":false,"key":"","secret":"","callback":"api/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"},"patreon":{"icon":"","enabled":false,"key":"","secret":"","callback":"api/auth/patreon/callback","scope":["identity","identity[email]"]},"keycloak":{"icon":"","enabled":false,"key":"","secret":"","subdomain":"myKeycloakProvider.com/realms/myrealm","callback":"api/auth/keycloak/callback","scope":["openid","email","profile"]}}	object		
24	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object		
25	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object		
26	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null,"ssoLockedRoles":null}}	object		
27	plugin_content_manager_configuration_content_types::api::post.post	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"title","defaultSortBy":"title","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"title":{"edit":{"label":"title","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"title","searchable":true,"sortable":true}},"image":{"edit":{"label":"image","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"image","searchable":false,"sortable":false}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":false,"sortable":false}},"publish_date":{"edit":{"label":"publish_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"publish_date","searchable":true,"sortable":true}},"likes":{"edit":{"label":"likes","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"likes","searchable":true,"sortable":true}},"slug":{"edit":{"label":"slug","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"slug","searchable":true,"sortable":true}},"category":{"edit":{"label":"category","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"category","searchable":true,"sortable":true}},"comments":{"edit":{"label":"comments","description":"","placeholder":"","visible":true,"editable":true,"mainField":"autor"},"list":{"label":"comments","searchable":false,"sortable":false}},"test_field":{"edit":{"label":"test_field","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"test_field","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","title","createdAt","updatedAt"],"edit":[[{"name":"title","size":6},{"name":"likes","size":4}],[{"name":"content","size":12}],[{"name":"publish_date","size":6},{"name":"slug","size":6}],[{"name":"image","size":6},{"name":"category","size":6}],[{"name":"comments","size":6},{"name":"test_field","size":6}]]},"uid":"api::post.post"}	object		
28	plugin_content_manager_configuration_content_types::api::category.category	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"name":{"edit":{"label":"name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"name","searchable":true,"sortable":true}},"description":{"edit":{"label":"description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"description","searchable":true,"sortable":true}},"posts":{"edit":{"label":"posts","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"posts","searchable":false,"sortable":false}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","description","createdAt"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"posts","size":6}]]},"uid":"api::category.category"}	object		
29	plugin_content_manager_configuration_content_types::api::comment.comment	{"settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"autor","defaultSortBy":"autor","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"id","searchable":true,"sortable":true}},"autor":{"edit":{"label":"autor","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"autor","searchable":true,"sortable":true}},"content":{"edit":{"label":"content","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"content","searchable":true,"sortable":true}},"publish_date":{"edit":{"label":"publish_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"publish_date","searchable":true,"sortable":true}},"post":{"edit":{"label":"post","description":"","placeholder":"","visible":true,"editable":true,"mainField":"title"},"list":{"label":"post","searchable":true,"sortable":true}},"createdAt":{"edit":{"label":"createdAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"createdAt","searchable":true,"sortable":true}},"updatedAt":{"edit":{"label":"updatedAt","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"updatedAt","searchable":true,"sortable":true}},"createdBy":{"edit":{"label":"createdBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"createdBy","searchable":true,"sortable":true}},"updatedBy":{"edit":{"label":"updatedBy","description":"","placeholder":"","visible":false,"editable":true,"mainField":"firstname"},"list":{"label":"updatedBy","searchable":true,"sortable":true}},"documentId":{"edit":{},"list":{"label":"documentId","searchable":true,"sortable":true}}},"layouts":{"list":["id","autor","content","publish_date"],"edit":[[{"name":"autor","size":6},{"name":"content","size":6}],[{"name":"publish_date","size":6},{"name":"post","size":6}]]},"uid":"api::comment.comment"}	object		
\.


--
-- Data for Name: _strapi_database_schema; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_database_schema (id, schema, "time", hash) FROM stdin;
31	{"tables":[{"name":"files","indexes":[{"name":"upload_files_folder_path_index","columns":["folder_path"],"type":null},{"name":"upload_files_created_at_index","columns":["created_at"],"type":null},{"name":"upload_files_updated_at_index","columns":["updated_at"],"type":null},{"name":"upload_files_name_index","columns":["name"],"type":null},{"name":"upload_files_size_index","columns":["size"],"type":null},{"name":"upload_files_ext_index","columns":["ext"],"type":null},{"name":"files_documents_idx","columns":["document_id","locale","published_at"]},{"name":"files_created_by_id_fk","columns":["created_by_id"]},{"name":"files_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"files_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"files_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"alternative_text","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"caption","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"width","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"height","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"formats","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"hash","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"ext","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"mime","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"size","type":"decimal","args":[10,2],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"preview_url","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider_metadata","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"folder_path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"upload_folders","indexes":[{"name":"upload_folders_path_id_index","columns":["path_id"],"type":"unique"},{"name":"upload_folders_path_index","columns":["path"],"type":"unique"},{"name":"upload_folders_documents_idx","columns":["document_id","locale","published_at"]},{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"]},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"upload_folders_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"upload_folders_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"path","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"i18n_locale","indexes":[{"name":"i18n_locale_documents_idx","columns":["document_id","locale","published_at"]},{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"]},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"i18n_locale_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"i18n_locale_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_releases","indexes":[{"name":"strapi_releases_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_releases_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_releases_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"released_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"scheduled_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"timezone","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_release_actions","indexes":[{"name":"strapi_release_actions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_release_actions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_release_actions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"entry_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_entry_valid","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows","indexes":[{"name":"strapi_workflows_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content_types","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_workflows_stages","indexes":[{"name":"strapi_workflows_stages_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_workflows_stages_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_workflows_stages_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"color","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_permissions","indexes":[{"name":"up_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_roles","indexes":[{"name":"up_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"up_users","indexes":[{"name":"up_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"up_users_created_by_id_fk","columns":["created_by_id"]},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"up_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"up_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"provider","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmation_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"confirmed","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"categories","indexes":[{"name":"categories_documents_idx","columns":["document_id","locale","published_at"]},{"name":"categories_created_by_id_fk","columns":["created_by_id"]},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"categories_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"categories_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"comments","indexes":[{"name":"comments_documents_idx","columns":["document_id","locale","published_at"]},{"name":"comments_created_by_id_fk","columns":["created_by_id"]},{"name":"comments_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"comments_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"comments_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"autor","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"publish_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"posts","indexes":[{"name":"posts_documents_idx","columns":["document_id","locale","published_at"]},{"name":"posts_created_by_id_fk","columns":["created_by_id"]},{"name":"posts_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"posts_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"posts_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"title","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"content","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"publish_date","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"likes","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"slug","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"test_field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_permissions","indexes":[{"name":"admin_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action_parameters","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"subject","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"properties","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"conditions","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_users","indexes":[{"name":"admin_users_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_users_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_users_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_users_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"firstname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lastname","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"username","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"email","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"password","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"reset_password_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"registration_token","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"is_active","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"blocked","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"prefered_language","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"admin_roles","indexes":[{"name":"admin_roles_documents_idx","columns":["document_id","locale","published_at"]},{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"]},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"admin_roles_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"admin_roles_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"code","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_tokens","indexes":[{"name":"strapi_api_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"encrypted_key","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_api_token_permissions","indexes":[{"name":"strapi_api_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_api_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_tokens","indexes":[{"name":"strapi_transfer_tokens_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_tokens_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_tokens_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"description","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"access_key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"last_used_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"expires_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"lifespan","type":"bigInteger","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_transfer_token_permissions","indexes":[{"name":"strapi_transfer_token_permissions_documents_idx","columns":["document_id","locale","published_at"]},{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"]},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"},{"name":"strapi_transfer_token_permissions_updated_by_id_fk","columns":["updated_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"action","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"updated_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"published_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"updated_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_core_store_settings","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"key","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"value","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"environment","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"tag","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_webhooks","indexes":[],"foreignKeys":[],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"name","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"url","type":"text","args":["longtext"],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"headers","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"events","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"enabled","type":"boolean","args":[],"defaultTo":null,"notNullable":false,"unsigned":false}]},{"name":"strapi_history_versions","indexes":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"]}],"foreignKeys":[{"name":"strapi_history_versions_created_by_id_fk","columns":["created_by_id"],"referencedTable":"admin_users","referencedColumns":["id"],"onDelete":"SET NULL"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"content_type","type":"string","args":[],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"related_document_id","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"locale","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"status","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"data","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"schema","type":"jsonb","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_at","type":"datetime","args":[{"useTz":false,"precision":6}],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"created_by_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_related_mph","indexes":[{"name":"files_related_mph_fk","columns":["file_id"]},{"name":"files_related_mph_oidx","columns":["order"]},{"name":"files_related_mph_idix","columns":["related_id"]}],"foreignKeys":[{"name":"files_related_mph_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"related_type","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"field","type":"string","args":[],"defaultTo":null,"notNullable":false,"unsigned":false},{"name":"order","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"files_folder_lnk","indexes":[{"name":"files_folder_lnk_fk","columns":["file_id"]},{"name":"files_folder_lnk_ifk","columns":["folder_id"]},{"name":"files_folder_lnk_uq","columns":["file_id","folder_id"],"type":"unique"},{"name":"files_folder_lnk_oifk","columns":["file_ord"]}],"foreignKeys":[{"name":"files_folder_lnk_fk","columns":["file_id"],"referencedColumns":["id"],"referencedTable":"files","onDelete":"CASCADE"},{"name":"files_folder_lnk_ifk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"file_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"file_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"upload_folders_parent_lnk","indexes":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"]},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"]},{"name":"upload_folders_parent_lnk_uq","columns":["folder_id","inv_folder_id"],"type":"unique"},{"name":"upload_folders_parent_lnk_oifk","columns":["folder_ord"]}],"foreignKeys":[{"name":"upload_folders_parent_lnk_fk","columns":["folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"},{"name":"upload_folders_parent_lnk_ifk","columns":["inv_folder_id"],"referencedColumns":["id"],"referencedTable":"upload_folders","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"inv_folder_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"folder_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_release_actions_release_lnk","indexes":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"]},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"]},{"name":"strapi_release_actions_release_lnk_uq","columns":["release_action_id","release_id"],"type":"unique"},{"name":"strapi_release_actions_release_lnk_oifk","columns":["release_action_ord"]}],"foreignKeys":[{"name":"strapi_release_actions_release_lnk_fk","columns":["release_action_id"],"referencedColumns":["id"],"referencedTable":"strapi_release_actions","onDelete":"CASCADE"},{"name":"strapi_release_actions_release_lnk_ifk","columns":["release_id"],"referencedColumns":["id"],"referencedTable":"strapi_releases","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"release_action_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"release_action_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stage_required_to_publish_lnk","indexes":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stage_required_to_publish_lnk_uq","columns":["workflow_id","workflow_stage_id"],"type":"unique"}],"foreignKeys":[{"name":"strapi_workflows_stage_required_to_publish_lnk_fk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"},{"name":"strapi_workflows_stage_required_to_publish_lnk_ifk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_workflow_lnk","indexes":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"]},{"name":"strapi_workflows_stages_workflow_lnk_uq","columns":["workflow_stage_id","workflow_id"],"type":"unique"},{"name":"strapi_workflows_stages_workflow_lnk_oifk","columns":["workflow_stage_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_workflow_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_workflow_lnk_ifk","columns":["workflow_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"workflow_stage_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_workflows_stages_permissions_lnk","indexes":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"]},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"]},{"name":"strapi_workflows_stages_permissions_lnk_uq","columns":["workflow_stage_id","permission_id"],"type":"unique"},{"name":"strapi_workflows_stages_permissions_lnk_ofk","columns":["permission_ord"]}],"foreignKeys":[{"name":"strapi_workflows_stages_permissions_lnk_fk","columns":["workflow_stage_id"],"referencedColumns":["id"],"referencedTable":"strapi_workflows_stages","onDelete":"CASCADE"},{"name":"strapi_workflows_stages_permissions_lnk_ifk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"workflow_stage_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_permissions_role_lnk","indexes":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"up_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"up_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"up_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"up_permissions","onDelete":"CASCADE"},{"name":"up_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"up_users_role_lnk","indexes":[{"name":"up_users_role_lnk_fk","columns":["user_id"]},{"name":"up_users_role_lnk_ifk","columns":["role_id"]},{"name":"up_users_role_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"up_users_role_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"up_users_role_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"up_users","onDelete":"CASCADE"},{"name":"up_users_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"up_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"comments_post_lnk","indexes":[{"name":"comments_post_lnk_fk","columns":["comment_id"]},{"name":"comments_post_lnk_ifk","columns":["post_id"]},{"name":"comments_post_lnk_uq","columns":["comment_id","post_id"],"type":"unique"},{"name":"comments_post_lnk_oifk","columns":["comment_ord"]}],"foreignKeys":[{"name":"comments_post_lnk_fk","columns":["comment_id"],"referencedColumns":["id"],"referencedTable":"comments","onDelete":"CASCADE"},{"name":"comments_post_lnk_ifk","columns":["post_id"],"referencedColumns":["id"],"referencedTable":"posts","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"comment_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"comment_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"posts_category_lnk","indexes":[{"name":"posts_category_lnk_fk","columns":["post_id"]},{"name":"posts_category_lnk_ifk","columns":["category_id"]},{"name":"posts_category_lnk_uq","columns":["post_id","category_id"],"type":"unique"},{"name":"posts_category_lnk_oifk","columns":["post_ord"]}],"foreignKeys":[{"name":"posts_category_lnk_fk","columns":["post_id"],"referencedColumns":["id"],"referencedTable":"posts","onDelete":"CASCADE"},{"name":"posts_category_lnk_ifk","columns":["category_id"],"referencedColumns":["id"],"referencedTable":"categories","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"post_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"category_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"post_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_permissions_role_lnk","indexes":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"]},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"]},{"name":"admin_permissions_role_lnk_uq","columns":["permission_id","role_id"],"type":"unique"},{"name":"admin_permissions_role_lnk_oifk","columns":["permission_ord"]}],"foreignKeys":[{"name":"admin_permissions_role_lnk_fk","columns":["permission_id"],"referencedColumns":["id"],"referencedTable":"admin_permissions","onDelete":"CASCADE"},{"name":"admin_permissions_role_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"admin_users_roles_lnk","indexes":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"]},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"]},{"name":"admin_users_roles_lnk_uq","columns":["user_id","role_id"],"type":"unique"},{"name":"admin_users_roles_lnk_ofk","columns":["role_ord"]},{"name":"admin_users_roles_lnk_oifk","columns":["user_ord"]}],"foreignKeys":[{"name":"admin_users_roles_lnk_fk","columns":["user_id"],"referencedColumns":["id"],"referencedTable":"admin_users","onDelete":"CASCADE"},{"name":"admin_users_roles_lnk_ifk","columns":["role_id"],"referencedColumns":["id"],"referencedTable":"admin_roles","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"user_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"role_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"user_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_api_token_permissions_token_lnk","indexes":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"]},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"]},{"name":"strapi_api_token_permissions_token_lnk_uq","columns":["api_token_permission_id","api_token_id"],"type":"unique"},{"name":"strapi_api_token_permissions_token_lnk_oifk","columns":["api_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_api_token_permissions_token_lnk_fk","columns":["api_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_token_permissions","onDelete":"CASCADE"},{"name":"strapi_api_token_permissions_token_lnk_ifk","columns":["api_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_api_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"api_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"api_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]},{"name":"strapi_transfer_token_permissions_token_lnk","indexes":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"]},{"name":"strapi_transfer_token_permissions_token_lnk_uq","columns":["transfer_token_permission_id","transfer_token_id"],"type":"unique"},{"name":"strapi_transfer_token_permissions_token_lnk_oifk","columns":["transfer_token_permission_ord"]}],"foreignKeys":[{"name":"strapi_transfer_token_permissions_token_lnk_fk","columns":["transfer_token_permission_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_token_permissions","onDelete":"CASCADE"},{"name":"strapi_transfer_token_permissions_token_lnk_ifk","columns":["transfer_token_id"],"referencedColumns":["id"],"referencedTable":"strapi_transfer_tokens","onDelete":"CASCADE"}],"columns":[{"name":"id","type":"increments","args":[{"primary":true,"primaryKey":true}],"defaultTo":null,"notNullable":true,"unsigned":false},{"name":"transfer_token_permission_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_id","type":"integer","args":[],"defaultTo":null,"notNullable":false,"unsigned":true},{"name":"transfer_token_permission_ord","type":"double","args":[],"defaultTo":null,"notNullable":false,"unsigned":true}]}]}	2025-08-27	3876953cfa7981d54b5e2020812096a2567777982efd2331d3aeb477736c2564
\.


--
-- Data for Name: _strapi_history_versions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_history_versions (id, content_type, related_document_id, locale, status, data, schema, created_at, created_by_id) FROM stdin;
\.


--
-- Data for Name: _strapi_migrations; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_migrations (id, name, "time") FROM stdin;
\.


--
-- Data for Name: _strapi_migrations_internal; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_migrations_internal (id, name, "time") FROM stdin;
1	5.0.0-rename-identifiers-longer-than-max-length	2025-07-07
2	5.0.0-02-created-document-id	2025-07-07
3	5.0.0-03-created-locale	2025-07-07
4	5.0.0-04-created-published-at	2025-07-07
5	5.0.0-05-drop-slug-fields-index	2025-07-07
6	core::5.0.0-discard-drafts	2025-07-07
\.


--
-- Data for Name: _strapi_release_actions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_release_actions (id, document_id, type, content_type, entry_document_id, locale, is_entry_valid, created_at, updated_at, published_at, created_by_id, updated_by_id) FROM stdin;
\.


--
-- Data for Name: _strapi_release_actions_release_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_release_actions_release_lnk (id, release_action_id, release_id, release_action_ord) FROM stdin;
\.


--
-- Data for Name: _strapi_releases; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_releases (id, document_id, name, released_at, scheduled_at, timezone, status, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_transfer_token_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_transfer_token_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_transfer_token_permissions_token_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_transfer_token_permissions_token_lnk (id, transfer_token_permission_id, transfer_token_id, transfer_token_permission_ord) FROM stdin;
\.


--
-- Data for Name: _strapi_transfer_tokens; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_transfer_tokens (id, document_id, name, description, access_key, last_used_at, expires_at, lifespan, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
\.


--
-- Data for Name: _strapi_workflows; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_workflows (id, document_id, name, content_types, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_workflows_stage_required_to_publish_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_workflows_stage_required_to_publish_lnk (id, workflow_id, workflow_stage_id) FROM stdin;
\.


--
-- Data for Name: _strapi_workflows_stages; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_workflows_stages (id, document_id, name, color, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _strapi_workflows_stages_permissions_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_workflows_stages_permissions_lnk (id, workflow_stage_id, permission_id, permission_ord) FROM stdin;
\.


--
-- Data for Name: _strapi_workflows_stages_workflow_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._strapi_workflows_stages_workflow_lnk (id, workflow_stage_id, workflow_id, workflow_stage_ord) FROM stdin;
\.


--
-- Data for Name: _up_permissions; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._up_permissions (id, document_id, action, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	slwhj3ho2ltsd9xa32ialk6b	plugin::users-permissions.user.me	2025-07-07	2025-07-07	2025-07-07			
2	or433f1mo81f8kfvi50vt0r4	plugin::users-permissions.auth.changePassword	2025-07-07	2025-07-07	2025-07-07			
3	kygoo8m5rchqmqtywvqjttuq	plugin::users-permissions.auth.callback	2025-07-07	2025-07-07	2025-07-07			
4	n8nkm3n0kydbqmod40hz0b31	plugin::users-permissions.auth.connect	2025-07-07	2025-07-07	2025-07-07			
5	k564vuu3f9nifiz2u14s979u	plugin::users-permissions.auth.forgotPassword	2025-07-07	2025-07-07	2025-07-07			
6	n98pqecedmp3les2dxj5n1o1	plugin::users-permissions.auth.resetPassword	2025-07-07	2025-07-07	2025-07-07			
7	kw0ps8jnzb7lyaz5j0hac1u7	plugin::users-permissions.auth.register	2025-07-07	2025-07-07	2025-07-07			
8	devc8he08k8osp5sbu3o0jy3	plugin::users-permissions.auth.emailConfirmation	2025-07-07	2025-07-07	2025-07-07			
9	ujwue6vckjk55sc3jgy25uzq	plugin::users-permissions.auth.sendEmailConfirmation	2025-07-07	2025-07-07	2025-07-07			
10	b2uoobmp679runb45buil2ed	api::category.category.find	2025-07-09	2025-07-09	2025-07-09			
11	zvwvcea7bei6mm9cn1ig7no8	api::category.category.findOne	2025-07-09	2025-07-09	2025-07-09			
12	af8ruqxhewfjhq9r8h4gblkl	api::comment.comment.find	2025-07-09	2025-07-09	2025-07-09			
13	s2fhw4yaaree3n27tb4nake6	api::comment.comment.findOne	2025-07-09	2025-07-09	2025-07-09			
14	bq66g0mssx1behr5v16yhjnm	api::comment.comment.create	2025-07-09	2025-07-09	2025-07-09			
15	vh4fndo93dgfeaulxam6pd90	api::comment.comment.delete	2025-07-09	2025-07-09	2025-07-09			
16	w7vkdst5l1w80uwakq4zppg7	api::post.post.find	2025-07-09	2025-07-09	2025-07-09			
17	wxlksqpw66jaymjnpypyfvhb	api::post.post.findOne	2025-07-09	2025-07-09	2025-07-09			
\.


--
-- Data for Name: _up_permissions_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._up_permissions_role_lnk (id, permission_id, role_id, permission_ord) FROM stdin;
1	1	1	1.0
2	2	1	2.0
3	3	2	1.0
4	4	2	2.0
5	5	2	3.0
6	6	2	4.0
7	7	2	5.0
8	8	2	6.0
9	9	2	7.0
10	10	2	8.0
11	11	2	9.0
12	12	2	10.0
13	13	2	11.0
14	14	2	12.0
15	15	2	13.0
16	16	2	14.0
17	17	2	15.0
\.


--
-- Data for Name: _up_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._up_roles (id, document_id, name, description, type, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	un0h25hzug13xfq638lnt2sz	Authenticated	Default role given to authenticated user.	authenticated	2025-07-07	2025-07-07	2025-07-07			
2	c427n4up72uvwyw7zjz4vous	Public	Default role given to unauthenticated user.	public	2025-07-07	2025-07-09	2025-07-07			
\.


--
-- Data for Name: _up_users; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._up_users (id, document_id, username, email, provider, password, reset_password_token, confirmation_token, confirmed, blocked, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
1	zanyggnb1tnfskcrx2czodoe	tester	tasasdasddest123123asd@mail.ru	local	$2a$10$UcU/3irvZa/YgR2.fPaFvuojj94ODgH3bXblFxJaqyg31M6yjgXcy			1	0	2025-07-07	2025-07-07	2025-07-07	1	1	
\.


--
-- Data for Name: _up_users_role_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._up_users_role_lnk (id, user_id, role_id, user_ord) FROM stdin;
1	1	1	1.0
\.


--
-- Data for Name: _upload_folders; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._upload_folders (id, document_id, name, path_id, path, created_at, updated_at, published_at, created_by_id, updated_by_id, locale) FROM stdin;
\.


--
-- Data for Name: _upload_folders_parent_lnk; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public._upload_folders_parent_lnk (id, folder_id, inv_folder_id, folder_ord) FROM stdin;
\.


--
-- PostgreSQL database dump complete
--


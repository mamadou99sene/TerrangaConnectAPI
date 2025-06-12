--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: declaration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.declaration (
    id character varying(255) NOT NULL,
    date_publication timestamp(6) without time zone,
    demandeur_id character varying(255),
    description character varying(255),
    status smallint,
    titre character varying(255),
    CONSTRAINT declaration_status_check CHECK (((status >= 0) AND (status <= 1)))
);


ALTER TABLE public.declaration OWNER TO postgres;

--
-- Name: declaration_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.declaration_images (
    declaration_id character varying(255) NOT NULL,
    image_path character varying(255)
);


ALTER TABLE public.declaration_images OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: demande_donde_sang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demande_donde_sang (
    adresse character varying(255),
    classe smallint,
    rhesus smallint,
    id character varying(255) NOT NULL,
    CONSTRAINT demande_donde_sang_classe_check CHECK (((classe >= 0) AND (classe <= 3))),
    CONSTRAINT demande_donde_sang_rhesus_check CHECK (((rhesus >= 0) AND (rhesus <= 1)))
);


ALTER TABLE public.demande_donde_sang OWNER TO postgres;

--
-- Name: demandeur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.demandeur (
    adresse character varying(255),
    id character varying(255) NOT NULL
);


ALTER TABLE public.demandeur OWNER TO postgres;

--
-- Name: don; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don (
    id character varying(255) NOT NULL,
    date_publication timestamp(6) without time zone,
    declaration_id character varying(255),
    donateur_id character varying(255),
    type smallint,
    CONSTRAINT don_type_check CHECK (((type >= 0) AND (type <= 3)))
);


ALTER TABLE public.don OWNER TO postgres;

--
-- Name: don_espece; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don_espece (
    montant double precision NOT NULL,
    id character varying(255) NOT NULL
);


ALTER TABLE public.don_espece OWNER TO postgres;

--
-- Name: don_materiel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don_materiel (
    description character varying(255),
    titre character varying(255),
    id character varying(255) NOT NULL
);


ALTER TABLE public.don_materiel OWNER TO postgres;

--
-- Name: don_materiel_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don_materiel_images (
    don_id character varying(255) NOT NULL,
    image_path character varying(255)
);


ALTER TABLE public.don_materiel_images OWNER TO postgres;

--
-- Name: don_sang; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.don_sang (
    adresse_donnateur character varying(255),
    id character varying(255) NOT NULL
);


ALTER TABLE public.don_sang OWNER TO postgres;

--
-- Name: donnateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.donnateur (
    type character varying(255),
    id character varying(255) NOT NULL,
    CONSTRAINT donnateur_type_check CHECK (((type)::text = ANY (ARRAY[('PARTICULIER'::character varying)::text, ('PARTENAIRE'::character varying)::text])))
);


ALTER TABLE public.donnateur OWNER TO postgres;

--
-- Name: evenement; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.evenement (
    date_debut timestamp(6) without time zone,
    date_fin timestamp(6) without time zone,
    lieu character varying(255),
    type smallint,
    id character varying(255) NOT NULL,
    CONSTRAINT evenement_type_check CHECK (((type >= 0) AND (type <= 4)))
);


ALTER TABLE public.evenement OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: pret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pret (
    description character varying(255),
    duree integer NOT NULL,
    titre character varying(255),
    id character varying(255) NOT NULL
);


ALTER TABLE public.pret OWNER TO postgres;

--
-- Name: pret_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pret_images (
    pret_id character varying(255) NOT NULL,
    image_path character varying(255)
);


ALTER TABLE public.pret_images OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: urgence_sociale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.urgence_sociale (
    lieu character varying(255),
    montant_requis double precision NOT NULL,
    type smallint,
    id character varying(255) NOT NULL,
    CONSTRAINT urgence_sociale_type_check CHECK (((type >= 0) AND (type <= 2)))
);


ALTER TABLE public.urgence_sociale OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- Name: utilisateur; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur (
    id character varying(255) NOT NULL,
    email character varying(255),
    profile character varying(255),
    score double precision NOT NULL,
    telephone character varying(255),
    keycloak_id character varying(255)
);


ALTER TABLE public.utilisateur OWNER TO postgres;

--
-- Name: utilisateur_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.utilisateur_roles (
    utilisateur_id character varying(255) NOT NULL,
    roles character varying(255),
    CONSTRAINT utilisateur_roles_roles_check CHECK (((roles)::text = ANY (ARRAY[('USER'::character varying)::text, ('PARTENAIRE'::character varying)::text, ('MODERATEUR'::character varying)::text, ('ADMIN'::character varying)::text])))
);


ALTER TABLE public.utilisateur_roles OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
22b4e8c7-5d3c-4907-8870-41465eadc54d	\N	auth-cookie	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9fc25276-e893-474d-874a-76454099be2a	2	10	f	\N	\N
c3d93468-50bd-4259-bf7e-c2940a03116e	\N	auth-spnego	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9fc25276-e893-474d-874a-76454099be2a	3	20	f	\N	\N
28db9181-7d1e-43ea-a663-aa1d4e180ccf	\N	identity-provider-redirector	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9fc25276-e893-474d-874a-76454099be2a	2	25	f	\N	\N
354b2e10-474a-4e83-9bab-20b4a8dcc652	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9fc25276-e893-474d-874a-76454099be2a	2	30	t	640f5516-4e7f-4b7d-827d-5ac925267771	\N
9fbc1e0d-4db7-47d7-ac57-aabdc3c5b4ef	\N	auth-username-password-form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	640f5516-4e7f-4b7d-827d-5ac925267771	0	10	f	\N	\N
0abd4559-50c3-4d95-b17b-25c4abc20547	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	640f5516-4e7f-4b7d-827d-5ac925267771	1	20	t	0ada17c4-dac2-4a6e-a76d-32b2542c1c8b	\N
0dca11b3-ca35-47fb-9f58-282a347f2719	\N	conditional-user-configured	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	0ada17c4-dac2-4a6e-a76d-32b2542c1c8b	0	10	f	\N	\N
873ecce4-67e7-4853-a71d-5d2a28e6b4e6	\N	auth-otp-form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	0ada17c4-dac2-4a6e-a76d-32b2542c1c8b	0	20	f	\N	\N
96272eaa-6f1d-4d5b-85a3-13d2f2ea9792	\N	direct-grant-validate-username	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9c89314f-4411-427b-93ab-ceee7fea41a4	0	10	f	\N	\N
2f766a35-ab6b-4deb-8221-cd07ece99d0f	\N	direct-grant-validate-password	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9c89314f-4411-427b-93ab-ceee7fea41a4	0	20	f	\N	\N
f981ce0f-c67a-4d8a-b6e3-afb88de11e39	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9c89314f-4411-427b-93ab-ceee7fea41a4	1	30	t	4d479737-7594-45b4-9e61-f06bda3005f8	\N
749fb97a-d777-45fa-b135-adc21ddfdb42	\N	conditional-user-configured	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4d479737-7594-45b4-9e61-f06bda3005f8	0	10	f	\N	\N
f0543976-39d5-4edd-85be-2940ddc4753f	\N	direct-grant-validate-otp	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4d479737-7594-45b4-9e61-f06bda3005f8	0	20	f	\N	\N
160f2ee1-7a7b-4828-93f5-feeb0172e56e	\N	registration-page-form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	d3b9fe55-f1f7-44dd-888c-1ea8a738c685	0	10	t	fb452e23-6278-453f-8309-bf3b2322a688	\N
0c2cbc67-85a1-4dc0-8104-34bc3534febb	\N	registration-user-creation	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	fb452e23-6278-453f-8309-bf3b2322a688	0	20	f	\N	\N
89c7d013-0da8-40ab-9ad4-b2e74081fbc4	\N	registration-password-action	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	fb452e23-6278-453f-8309-bf3b2322a688	0	50	f	\N	\N
6673ccb2-a50a-4ddf-aec4-a1a8b7eb0a0b	\N	registration-recaptcha-action	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	fb452e23-6278-453f-8309-bf3b2322a688	3	60	f	\N	\N
db0a6bbf-5aff-4460-8f8a-8a0355dfe6dd	\N	registration-terms-and-conditions	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	fb452e23-6278-453f-8309-bf3b2322a688	3	70	f	\N	\N
8e57d746-ed0b-4b6a-ae14-e7c4b6ed10d2	\N	reset-credentials-choose-user	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	56c60703-9604-4c82-bc59-7b7c0c477d1e	0	10	f	\N	\N
48fbef01-cdab-4920-aadc-929d3b959766	\N	reset-credential-email	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	56c60703-9604-4c82-bc59-7b7c0c477d1e	0	20	f	\N	\N
9985bb71-673a-4113-830e-82855df45eba	\N	reset-password	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	56c60703-9604-4c82-bc59-7b7c0c477d1e	0	30	f	\N	\N
a934ad8c-8d85-4765-87b6-d63cb72bf43f	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	56c60703-9604-4c82-bc59-7b7c0c477d1e	1	40	t	038dfe71-d384-4b81-96a7-a15d9b8d0c15	\N
031d040c-d41a-4520-95d6-e532369c0715	\N	conditional-user-configured	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	038dfe71-d384-4b81-96a7-a15d9b8d0c15	0	10	f	\N	\N
a15b272e-e8d8-4dce-8c4b-1a3177148a55	\N	reset-otp	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	038dfe71-d384-4b81-96a7-a15d9b8d0c15	0	20	f	\N	\N
9a2f013c-3c46-4f65-a200-31ca8b8bd070	\N	client-secret	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ec3c96df-c14c-49af-8280-6bddfa4ce15a	2	10	f	\N	\N
35551570-1515-42e6-a843-0d258bdbb3e4	\N	client-jwt	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ec3c96df-c14c-49af-8280-6bddfa4ce15a	2	20	f	\N	\N
c5b58b9c-27c5-4e43-8365-03b3489275ae	\N	client-secret-jwt	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ec3c96df-c14c-49af-8280-6bddfa4ce15a	2	30	f	\N	\N
3dae3bcf-25a2-46cb-9060-e1ff90aaafa5	\N	client-x509	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ec3c96df-c14c-49af-8280-6bddfa4ce15a	2	40	f	\N	\N
e5c63c6c-6074-42d9-8337-bf41a10c4cf6	\N	idp-review-profile	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4ba36b95-9098-4b6e-b954-633350622108	0	10	f	\N	fe80510b-a2f9-4394-9d68-ee12a4495fd6
4187d31c-e4d3-4b4d-bdd8-5b75edd13ade	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4ba36b95-9098-4b6e-b954-633350622108	0	20	t	a2f2bdd5-5b97-452b-a7db-b67fbfc5b81a	\N
1c9c4239-982e-4b4a-aadd-a4cba458f993	\N	idp-create-user-if-unique	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	a2f2bdd5-5b97-452b-a7db-b67fbfc5b81a	2	10	f	\N	c479fa41-b92b-40ad-b225-47629ff9ebcf
af814411-2442-4b2f-b7cb-cd754139c28c	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	a2f2bdd5-5b97-452b-a7db-b67fbfc5b81a	2	20	t	f36627a1-7af3-4022-b02f-46eb6fbc63c7	\N
c6bf86ce-fe8a-45b2-b079-0c95fc57add2	\N	idp-confirm-link	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f36627a1-7af3-4022-b02f-46eb6fbc63c7	0	10	f	\N	\N
81964d91-5d18-4874-bfef-75c350b665bb	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f36627a1-7af3-4022-b02f-46eb6fbc63c7	0	20	t	ac9d5e36-166b-4fdf-b9a3-fd6355c23b75	\N
856e217d-c29b-420f-8a8c-fb4c239c9a86	\N	idp-email-verification	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ac9d5e36-166b-4fdf-b9a3-fd6355c23b75	2	10	f	\N	\N
1487d985-4d2b-4709-8c74-f39999e6fa28	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ac9d5e36-166b-4fdf-b9a3-fd6355c23b75	2	20	t	3f2999d2-53b5-4d2d-9b5b-f5e6c6bc58e8	\N
8ee324fb-0eb3-4246-8bf0-bdda2f82aa93	\N	idp-username-password-form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	3f2999d2-53b5-4d2d-9b5b-f5e6c6bc58e8	0	10	f	\N	\N
dabea7bf-f56e-48f4-8668-0c630438a095	\N	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	3f2999d2-53b5-4d2d-9b5b-f5e6c6bc58e8	1	20	t	31fff354-5e92-4d51-9ead-62fd89c732d8	\N
1845216c-857b-4f49-acc4-deca020524c1	\N	conditional-user-configured	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	31fff354-5e92-4d51-9ead-62fd89c732d8	0	10	f	\N	\N
d3379d5f-7bfc-44b4-87a5-86dc39551fa3	\N	auth-otp-form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	31fff354-5e92-4d51-9ead-62fd89c732d8	0	20	f	\N	\N
a816a6b2-414f-496a-aaec-38c43c30c200	\N	http-basic-authenticator	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	3dbf9dd0-14a0-46de-9882-1ae11e768b5a	0	10	f	\N	\N
72421f6b-f74c-4fb9-a734-af82b69c2454	\N	docker-http-basic-authenticator	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ddd28839-18a6-4d86-bbc8-8125deb64305	0	10	f	\N	\N
8d0eb93d-a4a2-4d2f-aa9c-869baa4422b5	\N	auth-cookie	782a628f-1571-41ed-8beb-5caf97452730	9cbe321c-e26c-4924-be04-af89bba52cf6	2	10	f	\N	\N
a0816a5e-48d3-45d4-9a9d-608fe52e97d5	\N	auth-spnego	782a628f-1571-41ed-8beb-5caf97452730	9cbe321c-e26c-4924-be04-af89bba52cf6	3	20	f	\N	\N
8eca59a3-3455-4dd0-abc3-2ddbad2a5462	\N	identity-provider-redirector	782a628f-1571-41ed-8beb-5caf97452730	9cbe321c-e26c-4924-be04-af89bba52cf6	2	25	f	\N	\N
315a74fd-c728-4953-8ee9-c47975b77b9a	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	9cbe321c-e26c-4924-be04-af89bba52cf6	2	30	t	5b6a8ad6-4716-4848-9b3a-38232a43f1b7	\N
13542c02-8771-414f-94fc-1f97cd89d2b5	\N	auth-username-password-form	782a628f-1571-41ed-8beb-5caf97452730	5b6a8ad6-4716-4848-9b3a-38232a43f1b7	0	10	f	\N	\N
97d00e61-f1df-459e-bcf6-0314516202e5	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	5b6a8ad6-4716-4848-9b3a-38232a43f1b7	1	20	t	eb84a23e-94b3-4dcd-870e-fa824b9aa06f	\N
9f9c7888-cffe-4d5e-a024-b2b8fef9b6b2	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	eb84a23e-94b3-4dcd-870e-fa824b9aa06f	0	10	f	\N	\N
df613723-38b6-460c-b30c-755f68c79370	\N	auth-otp-form	782a628f-1571-41ed-8beb-5caf97452730	eb84a23e-94b3-4dcd-870e-fa824b9aa06f	0	20	f	\N	\N
67fc9b82-d9d5-4ad7-8b81-2ee38f50e3ad	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	9cbe321c-e26c-4924-be04-af89bba52cf6	2	26	t	71b9d428-5260-451f-8d6d-d942c7e70f5f	\N
3f20b41c-b8cb-4e4f-98db-b5b2ac79f067	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	71b9d428-5260-451f-8d6d-d942c7e70f5f	1	10	t	351bb257-ae77-4bfe-9553-b3f1b7c92fee	\N
5b8b451e-79ed-4196-9b25-0b66de62aaf5	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	351bb257-ae77-4bfe-9553-b3f1b7c92fee	0	10	f	\N	\N
8e240955-2dc0-4749-8a9e-1a6943da92f3	\N	organization	782a628f-1571-41ed-8beb-5caf97452730	351bb257-ae77-4bfe-9553-b3f1b7c92fee	2	20	f	\N	\N
e87c6c35-bf49-483b-87f0-34193b24ecb9	\N	direct-grant-validate-username	782a628f-1571-41ed-8beb-5caf97452730	7b12c54c-a32c-42fe-907c-a0b6aba902fc	0	10	f	\N	\N
8b74f013-dae3-4fd5-a9cd-70a4b3dfe989	\N	direct-grant-validate-password	782a628f-1571-41ed-8beb-5caf97452730	7b12c54c-a32c-42fe-907c-a0b6aba902fc	0	20	f	\N	\N
174e3115-fb2f-49cc-a624-17bd2c2eef22	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	7b12c54c-a32c-42fe-907c-a0b6aba902fc	1	30	t	b7b39ed1-c62e-42ae-aa55-6e9c882d1681	\N
c619ab41-42dd-414c-8cdd-3b2f2916cb37	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	b7b39ed1-c62e-42ae-aa55-6e9c882d1681	0	10	f	\N	\N
d82a5527-659e-40fe-9cd0-4819e2510a50	\N	direct-grant-validate-otp	782a628f-1571-41ed-8beb-5caf97452730	b7b39ed1-c62e-42ae-aa55-6e9c882d1681	0	20	f	\N	\N
2eb29338-5709-426d-8971-ab10fab808bc	\N	registration-page-form	782a628f-1571-41ed-8beb-5caf97452730	d2e39f9d-474f-432c-81d2-13a40459d526	0	10	t	739d4b66-09f5-4590-a85e-b8e3d0343df2	\N
e2e6d05d-6537-4d4f-9ac4-2ac29ebf3653	\N	registration-user-creation	782a628f-1571-41ed-8beb-5caf97452730	739d4b66-09f5-4590-a85e-b8e3d0343df2	0	20	f	\N	\N
e6dab626-8fcf-4cae-8b2b-64eaaf5aae7b	\N	registration-password-action	782a628f-1571-41ed-8beb-5caf97452730	739d4b66-09f5-4590-a85e-b8e3d0343df2	0	50	f	\N	\N
8235b356-3634-4f00-8d9e-36630fd88c80	\N	registration-recaptcha-action	782a628f-1571-41ed-8beb-5caf97452730	739d4b66-09f5-4590-a85e-b8e3d0343df2	3	60	f	\N	\N
26b64e04-7bd4-4852-8750-9bf2a2d85a4f	\N	registration-terms-and-conditions	782a628f-1571-41ed-8beb-5caf97452730	739d4b66-09f5-4590-a85e-b8e3d0343df2	3	70	f	\N	\N
5e1c6383-771d-4239-ba4a-95fe864e6622	\N	reset-credentials-choose-user	782a628f-1571-41ed-8beb-5caf97452730	7c44cf59-60b1-4d48-b436-0a37edc07f9a	0	10	f	\N	\N
7d73813b-fdf3-44dd-9518-cb6a3d1d2987	\N	reset-credential-email	782a628f-1571-41ed-8beb-5caf97452730	7c44cf59-60b1-4d48-b436-0a37edc07f9a	0	20	f	\N	\N
076f33f6-1375-464e-9679-8a63a00da56d	\N	reset-password	782a628f-1571-41ed-8beb-5caf97452730	7c44cf59-60b1-4d48-b436-0a37edc07f9a	0	30	f	\N	\N
29026902-32b7-4179-a73f-5b2be962bd5f	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	7c44cf59-60b1-4d48-b436-0a37edc07f9a	1	40	t	d8e24501-ab8e-401d-b7a0-06c8ca7e964f	\N
1f2d826e-a516-456f-9aab-bff82157f323	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	d8e24501-ab8e-401d-b7a0-06c8ca7e964f	0	10	f	\N	\N
54748c59-fee1-4ea2-9b71-1461b03889ee	\N	reset-otp	782a628f-1571-41ed-8beb-5caf97452730	d8e24501-ab8e-401d-b7a0-06c8ca7e964f	0	20	f	\N	\N
608835ec-8401-4e82-a376-0279de308515	\N	client-secret	782a628f-1571-41ed-8beb-5caf97452730	beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	2	10	f	\N	\N
83e646b4-e01a-4d7c-a0ea-427a3671b4ce	\N	client-jwt	782a628f-1571-41ed-8beb-5caf97452730	beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	2	20	f	\N	\N
63d4ce06-922f-4d08-86fe-dde6d846bad5	\N	client-secret-jwt	782a628f-1571-41ed-8beb-5caf97452730	beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	2	30	f	\N	\N
ec17102d-cfd7-4635-abd4-8ca37cf9860a	\N	client-x509	782a628f-1571-41ed-8beb-5caf97452730	beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	2	40	f	\N	\N
eebf1fca-4d82-4a8f-9531-9e28475213f7	\N	idp-review-profile	782a628f-1571-41ed-8beb-5caf97452730	2afe6009-5ee4-400c-9ac8-00f0cd1276c7	0	10	f	\N	9ae1cb0e-8575-40b1-970e-2a92b0ecfc5a
9f1707b1-56df-4f3a-b711-28dc4cfd020c	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	2afe6009-5ee4-400c-9ac8-00f0cd1276c7	0	20	t	cd0a06de-52ae-488d-bff7-bfe8a18c5ef3	\N
1c8d6ae3-3386-4489-a541-b32b6e820be0	\N	idp-create-user-if-unique	782a628f-1571-41ed-8beb-5caf97452730	cd0a06de-52ae-488d-bff7-bfe8a18c5ef3	2	10	f	\N	3cbed36c-bce0-466d-bcc4-cf4adceed245
07e57179-34c3-4df4-8c6e-bf34c0db296b	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	cd0a06de-52ae-488d-bff7-bfe8a18c5ef3	2	20	t	84c3b995-3c4c-4a27-9dfa-c65ade098e29	\N
a6321a1a-b75f-44eb-98e2-bc4e4f3572e7	\N	idp-confirm-link	782a628f-1571-41ed-8beb-5caf97452730	84c3b995-3c4c-4a27-9dfa-c65ade098e29	0	10	f	\N	\N
c1538365-0c93-4a94-8185-66094720819b	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	84c3b995-3c4c-4a27-9dfa-c65ade098e29	0	20	t	40700fbb-24e3-4aae-a80f-bf7f0c0dd3ab	\N
bc1f179b-d9b8-47d9-a4bf-6c38c9d7447b	\N	idp-email-verification	782a628f-1571-41ed-8beb-5caf97452730	40700fbb-24e3-4aae-a80f-bf7f0c0dd3ab	2	10	f	\N	\N
3aab60fd-3f7b-4758-843e-5ae09be46efd	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	40700fbb-24e3-4aae-a80f-bf7f0c0dd3ab	2	20	t	d82caf44-2b98-4c00-84db-5871f23c988f	\N
422d39a5-fc3a-4e35-ae04-0797d6f183d5	\N	idp-username-password-form	782a628f-1571-41ed-8beb-5caf97452730	d82caf44-2b98-4c00-84db-5871f23c988f	0	10	f	\N	\N
d104175e-5a2e-4f83-89be-0b45b3a050a7	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	d82caf44-2b98-4c00-84db-5871f23c988f	1	20	t	926ce1ee-21f3-45b9-8be0-5fd4830b511d	\N
b4a803ba-4270-4968-ac4a-2ef0783901fd	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	926ce1ee-21f3-45b9-8be0-5fd4830b511d	0	10	f	\N	\N
4bbd12e2-34b0-4f08-bf32-c6c32df2fb87	\N	auth-otp-form	782a628f-1571-41ed-8beb-5caf97452730	926ce1ee-21f3-45b9-8be0-5fd4830b511d	0	20	f	\N	\N
71bf6132-0d8b-49fb-9d66-cfc0d86e78c9	\N	\N	782a628f-1571-41ed-8beb-5caf97452730	2afe6009-5ee4-400c-9ac8-00f0cd1276c7	1	50	t	991e2822-56fe-410c-a487-33f3fa1ce027	\N
86479741-d2eb-4aec-89a1-d648d1607960	\N	conditional-user-configured	782a628f-1571-41ed-8beb-5caf97452730	991e2822-56fe-410c-a487-33f3fa1ce027	0	10	f	\N	\N
4594103a-80c5-4d76-b611-60e0a95c4a56	\N	idp-add-organization-member	782a628f-1571-41ed-8beb-5caf97452730	991e2822-56fe-410c-a487-33f3fa1ce027	0	20	f	\N	\N
e858723e-28ba-4808-a747-a3c87ebd8fd2	\N	http-basic-authenticator	782a628f-1571-41ed-8beb-5caf97452730	9b7fe3d5-d77d-477f-9147-a0cf529d3446	0	10	f	\N	\N
995fa501-3011-4260-bcb5-efeaac24441b	\N	docker-http-basic-authenticator	782a628f-1571-41ed-8beb-5caf97452730	090a99a9-3211-4e1b-8947-73bd07d35b54	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
9fc25276-e893-474d-874a-76454099be2a	browser	Browser based authentication	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
640f5516-4e7f-4b7d-827d-5ac925267771	forms	Username, password, otp and other auth forms.	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
0ada17c4-dac2-4a6e-a76d-32b2542c1c8b	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
9c89314f-4411-427b-93ab-ceee7fea41a4	direct grant	OpenID Connect Resource Owner Grant	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
4d479737-7594-45b4-9e61-f06bda3005f8	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
d3b9fe55-f1f7-44dd-888c-1ea8a738c685	registration	Registration flow	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
fb452e23-6278-453f-8309-bf3b2322a688	registration form	Registration form	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	form-flow	f	t
56c60703-9604-4c82-bc59-7b7c0c477d1e	reset credentials	Reset credentials for a user if they forgot their password or something	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
038dfe71-d384-4b81-96a7-a15d9b8d0c15	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
ec3c96df-c14c-49af-8280-6bddfa4ce15a	clients	Base authentication for clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	client-flow	t	t
4ba36b95-9098-4b6e-b954-633350622108	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
a2f2bdd5-5b97-452b-a7db-b67fbfc5b81a	User creation or linking	Flow for the existing/non-existing user alternatives	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
f36627a1-7af3-4022-b02f-46eb6fbc63c7	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
ac9d5e36-166b-4fdf-b9a3-fd6355c23b75	Account verification options	Method with which to verity the existing account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
3f2999d2-53b5-4d2d-9b5b-f5e6c6bc58e8	Verify Existing Account by Re-authentication	Reauthentication of existing account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
31fff354-5e92-4d51-9ead-62fd89c732d8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	f	t
3dbf9dd0-14a0-46de-9882-1ae11e768b5a	saml ecp	SAML ECP Profile Authentication Flow	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
ddd28839-18a6-4d86-bbc8-8125deb64305	docker auth	Used by Docker clients to authenticate against the IDP	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	basic-flow	t	t
9cbe321c-e26c-4924-be04-af89bba52cf6	browser	Browser based authentication	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
5b6a8ad6-4716-4848-9b3a-38232a43f1b7	forms	Username, password, otp and other auth forms.	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
eb84a23e-94b3-4dcd-870e-fa824b9aa06f	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
71b9d428-5260-451f-8d6d-d942c7e70f5f	Organization	\N	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
351bb257-ae77-4bfe-9553-b3f1b7c92fee	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
7b12c54c-a32c-42fe-907c-a0b6aba902fc	direct grant	OpenID Connect Resource Owner Grant	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
b7b39ed1-c62e-42ae-aa55-6e9c882d1681	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
d2e39f9d-474f-432c-81d2-13a40459d526	registration	Registration flow	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
739d4b66-09f5-4590-a85e-b8e3d0343df2	registration form	Registration form	782a628f-1571-41ed-8beb-5caf97452730	form-flow	f	t
7c44cf59-60b1-4d48-b436-0a37edc07f9a	reset credentials	Reset credentials for a user if they forgot their password or something	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
d8e24501-ab8e-401d-b7a0-06c8ca7e964f	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	clients	Base authentication for clients	782a628f-1571-41ed-8beb-5caf97452730	client-flow	t	t
2afe6009-5ee4-400c-9ac8-00f0cd1276c7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
cd0a06de-52ae-488d-bff7-bfe8a18c5ef3	User creation or linking	Flow for the existing/non-existing user alternatives	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
84c3b995-3c4c-4a27-9dfa-c65ade098e29	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
40700fbb-24e3-4aae-a80f-bf7f0c0dd3ab	Account verification options	Method with which to verity the existing account	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
d82caf44-2b98-4c00-84db-5871f23c988f	Verify Existing Account by Re-authentication	Reauthentication of existing account	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
926ce1ee-21f3-45b9-8be0-5fd4830b511d	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
991e2822-56fe-410c-a487-33f3fa1ce027	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	f	t
9b7fe3d5-d77d-477f-9147-a0cf529d3446	saml ecp	SAML ECP Profile Authentication Flow	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
090a99a9-3211-4e1b-8947-73bd07d35b54	docker auth	Used by Docker clients to authenticate against the IDP	782a628f-1571-41ed-8beb-5caf97452730	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
fe80510b-a2f9-4394-9d68-ee12a4495fd6	review profile config	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf
c479fa41-b92b-40ad-b225-47629ff9ebcf	create unique user config	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf
9ae1cb0e-8575-40b1-970e-2a92b0ecfc5a	review profile config	782a628f-1571-41ed-8beb-5caf97452730
3cbed36c-bce0-466d-bcc4-cf4adceed245	create unique user config	782a628f-1571-41ed-8beb-5caf97452730
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
c479fa41-b92b-40ad-b225-47629ff9ebcf	false	require.password.update.after.registration
fe80510b-a2f9-4394-9d68-ee12a4495fd6	missing	update.profile.on.first.login
3cbed36c-bce0-466d-bcc4-cf4adceed245	false	require.password.update.after.registration
9ae1cb0e-8575-40b1-970e-2a92b0ecfc5a	missing	update.profile.on.first.login
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	f	master-realm	0	f	\N	\N	t	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e0217878-83bc-476b-bb1e-e4da9707c785	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	t	f	broker	0	f	\N	\N	t	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
9d7bd522-e633-4aa9-8492-8e600fc28621	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	t	t	admin-cli	0	t	\N	\N	f	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
142a2b85-9f20-4618-82a3-f86fa2d7276b	t	f	teranga_realm-realm	0	f	\N	\N	t	\N	f	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	0	f	f	teranga_realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
c98187f5-233e-47df-990a-c1213d8fc7bf	t	f	realm-management	0	f	\N	\N	t	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
a333915a-1b01-4ca0-9941-81f18ca387d9	t	f	account	0	t	\N	/realms/teranga_realm/account/	f	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	t	f	account-console	0	t	\N	/realms/teranga_realm/account/	f	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	t	f	broker	0	f	\N	\N	t	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
2793ce4a-5ecb-4800-9476-072b62529f6f	t	t	security-admin-console	0	t	\N	/admin/teranga_realm/console/	f	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	t	t	admin-cli	0	t	\N	\N	f	\N	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	t	t	service-user	0	f	314xnhESpgVm1WSjohUbj2z7pGlFmQBI		f	http://localhost:8090	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret	http://localhost:8090		\N	t	f	t	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	t	t	teranga-admin	0	t	\N		f		f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	t	t	service-social	0	f	BPbZrOEsHnee5IiF6L0k6bWzwEnkVHSL		f	http://localhost:8081	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret	http://localhost:8081		\N	t	f	t	f
c214ed28-8adc-49f7-881a-4f8989ffb487	t	t	service-intervention	0	f	YMLkKUDJRcyQwObGAXUcuRqvw5OXdifH		f	http://localhost:8083	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret	http://localhost:8083		\N	t	f	t	f
5adbd09e-054c-40bd-bd53-f90f69def82d	t	t	service-assistance	0	f	TIbonRkt4Ndc3WtJGMpRLxgCqwhjaYAA		f	http://localhost:8084	f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret	http://localhost:8084		\N	t	f	t	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	t	t	teranga_mobile	0	t	\N		f		f	782a628f-1571-41ed-8beb-5caf97452730	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
e0217878-83bc-476b-bb1e-e4da9707c785	post.logout.redirect.uris	+
1e2b4826-d794-4029-869b-ca5b7543cd0c	post.logout.redirect.uris	+
1e2b4826-d794-4029-869b-ca5b7543cd0c	pkce.code.challenge.method	S256
9d7bd522-e633-4aa9-8492-8e600fc28621	post.logout.redirect.uris	+
9d7bd522-e633-4aa9-8492-8e600fc28621	pkce.code.challenge.method	S256
9d7bd522-e633-4aa9-8492-8e600fc28621	client.use.lightweight.access.token.enabled	true
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	client.use.lightweight.access.token.enabled	true
a333915a-1b01-4ca0-9941-81f18ca387d9	post.logout.redirect.uris	+
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	post.logout.redirect.uris	+
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	pkce.code.challenge.method	S256
2793ce4a-5ecb-4800-9476-072b62529f6f	post.logout.redirect.uris	+
2793ce4a-5ecb-4800-9476-072b62529f6f	pkce.code.challenge.method	S256
2793ce4a-5ecb-4800-9476-072b62529f6f	client.use.lightweight.access.token.enabled	true
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	client.use.lightweight.access.token.enabled	true
3b69e458-b218-41d8-88f4-e35fbd7c637b	oauth2.device.authorization.grant.enabled	false
3b69e458-b218-41d8-88f4-e35fbd7c637b	oidc.ciba.grant.enabled	false
3b69e458-b218-41d8-88f4-e35fbd7c637b	backchannel.logout.session.required	true
3b69e458-b218-41d8-88f4-e35fbd7c637b	backchannel.logout.revoke.offline.tokens	false
3b69e458-b218-41d8-88f4-e35fbd7c637b	realm_client	false
3b69e458-b218-41d8-88f4-e35fbd7c637b	display.on.consent.screen	false
3b69e458-b218-41d8-88f4-e35fbd7c637b	client.secret.creation.time	1741606611
0f8b949c-dea0-4092-a532-8aba3a67b8dd	client.secret.creation.time	1741871164
0f8b949c-dea0-4092-a532-8aba3a67b8dd	oauth2.device.authorization.grant.enabled	false
0f8b949c-dea0-4092-a532-8aba3a67b8dd	oidc.ciba.grant.enabled	false
0f8b949c-dea0-4092-a532-8aba3a67b8dd	backchannel.logout.session.required	true
0f8b949c-dea0-4092-a532-8aba3a67b8dd	backchannel.logout.revoke.offline.tokens	false
0f8b949c-dea0-4092-a532-8aba3a67b8dd	realm_client	false
0f8b949c-dea0-4092-a532-8aba3a67b8dd	display.on.consent.screen	false
c214ed28-8adc-49f7-881a-4f8989ffb487	client.secret.creation.time	1741871238
c214ed28-8adc-49f7-881a-4f8989ffb487	oauth2.device.authorization.grant.enabled	false
c214ed28-8adc-49f7-881a-4f8989ffb487	oidc.ciba.grant.enabled	false
c214ed28-8adc-49f7-881a-4f8989ffb487	backchannel.logout.session.required	true
c214ed28-8adc-49f7-881a-4f8989ffb487	backchannel.logout.revoke.offline.tokens	false
c214ed28-8adc-49f7-881a-4f8989ffb487	realm_client	false
c214ed28-8adc-49f7-881a-4f8989ffb487	display.on.consent.screen	false
5adbd09e-054c-40bd-bd53-f90f69def82d	client.secret.creation.time	1741871320
5adbd09e-054c-40bd-bd53-f90f69def82d	oauth2.device.authorization.grant.enabled	false
5adbd09e-054c-40bd-bd53-f90f69def82d	oidc.ciba.grant.enabled	false
5adbd09e-054c-40bd-bd53-f90f69def82d	backchannel.logout.session.required	true
5adbd09e-054c-40bd-bd53-f90f69def82d	backchannel.logout.revoke.offline.tokens	false
5adbd09e-054c-40bd-bd53-f90f69def82d	realm_client	false
5adbd09e-054c-40bd-bd53-f90f69def82d	display.on.consent.screen	false
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	client.secret.creation.time	1741871420
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	oauth2.device.authorization.grant.enabled	false
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	oidc.ciba.grant.enabled	false
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	backchannel.logout.session.required	true
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	backchannel.logout.revoke.offline.tokens	false
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	realm_client	false
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	display.on.consent.screen	false
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	oauth2.device.authorization.grant.enabled	false
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	oidc.ciba.grant.enabled	false
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	backchannel.logout.session.required	true
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	backchannel.logout.revoke.offline.tokens	false
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	realm_client	false
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	display.on.consent.screen	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	offline_access	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect built-in scope: offline_access	openid-connect
af020923-9a0e-4d3e-91b6-efcdf16cb6bf	role_list	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	SAML role list	saml
8d3925fe-94e4-4d0a-9ea3-f3b3f001ffbb	saml_organization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	Organization Membership	saml
52a04847-6d6d-4f02-8f18-bc83483dade8	profile	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect built-in scope: profile	openid-connect
7ba3d400-2fe4-4ffe-8959-49129ff8ff92	email	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect built-in scope: email	openid-connect
6f2162fa-eb28-4c2d-be8a-5672026f848d	address	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect built-in scope: address	openid-connect
1a19eecb-1a7c-455f-a08d-64d9755e5a5e	phone	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect built-in scope: phone	openid-connect
2e9927c6-16b3-4e92-8f4d-6121cb97c6df	roles	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect scope for add user roles to the access token	openid-connect
4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	web-origins	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect scope for add allowed web origins to the access token	openid-connect
a989dadc-5d7e-4058-9272-33faeafb49b7	microprofile-jwt	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	Microprofile - JWT built-in scope	openid-connect
4ee44bac-20d8-4734-81f2-9a8108086b4d	acr	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
67a6b883-b10b-43ad-85fc-25c6003a31cc	basic	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	OpenID Connect scope for add all basic claims to the token	openid-connect
aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	organization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	Additional claims about the organization a subject belongs to	openid-connect
53be55b0-38f9-44b7-8090-9ff42c74f389	offline_access	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect built-in scope: offline_access	openid-connect
e1ab76f5-3cb7-4b26-80b0-c091e1c1652a	role_list	782a628f-1571-41ed-8beb-5caf97452730	SAML role list	saml
1640d91f-0ebc-40a4-b254-3234a0f41478	saml_organization	782a628f-1571-41ed-8beb-5caf97452730	Organization Membership	saml
301d59fa-0c3b-47bf-af84-dfa38440c6e2	profile	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect built-in scope: profile	openid-connect
591043e6-53cb-49e0-8a27-342d20ddd65d	email	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect built-in scope: email	openid-connect
59e9840e-606b-4310-87c5-3a1a4caeb1bc	address	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect built-in scope: address	openid-connect
cc410a9a-c9d7-479a-a6f2-388b65d8a198	phone	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect built-in scope: phone	openid-connect
18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	roles	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect scope for add user roles to the access token	openid-connect
5fe49fc5-ac60-4d59-b369-9bc2384649ae	web-origins	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect scope for add allowed web origins to the access token	openid-connect
9d34a5e9-e1be-4639-8ee4-ced4d108f609	microprofile-jwt	782a628f-1571-41ed-8beb-5caf97452730	Microprofile - JWT built-in scope	openid-connect
aeaff1ce-9975-4a7f-b612-4e332d6cfada	acr	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
b32cd6b8-7a19-4c94-beb6-80bb25618ee3	basic	782a628f-1571-41ed-8beb-5caf97452730	OpenID Connect scope for add all basic claims to the token	openid-connect
e875fd32-23d1-4433-aa2e-15bd8bf8c608	organization	782a628f-1571-41ed-8beb-5caf97452730	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	true	display.on.consent.screen
ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	${offlineAccessScopeConsentText}	consent.screen.text
af020923-9a0e-4d3e-91b6-efcdf16cb6bf	true	display.on.consent.screen
af020923-9a0e-4d3e-91b6-efcdf16cb6bf	${samlRoleListScopeConsentText}	consent.screen.text
8d3925fe-94e4-4d0a-9ea3-f3b3f001ffbb	false	display.on.consent.screen
52a04847-6d6d-4f02-8f18-bc83483dade8	true	display.on.consent.screen
52a04847-6d6d-4f02-8f18-bc83483dade8	${profileScopeConsentText}	consent.screen.text
52a04847-6d6d-4f02-8f18-bc83483dade8	true	include.in.token.scope
7ba3d400-2fe4-4ffe-8959-49129ff8ff92	true	display.on.consent.screen
7ba3d400-2fe4-4ffe-8959-49129ff8ff92	${emailScopeConsentText}	consent.screen.text
7ba3d400-2fe4-4ffe-8959-49129ff8ff92	true	include.in.token.scope
6f2162fa-eb28-4c2d-be8a-5672026f848d	true	display.on.consent.screen
6f2162fa-eb28-4c2d-be8a-5672026f848d	${addressScopeConsentText}	consent.screen.text
6f2162fa-eb28-4c2d-be8a-5672026f848d	true	include.in.token.scope
1a19eecb-1a7c-455f-a08d-64d9755e5a5e	true	display.on.consent.screen
1a19eecb-1a7c-455f-a08d-64d9755e5a5e	${phoneScopeConsentText}	consent.screen.text
1a19eecb-1a7c-455f-a08d-64d9755e5a5e	true	include.in.token.scope
2e9927c6-16b3-4e92-8f4d-6121cb97c6df	true	display.on.consent.screen
2e9927c6-16b3-4e92-8f4d-6121cb97c6df	${rolesScopeConsentText}	consent.screen.text
2e9927c6-16b3-4e92-8f4d-6121cb97c6df	false	include.in.token.scope
4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	false	display.on.consent.screen
4433cd49-d7f4-441c-b84a-fdd5e4f2ac83		consent.screen.text
4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	false	include.in.token.scope
a989dadc-5d7e-4058-9272-33faeafb49b7	false	display.on.consent.screen
a989dadc-5d7e-4058-9272-33faeafb49b7	true	include.in.token.scope
4ee44bac-20d8-4734-81f2-9a8108086b4d	false	display.on.consent.screen
4ee44bac-20d8-4734-81f2-9a8108086b4d	false	include.in.token.scope
67a6b883-b10b-43ad-85fc-25c6003a31cc	false	display.on.consent.screen
67a6b883-b10b-43ad-85fc-25c6003a31cc	false	include.in.token.scope
aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	true	display.on.consent.screen
aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	${organizationScopeConsentText}	consent.screen.text
aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	true	include.in.token.scope
53be55b0-38f9-44b7-8090-9ff42c74f389	true	display.on.consent.screen
53be55b0-38f9-44b7-8090-9ff42c74f389	${offlineAccessScopeConsentText}	consent.screen.text
e1ab76f5-3cb7-4b26-80b0-c091e1c1652a	true	display.on.consent.screen
e1ab76f5-3cb7-4b26-80b0-c091e1c1652a	${samlRoleListScopeConsentText}	consent.screen.text
1640d91f-0ebc-40a4-b254-3234a0f41478	false	display.on.consent.screen
301d59fa-0c3b-47bf-af84-dfa38440c6e2	true	display.on.consent.screen
301d59fa-0c3b-47bf-af84-dfa38440c6e2	${profileScopeConsentText}	consent.screen.text
301d59fa-0c3b-47bf-af84-dfa38440c6e2	true	include.in.token.scope
591043e6-53cb-49e0-8a27-342d20ddd65d	true	display.on.consent.screen
591043e6-53cb-49e0-8a27-342d20ddd65d	${emailScopeConsentText}	consent.screen.text
591043e6-53cb-49e0-8a27-342d20ddd65d	true	include.in.token.scope
59e9840e-606b-4310-87c5-3a1a4caeb1bc	true	display.on.consent.screen
59e9840e-606b-4310-87c5-3a1a4caeb1bc	${addressScopeConsentText}	consent.screen.text
59e9840e-606b-4310-87c5-3a1a4caeb1bc	true	include.in.token.scope
cc410a9a-c9d7-479a-a6f2-388b65d8a198	true	display.on.consent.screen
cc410a9a-c9d7-479a-a6f2-388b65d8a198	${phoneScopeConsentText}	consent.screen.text
cc410a9a-c9d7-479a-a6f2-388b65d8a198	true	include.in.token.scope
18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	true	display.on.consent.screen
18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	${rolesScopeConsentText}	consent.screen.text
18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	false	include.in.token.scope
5fe49fc5-ac60-4d59-b369-9bc2384649ae	false	display.on.consent.screen
5fe49fc5-ac60-4d59-b369-9bc2384649ae		consent.screen.text
5fe49fc5-ac60-4d59-b369-9bc2384649ae	false	include.in.token.scope
9d34a5e9-e1be-4639-8ee4-ced4d108f609	false	display.on.consent.screen
9d34a5e9-e1be-4639-8ee4-ced4d108f609	true	include.in.token.scope
aeaff1ce-9975-4a7f-b612-4e332d6cfada	false	display.on.consent.screen
aeaff1ce-9975-4a7f-b612-4e332d6cfada	false	include.in.token.scope
b32cd6b8-7a19-4c94-beb6-80bb25618ee3	false	display.on.consent.screen
b32cd6b8-7a19-4c94-beb6-80bb25618ee3	false	include.in.token.scope
e875fd32-23d1-4433-aa2e-15bd8bf8c608	true	display.on.consent.screen
e875fd32-23d1-4433-aa2e-15bd8bf8c608	${organizationScopeConsentText}	consent.screen.text
e875fd32-23d1-4433-aa2e-15bd8bf8c608	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e0217878-83bc-476b-bb1e-e4da9707c785	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
e0217878-83bc-476b-bb1e-e4da9707c785	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
e0217878-83bc-476b-bb1e-e4da9707c785	52a04847-6d6d-4f02-8f18-bc83483dade8	t
e0217878-83bc-476b-bb1e-e4da9707c785	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
e0217878-83bc-476b-bb1e-e4da9707c785	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
e0217878-83bc-476b-bb1e-e4da9707c785	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
e0217878-83bc-476b-bb1e-e4da9707c785	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
e0217878-83bc-476b-bb1e-e4da9707c785	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
e0217878-83bc-476b-bb1e-e4da9707c785	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
e0217878-83bc-476b-bb1e-e4da9707c785	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
e0217878-83bc-476b-bb1e-e4da9707c785	a989dadc-5d7e-4058-9272-33faeafb49b7	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	52a04847-6d6d-4f02-8f18-bc83483dade8	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
1e2b4826-d794-4029-869b-ca5b7543cd0c	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
1e2b4826-d794-4029-869b-ca5b7543cd0c	a989dadc-5d7e-4058-9272-33faeafb49b7	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	52a04847-6d6d-4f02-8f18-bc83483dade8	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
2ac8e19f-4c5f-4ff2-bcf7-bbc1515840c4	a989dadc-5d7e-4058-9272-33faeafb49b7	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	52a04847-6d6d-4f02-8f18-bc83483dade8	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
9bea9ff6-31e0-490c-8a73-cf5ad54067c6	a989dadc-5d7e-4058-9272-33faeafb49b7	f
88109d9b-350a-4f67-b7ba-ace54b4b53a3	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	52a04847-6d6d-4f02-8f18-bc83483dade8	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
88109d9b-350a-4f67-b7ba-ace54b4b53a3	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
88109d9b-350a-4f67-b7ba-ace54b4b53a3	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
88109d9b-350a-4f67-b7ba-ace54b4b53a3	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
88109d9b-350a-4f67-b7ba-ace54b4b53a3	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
88109d9b-350a-4f67-b7ba-ace54b4b53a3	a989dadc-5d7e-4058-9272-33faeafb49b7	f
9d7bd522-e633-4aa9-8492-8e600fc28621	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
9d7bd522-e633-4aa9-8492-8e600fc28621	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
9d7bd522-e633-4aa9-8492-8e600fc28621	52a04847-6d6d-4f02-8f18-bc83483dade8	t
9d7bd522-e633-4aa9-8492-8e600fc28621	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
9d7bd522-e633-4aa9-8492-8e600fc28621	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
9d7bd522-e633-4aa9-8492-8e600fc28621	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
9d7bd522-e633-4aa9-8492-8e600fc28621	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
9d7bd522-e633-4aa9-8492-8e600fc28621	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
9d7bd522-e633-4aa9-8492-8e600fc28621	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
9d7bd522-e633-4aa9-8492-8e600fc28621	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
9d7bd522-e633-4aa9-8492-8e600fc28621	a989dadc-5d7e-4058-9272-33faeafb49b7	f
a333915a-1b01-4ca0-9941-81f18ca387d9	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
a333915a-1b01-4ca0-9941-81f18ca387d9	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
a333915a-1b01-4ca0-9941-81f18ca387d9	591043e6-53cb-49e0-8a27-342d20ddd65d	t
a333915a-1b01-4ca0-9941-81f18ca387d9	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
a333915a-1b01-4ca0-9941-81f18ca387d9	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
a333915a-1b01-4ca0-9941-81f18ca387d9	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
a333915a-1b01-4ca0-9941-81f18ca387d9	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
a333915a-1b01-4ca0-9941-81f18ca387d9	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
a333915a-1b01-4ca0-9941-81f18ca387d9	53be55b0-38f9-44b7-8090-9ff42c74f389	f
a333915a-1b01-4ca0-9941-81f18ca387d9	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
a333915a-1b01-4ca0-9941-81f18ca387d9	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	591043e6-53cb-49e0-8a27-342d20ddd65d	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	53be55b0-38f9-44b7-8090-9ff42c74f389	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	591043e6-53cb-49e0-8a27-342d20ddd65d	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	53be55b0-38f9-44b7-8090-9ff42c74f389	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
6d68b3d4-bb53-4a21-94dc-c0f98d836f8c	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	591043e6-53cb-49e0-8a27-342d20ddd65d	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	53be55b0-38f9-44b7-8090-9ff42c74f389	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
f24250e5-5a9a-4983-9a8c-53f8bf4721ee	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
c98187f5-233e-47df-990a-c1213d8fc7bf	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
c98187f5-233e-47df-990a-c1213d8fc7bf	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
c98187f5-233e-47df-990a-c1213d8fc7bf	591043e6-53cb-49e0-8a27-342d20ddd65d	t
c98187f5-233e-47df-990a-c1213d8fc7bf	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
c98187f5-233e-47df-990a-c1213d8fc7bf	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
c98187f5-233e-47df-990a-c1213d8fc7bf	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
c98187f5-233e-47df-990a-c1213d8fc7bf	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
c98187f5-233e-47df-990a-c1213d8fc7bf	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
c98187f5-233e-47df-990a-c1213d8fc7bf	53be55b0-38f9-44b7-8090-9ff42c74f389	f
c98187f5-233e-47df-990a-c1213d8fc7bf	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
c98187f5-233e-47df-990a-c1213d8fc7bf	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
2793ce4a-5ecb-4800-9476-072b62529f6f	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
2793ce4a-5ecb-4800-9476-072b62529f6f	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
2793ce4a-5ecb-4800-9476-072b62529f6f	591043e6-53cb-49e0-8a27-342d20ddd65d	t
2793ce4a-5ecb-4800-9476-072b62529f6f	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
2793ce4a-5ecb-4800-9476-072b62529f6f	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
2793ce4a-5ecb-4800-9476-072b62529f6f	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
2793ce4a-5ecb-4800-9476-072b62529f6f	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
2793ce4a-5ecb-4800-9476-072b62529f6f	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
2793ce4a-5ecb-4800-9476-072b62529f6f	53be55b0-38f9-44b7-8090-9ff42c74f389	f
2793ce4a-5ecb-4800-9476-072b62529f6f	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
2793ce4a-5ecb-4800-9476-072b62529f6f	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	591043e6-53cb-49e0-8a27-342d20ddd65d	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
3b69e458-b218-41d8-88f4-e35fbd7c637b	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	53be55b0-38f9-44b7-8090-9ff42c74f389	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
3b69e458-b218-41d8-88f4-e35fbd7c637b	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	591043e6-53cb-49e0-8a27-342d20ddd65d	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
0f8b949c-dea0-4092-a532-8aba3a67b8dd	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	53be55b0-38f9-44b7-8090-9ff42c74f389	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
0f8b949c-dea0-4092-a532-8aba3a67b8dd	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
c214ed28-8adc-49f7-881a-4f8989ffb487	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
c214ed28-8adc-49f7-881a-4f8989ffb487	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
c214ed28-8adc-49f7-881a-4f8989ffb487	591043e6-53cb-49e0-8a27-342d20ddd65d	t
c214ed28-8adc-49f7-881a-4f8989ffb487	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
c214ed28-8adc-49f7-881a-4f8989ffb487	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
c214ed28-8adc-49f7-881a-4f8989ffb487	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
c214ed28-8adc-49f7-881a-4f8989ffb487	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
c214ed28-8adc-49f7-881a-4f8989ffb487	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
c214ed28-8adc-49f7-881a-4f8989ffb487	53be55b0-38f9-44b7-8090-9ff42c74f389	f
c214ed28-8adc-49f7-881a-4f8989ffb487	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
c214ed28-8adc-49f7-881a-4f8989ffb487	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
5adbd09e-054c-40bd-bd53-f90f69def82d	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
5adbd09e-054c-40bd-bd53-f90f69def82d	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
5adbd09e-054c-40bd-bd53-f90f69def82d	591043e6-53cb-49e0-8a27-342d20ddd65d	t
5adbd09e-054c-40bd-bd53-f90f69def82d	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
5adbd09e-054c-40bd-bd53-f90f69def82d	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
5adbd09e-054c-40bd-bd53-f90f69def82d	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
5adbd09e-054c-40bd-bd53-f90f69def82d	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
5adbd09e-054c-40bd-bd53-f90f69def82d	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
5adbd09e-054c-40bd-bd53-f90f69def82d	53be55b0-38f9-44b7-8090-9ff42c74f389	f
5adbd09e-054c-40bd-bd53-f90f69def82d	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
5adbd09e-054c-40bd-bd53-f90f69def82d	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	591043e6-53cb-49e0-8a27-342d20ddd65d	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	53be55b0-38f9-44b7-8090-9ff42c74f389	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	591043e6-53cb-49e0-8a27-342d20ddd65d	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	53be55b0-38f9-44b7-8090-9ff42c74f389	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	2f0bada1-11ab-461d-8e7d-ced9e6c688db
53be55b0-38f9-44b7-8090-9ff42c74f389	c64d2516-8166-404b-9892-5777b03d9cd4
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
2326d068-2e31-44e1-bd78-c40b22974bb6	Trusted Hosts	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
f07f197e-c350-4895-b04e-3e01c8e457b0	Consent Required	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
d0e1eed7-2a5d-4c72-97fe-956ba3db047c	Full Scope Disabled	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
d03bb4b4-cc44-4ada-97e9-09ad43ce9462	Max Clients Limit	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
a9292139-cb69-46aa-bd66-f65c930dad9f	Allowed Protocol Mapper Types	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
e47ea4d9-23de-42a1-a904-11f21b85c1af	Allowed Client Scopes	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	anonymous
f5e59f69-c0d7-4107-8fef-471060b1049b	Allowed Protocol Mapper Types	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	authenticated
f28daea4-d7d4-4e2d-8170-0e055eabaf0c	Allowed Client Scopes	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	authenticated
72b65267-fb48-4603-a484-2b0bbc46e139	rsa-generated	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	rsa-generated	org.keycloak.keys.KeyProvider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N
cc641935-d90f-4a46-897f-0197f03e2486	rsa-enc-generated	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	rsa-enc-generated	org.keycloak.keys.KeyProvider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N
da6def99-5759-458b-a6da-a4b83752ed7e	hmac-generated-hs512	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	hmac-generated	org.keycloak.keys.KeyProvider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N
481a7955-9093-4a08-9781-6e9c396e3c24	aes-generated	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	aes-generated	org.keycloak.keys.KeyProvider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N
e4a4e968-add4-4845-9b4a-5ed374796494	\N	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N
cb425ea7-560e-4158-b5c9-86b81f9a1f15	rsa-generated	782a628f-1571-41ed-8beb-5caf97452730	rsa-generated	org.keycloak.keys.KeyProvider	782a628f-1571-41ed-8beb-5caf97452730	\N
edb9e057-ceae-4db3-8813-9a8749a220ec	rsa-enc-generated	782a628f-1571-41ed-8beb-5caf97452730	rsa-enc-generated	org.keycloak.keys.KeyProvider	782a628f-1571-41ed-8beb-5caf97452730	\N
26a10d50-b790-445a-93dd-a40480fd9f8e	hmac-generated-hs512	782a628f-1571-41ed-8beb-5caf97452730	hmac-generated	org.keycloak.keys.KeyProvider	782a628f-1571-41ed-8beb-5caf97452730	\N
2dbff3ca-2321-4c2e-bd4d-5ddc4606b36d	aes-generated	782a628f-1571-41ed-8beb-5caf97452730	aes-generated	org.keycloak.keys.KeyProvider	782a628f-1571-41ed-8beb-5caf97452730	\N
a98cecf4-47d1-4345-89d8-e053f3caa822	Trusted Hosts	782a628f-1571-41ed-8beb-5caf97452730	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
903c5bb8-dc1d-4585-a51b-bc8ff1bd0c9e	Consent Required	782a628f-1571-41ed-8beb-5caf97452730	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
3f05fe96-c329-45b8-974a-b1d4e688fd69	Full Scope Disabled	782a628f-1571-41ed-8beb-5caf97452730	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
8bc92143-c3cb-4547-9be5-511f4601663b	Max Clients Limit	782a628f-1571-41ed-8beb-5caf97452730	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
cd20e3a2-48f9-48f9-b27f-cc3b497502b0	Allowed Protocol Mapper Types	782a628f-1571-41ed-8beb-5caf97452730	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
0de16451-bdec-4e9e-b94f-de3a05c37f25	Allowed Client Scopes	782a628f-1571-41ed-8beb-5caf97452730	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	anonymous
e3c5478e-ed21-4dfe-afec-c9f47770db2d	Allowed Protocol Mapper Types	782a628f-1571-41ed-8beb-5caf97452730	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	authenticated
f7399174-1bc9-406e-9bbf-b0321cd827c8	Allowed Client Scopes	782a628f-1571-41ed-8beb-5caf97452730	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	782a628f-1571-41ed-8beb-5caf97452730	authenticated
0772abe2-9d53-4788-bb35-3e8bf48453f0	\N	782a628f-1571-41ed-8beb-5caf97452730	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	782a628f-1571-41ed-8beb-5caf97452730	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
10608fd1-441f-471a-972d-8bdb75743117	e47ea4d9-23de-42a1-a904-11f21b85c1af	allow-default-scopes	true
aef38650-7285-4a32-b761-06daf1f20ad9	f28daea4-d7d4-4e2d-8170-0e055eabaf0c	allow-default-scopes	true
c3b7c4b7-df00-4b9d-8d61-e95a792ce07e	d03bb4b4-cc44-4ada-97e9-09ad43ce9462	max-clients	200
0d39bb41-8cf3-49ed-858e-254331c1a40e	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	saml-user-attribute-mapper
dca4b821-4626-4bca-8791-954c56c8e654	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
d364ed9d-b40f-462c-978f-4e0ab3a30b34	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	oidc-full-name-mapper
74763dfa-f1e7-4edc-b8d6-115d19f0def2	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9bab4411-bb8e-4fa1-91ab-f036749b73ab	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	oidc-address-mapper
41d4df5b-784a-4eb7-9012-75508d049fa4	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
0d08b80c-1672-47fb-ab58-a32d9bdd6c50	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	saml-user-property-mapper
25decf16-c626-4799-a032-b4eb9f529d03	f5e59f69-c0d7-4107-8fef-471060b1049b	allowed-protocol-mapper-types	saml-role-list-mapper
7d6c0cbd-c9e1-4f39-9853-b9c64120dbf0	2326d068-2e31-44e1-bd78-c40b22974bb6	host-sending-registration-request-must-match	true
c8f37f5e-e5b7-4b43-94a0-51d89a43cc9b	2326d068-2e31-44e1-bd78-c40b22974bb6	client-uris-must-match	true
836b537f-d918-4c06-9dad-2c1e153386b0	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	saml-user-attribute-mapper
0c5b6393-8e1f-4ac6-9e53-55bcd6aab327	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	oidc-address-mapper
33697851-4b24-4243-9b7e-729f511b1e96	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
337e3005-46fd-410a-adf0-23bcb0ccbee1	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	saml-user-property-mapper
fe3ad804-f24e-4315-a859-b704b78d5eda	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	saml-role-list-mapper
41e968e9-ac0f-40fc-8b95-a861adedbb1a	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
8ab27bbc-6e49-4fac-a058-996036d52394	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	oidc-full-name-mapper
d9db6e26-9042-4c91-a83c-7f02bc3aaf0b	a9292139-cb69-46aa-bd66-f65c930dad9f	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d9267aa0-dc7d-4def-a1a5-71de52c8f82a	cc641935-d90f-4a46-897f-0197f03e2486	algorithm	RSA-OAEP
8dc53a90-cf64-4d18-a3b8-2a5516f3d81d	cc641935-d90f-4a46-897f-0197f03e2486	keyUse	ENC
0ef841ab-a7a9-44ad-ac32-9e85c82ea3e0	cc641935-d90f-4a46-897f-0197f03e2486	privateKey	MIIEogIBAAKCAQEAw28QNfHtGbNxj66Mciw1zR6ZpGl9NFrYupz6vs2qjTsK91iBAn+SPUsKcBOBNabKTFcm9nP6P6epdM6/3Gggqb3msc/nFt7r5y9GaiYmffFXbM4AsPzIqmR9fJvIF+v3J27wyJFBGDoyohzS9T3B4e/iVvZckPXlqCAKWJtA/6kp9fXjh/xv0MA6ow9cI6M1A/QZ1o19Pi++/BWQTGLSYX5GNcGghAjipsXjgj+/Th7SqD3HZZTplxA0qfV+qbqyvqYcGaHzDaoKFHyjRgcGTlm+YtxHEwrf8h7tFsz/eRor8UWLdloV79e2njXBjdP52rCIyR3UzLDMicn/WGg+XwIDAQABAoIBACSFYbsi/ZLa9LLMBJTlbBxrxnxx9iLNg0jEQxta5a9ExFTapikoW9S2bDnrey7if1Vqx+4wWCiDFWitpi7zCn+N7El4N5APknf+XqNBg9nvOs4rZPeuFXW6F7Usi2TlBKfK1JY2hrqXTZT72/RWWR/2qw5jNYMlYIhdjHFoeeoMh8lWChrAoWbyV6nRx6iL+R/75jj7qxiycfr+X03qR8TnhwCd5xDQsrCn/mNsSaPJ9e2zJfZeSdV/gFRO2lSnmhb65xDE6NCdGrBgsWP4WEaSQ3kGsTWyxJx9i3k1R75uWH7RyHOEZ5v0VP6fHjXnKPyyhq3qsYe1Gd1hWxW+OQkCgYEA9M6iYgc9vC9r+3lmRdpZHxRICnbQoz/8cPTKGijykb5V5Dh+u0h9IT1AyvZ7tMwo19RQTypUq6GxcfJ8pJYR0MzT/2siu1J4SRtSC3HGEWW3z2uDUONz9COpy0Dpdb/J5AIWiWCCegaRD3Bnf5Rpep4urP7u6Ty3iWMz7ZDGipsCgYEAzF6I7MgnxzmnuIskp/P4ggGLMjNyRIdAJWI8l9ld3Uf46fCd71sH6MPpU0EF7R3H355/bAi+bf+K/sEaxlASLT8JcQhMDj+jUFu8wJOFvlp6+B2eGqdSpStpB7Df5t/Aova5TBjK5bZmLQsP+wIFM/ekTIgfK7n5xd5XLuqopY0CgYBKYR3lOt3+90mPtmrkflrlnnvk8gSiFSbWCwn8uMQ6k+H03VVkAbpDByFQiWM8o2slaFSeOPZQz2fifxJvz0jKb/FZgWukDoKNc8eRwpezYXxfgQL86J6qZsuH/cjxBbyJkjjWtIPwH16jmjtX//esUbNMzIg6RUBedc2pOHuaUQKBgF7S3iU/GXXOwotVxERJZtyrarJ4PGSffJvb4NF0AaFSa6PgCOeuDRVrES+X0/AZCUwwdl7iD7lqAEwDvTCWplhoDzFq8B8MV/JJHmMcD8oqoTPOSjWDvUz1v13aK4kr+G2knIU6W6oJ3462u0tzvIZIOOtpnUzklYfBiiIyrt1hAoGAUnP3U/p2KD6W9goWk4Sc3dHbI2bG+eSJVj7twJLeD7HUUnEOWCZMxHB0EN4m7c2s71vU26rS2FMuOlZSBsY5KFYatfq7mcvKOKvs/j0/K88l6LySdQCCNcQckMwMHMENPVzgoyuIMVKjhW5szd5qqTOkd+J1MJvAyBY3Zf6czsI=
5bf36c2c-d35d-49ae-9d52-1bdd36212587	cc641935-d90f-4a46-897f-0197f03e2486	priority	100
5bac8382-fbb1-4e50-ba57-166618feec5f	cc641935-d90f-4a46-897f-0197f03e2486	certificate	MIICmzCCAYMCBgGVf5pfUjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzEwMTAyNzU4WhcNMzUwMzEwMTAyOTM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDDbxA18e0Zs3GProxyLDXNHpmkaX00Wti6nPq+zaqNOwr3WIECf5I9SwpwE4E1pspMVyb2c/o/p6l0zr/caCCpveaxz+cW3uvnL0ZqJiZ98VdszgCw/MiqZH18m8gX6/cnbvDIkUEYOjKiHNL1PcHh7+JW9lyQ9eWoIApYm0D/qSn19eOH/G/QwDqjD1wjozUD9BnWjX0+L778FZBMYtJhfkY1waCECOKmxeOCP79OHtKoPcdllOmXEDSp9X6purK+phwZofMNqgoUfKNGBwZOWb5i3EcTCt/yHu0WzP95GivxRYt2WhXv17aeNcGN0/nasIjJHdTMsMyJyf9YaD5fAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAq0sY0Zddf86kRcaSxXnc6D5qiDNj3vD74oI64aS5BXbx4K2xE+/f+GBoCWZ2hQ9u/e0l9qyhRggYkqITzVuUbIBXywMJJYvfzRmnl7YI2s0DheoMCP+x6d5ocAKu2X2YAgdnB9RTT99toinxc8A699kWtsZGbmPae+5dFFL0cvMjTXm7Gyav+RxigJVBkvbQrSiLqZtP18xq/FHTfnEEpKlY33du4dJAF5e3Xoh9P5dQVshuPs/mtBsU2ytI2Q9f2MgJrMfWdWqZ12Zm/Kspv4qpGMOfmlmmApLOfxFVgMTjPLPMH+KD3tGt+pwTJOhhYV+AJkg5a3QBN7ZUyvsDs=
a74d294b-c27e-4650-81af-18f28917a12f	e4a4e968-add4-4845-9b4a-5ed374796494	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
9670efed-8029-43a8-b4ce-79481a9ea5f8	481a7955-9093-4a08-9781-6e9c396e3c24	secret	WDKIOw8mdANdXxQipUrfxg
12d40a4a-159d-4c63-9600-623fd5616b6d	481a7955-9093-4a08-9781-6e9c396e3c24	priority	100
20f51df2-0936-4495-8d00-80049d20e8e6	481a7955-9093-4a08-9781-6e9c396e3c24	kid	78c3b854-cb34-4bb0-81ee-79804d8f5d59
0fffa70b-2c21-47da-a21f-b0e47dcab21d	72b65267-fb48-4603-a484-2b0bbc46e139	certificate	MIICmzCCAYMCBgGVf5pfDDANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMzEwMTAyNzU4WhcNMzUwMzEwMTAyOTM4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDPdDI8EAr7PjwUVI+W54vTeuP+Pqqi5IlCFmNT10IrBP/2GMe4WI+N6mv9LfEnqsQFm2GQFyhXUgb9teXHaHEhgui0NKqZ4nYdTdQZHqWRHTh/8PDFfA2hELyBB/cuUT0smW/GJBTuLwWpInCfTErbxrvf9ebpad4aPH9XCYHjq7GNB35Eij1+/hRyQfWOJ8vm9DzUshlktfyNr0n12LDU0B5pgk/1wU5gt62F7HsjJHm//L7av908Xix3TPHpigQUNBs3oRG9k5BIRlqAw7hfqe0mQGvKKLjso+STRw1xksx5fn+FPZM1sFdRayFOJ6J1SStp+EFi0qdcz539FoVDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAErDDzuJ+G5SeHRUUd9ZWUeGT4qARAkbddElTcRi+VaSJUAx5Ha0nQvEpkRIb6GPsI0isNM6rd0bmVSkvaOCZcrZRo9JjIePxuUhJ7j0CIrV0AGu26+f3zWYG/W0w78o6P36bP0WdE7rrFLjAPeheCik4BoMwoU4cYNOEnDgVtO1ClmYOo9Xu/qyU24rESvkQTy/WMr3OI1ZatrGLrZkAjKWw/ytt8N6QE00bKGAADrrzPrftKbOhBq1DfrFcJIOnz2izocmd0LvFq/n2CVXQVlIMb9vFojDmBjDlfmp5PTrVLR9O1kpsLb+GAgx0gK1zKJ6UTZQqTLjeFbfp077UVs=
43e5cc5a-792a-4e87-9fdd-29656768c1d0	72b65267-fb48-4603-a484-2b0bbc46e139	privateKey	MIIEpAIBAAKCAQEAz3QyPBAK+z48FFSPlueL03rj/j6qouSJQhZjU9dCKwT/9hjHuFiPjepr/S3xJ6rEBZthkBcoV1IG/bXlx2hxIYLotDSqmeJ2HU3UGR6lkR04f/DwxXwNoRC8gQf3LlE9LJlvxiQU7i8FqSJwn0xK28a73/Xm6WneGjx/VwmB46uxjQd+RIo9fv4UckH1jifL5vQ81LIZZLX8ja9J9diw1NAeaYJP9cFOYLethex7IyR5v/y+2r/dPF4sd0zx6YoEFDQbN6ERvZOQSEZagMO4X6ntJkBryii47KPkk0cNcZLMeX5/hT2TNbBXUWshTieidUkrafhBYtKnXM+d/RaFQwIDAQABAoIBAAIQWd+XGUTenaJmJPePXijAdDw3S2NLesIZjutqnNHovtMn8/S1jNgQmPpv1pJadJDJtvLECDa2LjOf96VAOL/omYARdhEJ27r250FIuMT00XcUYpDUZx5PGFEAT0k6ra0f6ajC+yJTfW7tVMmA7M268GuN+rofv4HrUCkBgzVMn2VhSyyadek2i/9Q0j6NDUq9AlkJl23Fj1eU7g6sVec8t+6D5zyt53wsFWhTyLhSQ6S1PPjCgKQZyKUNrP71P1k0/HLr1u5OlC4ccuXGqbE/YSBF3UtGOrsQrISE9vxXyJgItSWGRpquZkae/9noMcMEpJgUTpmN8VH0tNoyFuECgYEA6/68TzHEk+/8tOnJfDQYaKKQHEJbrUPjwqYgKR3KaEz5EZUCN0eKqLx2sxGr0UEaexIOLaLsdKt9QzqeFv7R7zLIfl4W7XVM45IcTjuKcm4QLwO9q2VGD6Jj4csy3fKNFWGWstM7qc3kXQjspR3Dk6duSh5JiMz4aek7tlNLm60CgYEA4QoYtWVeltcSLItKUMOQPBXxDOviBLjGy4SB65ndXq+lHmgyc4s2lR7tHmpchbgIcCmoza9k63heQzcPbLq4vxtmQDk64wwAmAYD9Wi71ng/SgzrXQCOon/h8Ql1wQtI4ZHlw/dWq8c01DBvYSI87I+oxlAKVOjg9tED4c/mwq8CgYBnB7umx4+PFsM5KKgydXwCkpZgAAiOSIlzPZvk14C6sIA80NU61R0QNdeMrjZZERdCi8ts2Shqd0Qkyb6jQ3Tb/UvS/7j6yq9a2ztIXG5BLxQZsoRoA7rmsHry5Qe8Jly57PUh9V6i76S3iWHnZGsyV3KrITXxZ6s8cfsDyrHDsQKBgQDPY8ujmFkUr/4auP9y8NeC2EG+w8AW0+a49lP5OWJueXa1UBd2rkxOHyMtTZ4YyaJVI79iVwqtis9sKFj5vha2YFzaQSPIzG3brGeHic7Z9xV0e/WITxQkI7CovywbDPhMkXVrJQ1l338LMdvja3c0F6zVnjv3RmrUa4mlWED1FwKBgQChJWy3DSrquBZK5mPFF01fQ6AaQXeANBh0mURNCQl3hT45HLblWCNOGMV5PGLBJaMMc9cCda4IjeIdqSqGyTi8NqRQGWniOnXQFNl658Z6DyS4BSv/4s5XUq4dx7tG3Nf95w/449BqhgVex5yPP8MbP6fHV9D1VHTazVRiKWyv/Q==
a70faa87-4910-4e57-913b-6a728d989ea2	72b65267-fb48-4603-a484-2b0bbc46e139	priority	100
df49aa8e-0350-4df8-9ae3-d02c3bd3093b	72b65267-fb48-4603-a484-2b0bbc46e139	keyUse	SIG
7c1a3bfe-bd9c-48c6-a8d4-0e30e9fcfa52	da6def99-5759-458b-a6da-a4b83752ed7e	secret	LrXTNVraAq13OfplD1vKsAV6m51gz2q2ZkRN0Oh8ozG_kICjB8WpDuDtPLKyDK4slJzCnZiBcocFgPanCmb4Xw6A6LG1R73ccDn6KYVGPaABsz5ona1rrEFNOi11jPgb4B0kyJ-hkcxOsSFbg1y0EMr58EOPNgkeR8j0oL4FM7o
84e69b71-4fe5-4ed8-9d16-1691cc8258e2	da6def99-5759-458b-a6da-a4b83752ed7e	priority	100
90456d1b-8c38-4a18-b557-d9c3729162b4	da6def99-5759-458b-a6da-a4b83752ed7e	algorithm	HS512
45402d5f-e856-4991-872d-1673814a8ea6	da6def99-5759-458b-a6da-a4b83752ed7e	kid	a493b68a-766c-4f43-9a36-4bb902e64998
cc7190ce-83d4-4718-8bd3-2d4c661bbaee	26a10d50-b790-445a-93dd-a40480fd9f8e	secret	YE5dO1jTxBtH4mOn8HpxLF8Z2Grdm15u_ffDLdHVkipncpUtYAwJqWNA-OrQUU0p9pMZ5G6hR6CqBPXr5bEVBPK83NxnQ5dScHe5PFWvaWgwADjEiBmJcIKKMih1vDIRb8jxMelzNT_Lfm69NljN0KRZQnVo1dIuZxvL0oQBvTA
683ade66-1735-417c-9b0d-cc1a90dfca15	26a10d50-b790-445a-93dd-a40480fd9f8e	algorithm	HS512
ce2bcd2a-3562-4df0-bc88-976dda19bcf3	26a10d50-b790-445a-93dd-a40480fd9f8e	priority	100
98b6ad62-4f79-4d98-a794-bbc8c0d75d94	26a10d50-b790-445a-93dd-a40480fd9f8e	kid	22d5b8f8-cc45-4d27-9ae8-6421bc63dc03
5f2789a8-596a-47bf-9516-dd14d2965415	2dbff3ca-2321-4c2e-bd4d-5ddc4606b36d	kid	63e39794-1058-453d-b119-9ff1df41bc87
c71337f0-1e0b-4526-954a-aa099985fbb0	2dbff3ca-2321-4c2e-bd4d-5ddc4606b36d	secret	o1CBxTZ2hoxqyxqyPrzLEw
fb189783-8f9b-4103-8646-fe929c32f33c	2dbff3ca-2321-4c2e-bd4d-5ddc4606b36d	priority	100
74d1890c-586a-4585-8663-0b063249fdc2	edb9e057-ceae-4db3-8813-9a8749a220ec	keyUse	ENC
64737ae0-e489-402e-8a9d-2adbaba31003	edb9e057-ceae-4db3-8813-9a8749a220ec	certificate	MIICqTCCAZECBgGVf5vTiDANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA10ZXJhbmdhX3JlYWxtMB4XDTI1MDMxMDEwMjkzM1oXDTM1MDMxMDEwMzExM1owGDEWMBQGA1UEAwwNdGVyYW5nYV9yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMO5duZYooy7D2QMq7SZbXfUFcUrbO85FcTTMWTs22Odqf1pTcZsJCuxh0qzb28gI55kWLHWfUqyf3/wxDMvCxCqpeMC2sAezLWf9ZsjGDHO29e0DrQAP8LhCss95TrCIGM/V0ZtoBRQO1q3oxztbEOUfKguabLwFbCYHYL/ZG8sw8e4Zq6S9Z0sCxNmwT1vWqHiZ5bBLjd3N08LUs2u/BOESD9zQL/1GPzwpOhRboGJIhslD6UbpcPYVS0voE1cY5D/m6A+KFX1xl7Sb0kPcr7IfNsDsBTBPY//b6PvKNgd6zbPNax9PhntEjD9/O2Aifxmn0fqnypJPRqdHa7ijpUCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAZp9b2r+PDNeM+IDRlHgmB0LJwTBaAgXAQzgmFXn7eZoVWfYzdLm0Jb9HEVEH24/cNx+8FXpxx6gOJJy8HmOTKP/5IFWuyVKlYVX06wUgHLjydWU0JQkg+XtaOh+KmNdH5rq4T60+kReJOmUDEMlNsd2S8By9LFTCufYYanJbT/KTo/xzFvK9wGhG02R14muS0yS0XnS41EMh05XprgVxwP/iig4eLxqNUxXgg9nv7xGkYuKyYudlycaMKozBxBUXar0jxS+KLiWO6JeSyTid70+6jBOXSf4gDZ6FgrXs+ObeOPhHSnxhftb8gR/vIqrrvUr2ff/nb+bUX7jlwhVJAw==
d5e9eaf0-586a-405c-a37f-48bd8ff94931	edb9e057-ceae-4db3-8813-9a8749a220ec	privateKey	MIIEpAIBAAKCAQEAw7l25liijLsPZAyrtJltd9QVxSts7zkVxNMxZOzbY52p/WlNxmwkK7GHSrNvbyAjnmRYsdZ9SrJ/f/DEMy8LEKql4wLawB7MtZ/1myMYMc7b17QOtAA/wuEKyz3lOsIgYz9XRm2gFFA7WrejHO1sQ5R8qC5psvAVsJgdgv9kbyzDx7hmrpL1nSwLE2bBPW9aoeJnlsEuN3c3TwtSza78E4RIP3NAv/UY/PCk6FFugYkiGyUPpRulw9hVLS+gTVxjkP+boD4oVfXGXtJvSQ9yvsh82wOwFME9j/9vo+8o2B3rNs81rH0+Ge0SMP387YCJ/GafR+qfKkk9Gp0druKOlQIDAQABAoIBACjw2OT2mevnriC+wMUKifo0kCg5/POuZHYTOkQTApI8FuSV/CmbEdbc8ACpd5AOcDzv3xi2FefD3kU4KwZM2xrtoz0Q6gqhdq8wSlsc9HDoxRZCCQhQfAXq9ovMgvBvToCMLZijEkblgIDppFJG/KxHOWshqEUAkPzrWNL/0rWpUPpNlWjGYwD8omPrvinTtsFQA1AgJXgS5HmMxjQn2UjX+W9QDI8KDUsiBsyeqSDmYqdaqSIeoViOOFC7fO8s7X+1XkCnQm0m96I2Zl9tYSUO2gWqPuw+NhcKUCh0MLB6mf/P2Q3NqiAHRdDcJAhpPNugoXxRP0Dupe9iLhtX69ECgYEA6ukdzDn6P+oYdOzfBdpcUZih3+CMPLigI//1xrL+K3jZiE9psmsOAEmqgJfOHWkgAhVSyOU4hJqUnEgDw3ui2+bekjyEOZ6eHObJNUPogEe1XcRu3CCTKEdQ9/hKOcz/5e63eUi84wRX/MGsxrVsAZjsOtJh2zkr+H4x6gOhwGUCgYEA1Uu+gVT68LGVrF8tCNKtqS0hKhmcQH9LqrrTM9LBtPB9If/3e1Q5RVGgEZmn6K6clxb0KmWaE6IHhhCdqiv3Oeva+yszAobIOrtvbwLrp7o7W7HtU/mcmHTHHRwPp3d6biq5yKfhUS2/qfBgHte4jqpnJrWLiYVbTmLozgGS+nECgYEAyEkL6+V+1WG9imuvV2kvDy7ozV3Bk8ACYc9JeSmBhgUay5qRztpx7JLieZN03CSWctBFbh3pyz2U+Y55DwHqAD3ehKZuQkZYHuIyqWSF5mG9Y/4oWyy26z+q7FFYz+FWSW/4JMN8sL4yWsGykxV5yf7dYuWfI2+iatMFsbV5AvUCgYEAvpXamHeVbgJPyeCVPd/5+kNv8c1Gd78GnnwnAZRdL07/kKTFvrZIIi9IRtG0Xc2/76U78LIuVUKfVGR+bLKySlf7qBg2kRhby1b1wAytAob+SPWYKUPNb9BQpisPtcSladDVhnyzcLTfIHq/eG+q4hdS6hynnO7C4iyw9nojmZECgYAxVFXiV1xiE8KRtDOMKplQbPQ6Pm83ldoIhe9/B/vJyErsWlRdfzPG6pyFyJqH3PuJlkXb511poVHrrI8Bs5VoBcEEGsJwAKYcWhdW9nPP6RCeYpHA0ycbwtrl0KaxW0yE4dJjF7u8bD1n9fcINkoTQgv+jhs2y1JIl22eQnVaNg==
71472c3d-9857-4876-af90-2488380ce277	edb9e057-ceae-4db3-8813-9a8749a220ec	algorithm	RSA-OAEP
6596feb2-57d9-4076-acb6-47a9b1330c15	edb9e057-ceae-4db3-8813-9a8749a220ec	priority	100
52d8e948-700d-434b-9333-8fa8c45fba4e	cb425ea7-560e-4158-b5c9-86b81f9a1f15	privateKey	MIIEogIBAAKCAQEAqZm/J921EJcs3KG3f7vSzBEpiwq6jIlGRFUKbeMTK4jqbkqbi+91CdxDYhH8POrxu+5i+WDbr5eEZ6R6ZlvtMp8j5XcDp97vbO4479ICmdItXAcpyGk6Z4yUJJD3ntCxproBDwfk2mFYlZlT/gcs+2UFtXc9sWz/HGA28jsmsvxte4LTKLuU7rybmRaJoMyB/64+n9NhRWJQWzrBthXrzPiTzeyIeIwzEtwghCG93NMrzcGyv+hoDJ7SahR1YUaBuxcLcgMYpAy9YH3mTR/OjeRROri/XBw7JrLnNIPcsC7RrxZ3LzR60sUfPLKBa6xisbqt1qOaQh7zP1kAN7eavwIDAQABAoIBAAu8l1HF8iCBXJD6/kYCgi1ANacNdyjbboVFenMklv4GspFTov1zGXp+NUCw3ssNkOyzK9Vktvhf83goFd/GFjjQKRR999E5v0lVhdyYgBQl3XxLBXehb3GvUF923MUc79CcnuprzG2Nh+H4HtBP9xkTveplWoBQDWEyCjI+BD+3+b1LFJdffwlEFJ8+rLPjjMNrNcdMHSadhHQd92a6tLKAV/sZq/lhzHw/TLQc+/7A4o1bvNSvRQ7ffp3vG3zSvN7m5WUkOcHi//KAdlCg0VLnOmNUz0rwgJpyL8LYvZzRuo9Ejo2h8jJQiHm2uiIGf+BfulnicHGG15peNCU1IukCgYEA7wgKmkYayY9PYf4JxZ6L8SjtkxpzBdPm9itCptzVVdpCD1U4gddylB2TbQMs0wP08VRFnvTLnzfJdvy17WoevUq4Tw168pMe0OmSwFIaKkxq7Pc59Ev7oWQfSFVGtuNngmAe2uyRz32MxrFidvGbk+rY8G/xGnSW0OeRcfSZAIUCgYEAtaPtRBvNoUb6lLUtAew5Uek+iskoh92cf52i/rUKPHPyzI+C0REaMWCPaC5cdTpXaM2fJNtOjWjaTgiIDUFSMzDVMRr4s0GRSeEFwtLTJiunnu+rYf+VgrNdOAh5BwFNflQStOaG+MtzMu3Q7KvIh58TxluQoxufBRNitrPwk3MCgYAVtWVBHZzRMXLEM44vpHaRMGZjNcO8g8I2GTe0b9nwMiJNwi+fmzGMwiLhg6hOgc19HWo1RYY4r5hcdhcPuNOR3Xdftpmz7iieUJhDXzGBJe+QFePti/kOb0loCFajxYNhE9m5iEK11XEzmmiW5Np8VJffPktnW69WybEr6Er9AQKBgGeGxA/CrQPT+bRSQxHKeq0V/KCLoH83ryAJT8JOm0PzbhprXUsdrUkhWPsvGWFzXCiOsbsHCBGPBoXdVPYBGgG1Pn2bes5oe4+ZInh1QwWJciMjRRI44xU4d9Qc+CYm9u0eq/7ROXKKOuF3LFIIYuXxpAq1W42ri4oQD35EtsTDAoGAWQ+xlbdZ0WB9JZIgYHZmqUqnSTYmgzGnvViAHaE+9Mdi7c8lgNF1rPV4Icp69fPGP6ZdcI04OKx77wocSDxGkh2awycaz/QdQzKUYTmX95zb4FQ9bgc1XGqmfeK5akxRdKkaP9+A7POdYteZ5Eagglegbb1dQER8RJ44SSP4RRU=
5548f69d-17be-464b-a7be-0790021bb20a	cb425ea7-560e-4158-b5c9-86b81f9a1f15	keyUse	SIG
e84bb73f-1a44-4334-89e5-37d1d3fb606b	cb425ea7-560e-4158-b5c9-86b81f9a1f15	certificate	MIICqTCCAZECBgGVf5vTLzANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA10ZXJhbmdhX3JlYWxtMB4XDTI1MDMxMDEwMjkzM1oXDTM1MDMxMDEwMzExM1owGDEWMBQGA1UEAwwNdGVyYW5nYV9yZWFsbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKmZvyfdtRCXLNyht3+70swRKYsKuoyJRkRVCm3jEyuI6m5Km4vvdQncQ2IR/Dzq8bvuYvlg26+XhGekemZb7TKfI+V3A6fe72zuOO/SApnSLVwHKchpOmeMlCSQ957Qsaa6AQ8H5NphWJWZU/4HLPtlBbV3PbFs/xxgNvI7JrL8bXuC0yi7lO68m5kWiaDMgf+uPp/TYUViUFs6wbYV68z4k83siHiMMxLcIIQhvdzTK83Bsr/oaAye0moUdWFGgbsXC3IDGKQMvWB95k0fzo3kUTq4v1wcOyay5zSD3LAu0a8Wdy80etLFHzyygWusYrG6rdajmkIe8z9ZADe3mr8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAkl3qykbYEtnWwOSVWgW+ybumE1MWPClhucmgoY2yDx2kdfhAOwXA1ehrHDAP/V57pXKPaVJqYLAnDbTfyLGVtHhewgy/PURZylRaiI2Vslr8Y031HmuJzYh9rlvM5DBNuip6KTNPMMpLj8e1VVQlH6YK//hX4f2Bz3aGHIJ1byFb4G5g6pVokgPOTkozDMOZPg0JqHLVOK8FNE7eM+CV9qh8RZ6MJ4l9aGA9nHbRpZ5tyTjIRMwjz4LYET5L+SHnRmIw5vNDtaJErEnqVOcvaK9Xtb+d42TPKqJGbNcVdxSTSC8QD3OTksoX+ysR9wKMjZ+Z2ivDzAeLQuorFrY3mQ==
c981df48-95ae-4f07-bd24-6e6052e0a3d4	cb425ea7-560e-4158-b5c9-86b81f9a1f15	priority	100
026f59c6-ff35-46f1-9de8-1d0b611f97fe	8bc92143-c3cb-4547-9be5-511f4601663b	max-clients	200
833a6b65-39f2-4958-901c-bb05758d7ba6	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	saml-user-attribute-mapper
694a4849-f95d-4cce-90f1-e1c59019af3b	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
08c01ab2-ff40-453f-9227-7874430915b3	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	oidc-full-name-mapper
8d8141c9-b8bd-4c7a-a395-96951ec150e3	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5034ff33-1bd4-4612-9075-1e86002953d3	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	oidc-address-mapper
15100015-a78b-4e3a-a88f-eb3675493ae1	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	saml-role-list-mapper
0c9f555b-12d0-496d-8f8e-7ab8fe53433b	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7453dc0e-fac6-4a99-b517-c31796fb38b6	e3c5478e-ed21-4dfe-afec-c9f47770db2d	allowed-protocol-mapper-types	saml-user-property-mapper
0cd47bb4-fe23-4ef3-8d15-164fa81f9cb5	0de16451-bdec-4e9e-b94f-de3a05c37f25	allow-default-scopes	true
021bb99b-386f-4d20-8b7c-1633a1158cff	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
853d5583-5aa7-4d5e-87d6-2bcd0c75a999	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	oidc-full-name-mapper
11c0afee-9ea4-46c2-97c1-35b1a118ebdc	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	oidc-address-mapper
8e875a9d-0ba8-4f55-a7c6-8e5e02819e77	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	saml-user-attribute-mapper
55a52f9c-2433-4d49-840a-10a030a63ed9	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	saml-role-list-mapper
02d591ee-3b55-4120-9df6-c340849886e7	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	saml-user-property-mapper
90f27227-734a-4fd6-aa02-deb32172bacc	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a8c0f65d-43a8-45a3-9011-140426628ccd	cd20e3a2-48f9-48f9-b27f-cc3b497502b0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e87f6854-afdd-4b55-bdec-862801e6dc8a	a98cecf4-47d1-4345-89d8-e053f3caa822	client-uris-must-match	true
3e388fe6-7400-41ed-97c4-0dd6c3886d72	a98cecf4-47d1-4345-89d8-e053f3caa822	host-sending-registration-request-must-match	true
5b0b0edb-4016-4911-9830-9a70294df5cc	f7399174-1bc9-406e-9bbf-b0321cd827c8	allow-default-scopes	true
db865dee-5526-4af2-ac09-00cc8a22f087	0772abe2-9d53-4788-bb35-3e8bf48453f0	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
19499693-3f3d-4575-be63-c3ed9afc88de	6f7e4822-8ef3-48c4-86c6-978030e8f0eb
19499693-3f3d-4575-be63-c3ed9afc88de	21ee9388-519f-4170-bfb9-a9ba9a39d6cb
19499693-3f3d-4575-be63-c3ed9afc88de	42dc9f72-7287-4b6a-a1e8-117ff588b8dc
19499693-3f3d-4575-be63-c3ed9afc88de	edeb5da8-487f-470c-8384-5311e0594299
19499693-3f3d-4575-be63-c3ed9afc88de	c2a441ac-d938-45e8-a53a-963ca3f10dc3
19499693-3f3d-4575-be63-c3ed9afc88de	81c6611c-2c2b-45dc-92ac-809b6c624822
19499693-3f3d-4575-be63-c3ed9afc88de	80ffe453-8211-4305-9fb8-f589c777060d
19499693-3f3d-4575-be63-c3ed9afc88de	40425ce7-fb16-47e9-bc9b-9748e5b64b1b
19499693-3f3d-4575-be63-c3ed9afc88de	b1366d6b-2fd4-44eb-b3bc-f17160ae0872
19499693-3f3d-4575-be63-c3ed9afc88de	3bbdd7f9-38ad-4b3f-a270-3bd7b3ea7b9f
19499693-3f3d-4575-be63-c3ed9afc88de	3e3f9a0f-7600-43cb-96c6-fcce49b420d8
19499693-3f3d-4575-be63-c3ed9afc88de	f39c3282-e513-4102-aa22-b2c049ca92d5
19499693-3f3d-4575-be63-c3ed9afc88de	064afe56-dc44-4c02-bcd7-b428d0afb19e
19499693-3f3d-4575-be63-c3ed9afc88de	97b3e2cb-f1e0-47b4-b645-771d10cf09a6
19499693-3f3d-4575-be63-c3ed9afc88de	37a24f46-78ff-4554-8b65-442e1739f7a7
19499693-3f3d-4575-be63-c3ed9afc88de	e907c83d-a4f5-42f7-9d75-9206d74d05e5
19499693-3f3d-4575-be63-c3ed9afc88de	56f746cf-442e-4625-b114-42fd72127834
19499693-3f3d-4575-be63-c3ed9afc88de	f51515a2-f091-465c-803b-38538d7d6d1d
1584521d-e96a-4219-920b-54cb047069f0	0da75ac0-8ce2-44a6-abae-5ea5b1a9f570
c2a441ac-d938-45e8-a53a-963ca3f10dc3	e907c83d-a4f5-42f7-9d75-9206d74d05e5
edeb5da8-487f-470c-8384-5311e0594299	37a24f46-78ff-4554-8b65-442e1739f7a7
edeb5da8-487f-470c-8384-5311e0594299	f51515a2-f091-465c-803b-38538d7d6d1d
1584521d-e96a-4219-920b-54cb047069f0	b7bf31a7-5872-4bac-96bd-59df685832b9
b7bf31a7-5872-4bac-96bd-59df685832b9	03ab61e8-63f5-4bb5-b396-9b270e8977a3
318fa365-790e-4db2-a39a-a7789df40c2f	51a9fe44-1634-4b38-994f-db12e9a44076
19499693-3f3d-4575-be63-c3ed9afc88de	cb21bc8b-fde5-4897-8493-2d32206ada48
1584521d-e96a-4219-920b-54cb047069f0	2f0bada1-11ab-461d-8e7d-ced9e6c688db
1584521d-e96a-4219-920b-54cb047069f0	8d2cd375-f41b-44c3-8931-804c5d70979b
19499693-3f3d-4575-be63-c3ed9afc88de	eb932124-80cd-48e0-af46-68676ad74e2b
19499693-3f3d-4575-be63-c3ed9afc88de	b1b9fe3a-1ef7-429a-b013-3d6f2c65df37
19499693-3f3d-4575-be63-c3ed9afc88de	3a413a8b-f572-460c-8bf6-e35c69bde04c
19499693-3f3d-4575-be63-c3ed9afc88de	ad4eab25-0134-4d0a-94d9-d9ad16b7ed07
19499693-3f3d-4575-be63-c3ed9afc88de	c3a8f67e-bf69-4fd3-9ee9-84753547b4e4
19499693-3f3d-4575-be63-c3ed9afc88de	a2c4a88b-0ed0-4bc2-a601-50813de3b2cb
19499693-3f3d-4575-be63-c3ed9afc88de	52d2e40e-8d8b-4cdb-b4a9-716345013208
19499693-3f3d-4575-be63-c3ed9afc88de	a62aeb87-00fb-4028-9b56-b692467fb4a0
19499693-3f3d-4575-be63-c3ed9afc88de	228c24a6-9fe5-4e4b-843b-3748d10f43ed
19499693-3f3d-4575-be63-c3ed9afc88de	cbbf3a8c-a235-4298-b2c4-4c950779065b
19499693-3f3d-4575-be63-c3ed9afc88de	4de42f70-5f30-433e-9bd3-f013c536cea6
19499693-3f3d-4575-be63-c3ed9afc88de	0ba0d2a6-fa68-4356-9090-7efcef4e5534
19499693-3f3d-4575-be63-c3ed9afc88de	4e1ea600-0f72-4f13-8d62-9c115af5a5cd
19499693-3f3d-4575-be63-c3ed9afc88de	dbd1964b-4d71-4257-bb26-8ad70432beb9
19499693-3f3d-4575-be63-c3ed9afc88de	19a50ab6-1583-4cbb-acb2-e4011dc8617a
19499693-3f3d-4575-be63-c3ed9afc88de	9d58a61e-80e0-489a-a8e7-9781f83688ee
19499693-3f3d-4575-be63-c3ed9afc88de	23c3dc80-0d2b-43ce-8c04-3ff662ed4795
3a413a8b-f572-460c-8bf6-e35c69bde04c	dbd1964b-4d71-4257-bb26-8ad70432beb9
3a413a8b-f572-460c-8bf6-e35c69bde04c	23c3dc80-0d2b-43ce-8c04-3ff662ed4795
ad4eab25-0134-4d0a-94d9-d9ad16b7ed07	19a50ab6-1583-4cbb-acb2-e4011dc8617a
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	60d48f79-7aa1-4ec3-bff6-f217be3f43e9
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	0338fe9a-f4a3-421c-811d-d442eb88c1b2
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	9cb775b9-a7ea-4b31-a2af-2cc0201ddabb
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	c00ccb81-8cbf-44de-a290-5b3be9faeb41
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	5c9c5641-0f0f-4fb0-b995-ebb9adf48275
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	0c161f58-39a6-4cf1-aa46-f4dad4f0736a
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	0711c599-2484-42ea-b309-47e5ddbc242e
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	f59e6a73-f164-4720-a52c-a806243de705
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	983b2c53-0ea0-4889-8139-2e41c2bd3f5a
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	e771aea2-b101-4bfb-9598-7611adce26a5
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	1d1686cd-2aca-4995-86a4-62437877b35e
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	12ecb97f-37f6-495a-b1e3-1e37f5b3c50a
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	e3653591-bd33-45a7-b359-74c46a469a7b
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	20008b10-ce37-4c6e-a647-38b5c3abc63b
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	eb0d7abe-c66d-4dfb-b105-bac4cb17a68c
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	ef920100-c0bb-4142-b391-95e8951de73c
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	6bdee376-8dc5-4b84-8879-7ae8df27a673
9cb775b9-a7ea-4b31-a2af-2cc0201ddabb	6bdee376-8dc5-4b84-8879-7ae8df27a673
9cb775b9-a7ea-4b31-a2af-2cc0201ddabb	20008b10-ce37-4c6e-a647-38b5c3abc63b
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	879c12f5-06ed-48f8-bd71-12bce31b5b1d
c00ccb81-8cbf-44de-a290-5b3be9faeb41	eb0d7abe-c66d-4dfb-b105-bac4cb17a68c
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	2e014269-00d8-42f1-b03f-7ad1151d6b2a
2e014269-00d8-42f1-b03f-7ad1151d6b2a	b3d44689-2af6-4650-a003-44c2dd544cc5
36b50b7d-eced-41e1-9370-b1df24a54192	861e979f-7b39-4378-acbd-3823a802b2a0
19499693-3f3d-4575-be63-c3ed9afc88de	a836c825-fbb0-4f9d-9c41-23742c1b8674
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	f379db11-cd8a-40bd-b123-78f946c3ad9e
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	c64d2516-8166-404b-9892-5777b03d9cd4
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	bf3673d6-7b3e-4e8a-ada2-dedf8d0546e7
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	bb3dec37-c604-4e9e-97bf-c6c5fe3af695
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
84a04aa1-a1c3-42d3-b2b5-c528debbbdf1	\N	password	fa91ad78-b9c6-4602-817e-638274475db7	1741602578417	\N	{"value":"N5lrBhngIxTxrLaWpDg4JEBEAAOUWFMrhVGX8n2FY4c=","salt":"RlgDS19VJCNm7wqI3ABerg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
2ca8f02c-caf2-4238-bbc5-a77f2ded8740	\N	password	449786a4-7f20-4e05-991c-56cab9308f52	1742055850434	My password	{"value":"0sxQcXcI7ErmDeoTo+Y3gXKIzfqbJzpMKUVAHadEdeg=","salt":"Oc53OIrAXsxCBCYCRkRkKg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
f5073359-a921-4c5c-86e1-de7b805479e8	\N	password	06b6403c-3ed0-425a-8a5d-92abaa530831	1745165013749	\N	{"value":"yJ+U/7cj/83p3r9sEOhVjWLgJky29VwDFWITBZKh5kA=","salt":"R83Aymrg1vxLZgfQb+7xjA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
490f624e-fa1b-49ed-8fac-d64bf7bbafe4	\N	password	ed11b48f-7d87-453a-96db-d102390f2859	1745165263419	My password	{"value":"QBzaDaE3VqQjAA7PsABOkiLDMoBi/Q8kfJL2Rn8vLhc=","salt":"ouDiMCuvptQ0Cwj7QaRJ7g==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
02d4ece3-078d-426c-b13f-aa8ab30404ef	\N	password	6c9af926-014e-4ef5-a05b-a75642c2eb68	1745676845509	\N	{"value":"+kCuDzQ/msiEZzNXs32WwfG7AsRnOCvNTo1EWK7sX+w=","salt":"zCRkzRQfjhvxVFCUKOeKNg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
65f46f77-7b76-41f4-9b30-6cd7742333c1	\N	password	8ed7fe37-abd3-4723-844d-e1fc50053e06	1745685747351	\N	{"value":"vmzcupUAB1Jq3HBoKrVebRH034HfEYNf+9nuPZw81k4=","salt":"bWWwhhHMIIzMYYIsa9U3Kg==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
72792def-3ed4-4aa9-ae93-b300bda8701b	\N	password	d9fb2ccd-813c-44fb-9ce7-67371c9c1be7	1747516277322	\N	{"value":"G+rSf+h1U4sa6VQ5ijjBmyEKKBDa1tqTv7XpDkjaWJs=","salt":"8aY42Fb2ESn7K/Xwl/nFGA==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-03-10 10:29:33.73178	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1602573525
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-03-10 10:29:33.744201	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	1602573525
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-03-10 10:29:33.764502	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	1602573525
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-03-10 10:29:33.766775	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1602573525
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-03-10 10:29:33.808465	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1602573525
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-03-10 10:29:33.812642	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	1602573525
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-03-10 10:29:33.848981	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1602573525
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-03-10 10:29:33.852782	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	1602573525
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-03-10 10:29:33.856374	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	1602573525
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-03-10 10:29:33.889922	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	1602573525
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-03-10 10:29:33.913273	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1602573525
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-03-10 10:29:33.915905	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1602573525
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-03-10 10:29:33.926269	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	1602573525
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-10 10:29:33.932142	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	1602573525
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-10 10:29:33.932998	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-10 10:29:33.934246	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	1602573525
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-03-10 10:29:33.935693	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	1602573525
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-03-10 10:29:33.953964	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	1602573525
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-03-10 10:29:33.96929	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1602573525
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-03-10 10:29:33.971217	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1602573525
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-10 10:29:33.972692	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	1602573525
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-03-10 10:29:33.973972	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	1602573525
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-03-10 10:29:34.01933	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	1602573525
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-03-10 10:29:34.023011	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1602573525
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-03-10 10:29:34.023757	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	1602573525
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-03-10 10:29:34.238318	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	1602573525
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-03-10 10:29:34.258157	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	1602573525
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-03-10 10:29:34.260181	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1602573525
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-03-10 10:29:34.273546	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	1602573525
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-03-10 10:29:34.27795	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	1602573525
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-03-10 10:29:34.285426	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	1602573525
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-03-10 10:29:34.287707	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	1602573525
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-10 10:29:34.290296	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-10 10:29:34.291398	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1602573525
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-10 10:29:34.300493	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	1602573525
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-03-10 10:29:34.303207	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	1602573525
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-03-10 10:29:34.304891	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1602573525
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-03-10 10:29:34.30643	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	1602573525
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-03-10 10:29:34.30783	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	1602573525
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-10 10:29:34.308425	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1602573525
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-10 10:29:34.309311	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	1602573525
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-03-10 10:29:34.311642	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	1602573525
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-03-10 10:29:35.200795	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	1602573525
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-03-10 10:29:35.203278	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	1602573525
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-10 10:29:35.205469	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1602573525
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-10 10:29:35.207624	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	1602573525
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-10 10:29:35.208935	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	1602573525
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-10 10:29:35.281257	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	1602573525
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-03-10 10:29:35.283406	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	1602573525
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-03-10 10:29:35.29451	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	1602573525
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-03-10 10:29:35.537736	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	1602573525
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-03-10 10:29:35.539867	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-03-10 10:29:35.54139	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	1602573525
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-03-10 10:29:35.543396	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	1602573525
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-10 10:29:35.545778	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	1602573525
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-10 10:29:35.547889	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	1602573525
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-10 10:29:35.576096	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	1602573525
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-03-10 10:29:35.828419	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	1602573525
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-03-10 10:29:35.842882	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	1602573525
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-03-10 10:29:35.8463	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	1602573525
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-10 10:29:35.85047	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	1602573525
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-03-10 10:29:35.853436	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	1602573525
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-03-10 10:29:35.854773	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1602573525
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-03-10 10:29:35.855916	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	1602573525
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-10 10:29:35.857078	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	1602573525
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-03-10 10:29:35.880681	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	1602573525
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-03-10 10:29:35.904672	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	1602573525
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-03-10 10:29:35.906899	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	1602573525
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-03-10 10:29:35.932735	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	1602573525
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-03-10 10:29:35.935217	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	1602573525
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-03-10 10:29:35.937427	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1602573525
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-10 10:29:35.941077	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1602573525
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-10 10:29:35.944185	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1602573525
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-10 10:29:35.94507	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	1602573525
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-10 10:29:35.956303	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	1602573525
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-03-10 10:29:35.983815	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	1602573525
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-10 10:29:35.985982	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	1602573525
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-10 10:29:35.986681	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	1602573525
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-10 10:29:35.994389	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	1602573525
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-03-10 10:29:35.995408	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	1602573525
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-10 10:29:36.01931	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	1602573525
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-10 10:29:36.020217	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1602573525
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-10 10:29:36.022188	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1602573525
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-10 10:29:36.022752	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	1602573525
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-03-10 10:29:36.045764	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1602573525
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-03-10 10:29:36.047943	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	1602573525
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-10 10:29:36.051102	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	1602573525
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-03-10 10:29:36.053658	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	1602573525
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.057053	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	1602573525
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.059657	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	1602573525
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.08583	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.093476	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	1602573525
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.094678	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1602573525
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.098733	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	1602573525
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.099919	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	1602573525
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-03-10 10:29:36.1032	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	1602573525
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.167263	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.168161	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.177315	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.213434	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.216583	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.243452	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	1602573525
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-03-10 10:29:36.245984	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	1602573525
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-03-10 10:29:36.249984	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	1602573525
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-03-10 10:29:36.27479	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	1602573525
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-03-10 10:29:36.299672	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1602573525
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-03-10 10:29:36.336761	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	1602573525
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-03-10 10:29:36.339271	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	1602573525
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-10 10:29:36.363489	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1602573525
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-10 10:29:36.364405	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	1602573525
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-03-10 10:29:36.36787	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-03-10 10:29:36.369593	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	1602573525
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-10 10:29:36.373799	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	1602573525
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-03-10 10:29:36.375185	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	1602573525
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-10 10:29:36.377636	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	1602573525
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-03-10 10:29:36.37818	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	1602573525
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-10 10:29:36.380093	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	1602573525
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-03-10 10:29:36.381121	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	1602573525
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-10 10:29:36.477072	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	1602573525
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-10 10:29:36.479326	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	1602573525
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-10 10:29:36.481978	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-03-10 10:29:36.505738	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-10 10:29:36.507495	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	1602573525
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-10 10:29:36.508026	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-03-10 10:29:36.508714	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.511428	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.532869	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.572444	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.609331	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.638455	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.667695	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.668775	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.698602	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	1602573525
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.70322	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1602573525
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.708619	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1602573525
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.709518	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	1602573525
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-03-10 10:29:36.763737	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	1602573525
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.767867	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	1602573525
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.772288	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	1602573525
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.801211	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	1602573525
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.803718	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	1602573525
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.806893	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1602573525
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.831666	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	1602573525
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.892298	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	1602573525
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.905479	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	1602573525
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.91187	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	1602573525
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-03-10 10:29:36.913305	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	1602573525
26.0.6-34013	keycloak	META-INF/jpa-changelog-26.0.6.xml	2025-03-10 10:29:36.91444	148	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	1602573525
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: declaration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.declaration (id, date_publication, demandeur_id, description, status, titre) FROM stdin;
4e49c395-6155-4504-ae2b-1e9ea1d502cb	2025-01-25 13:51:52.925	8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	Bonjour a tous. Nous sollicitons une aide pour notre camarade de classe gravement blessé par du gaz butane. Nous prions pour que le bon le remet dans ses activités. 	1	Blessure très grave 
311d896b-7902-442a-a2de-f6cb948ac25a	2025-02-25 13:07:20.101	fd9020d0-f05c-4f37-87db-6dafda5a0795	bonjour la famille nous sommes tristé par l'état de santé de notre frère qui a vraiment besoin d'aide pour son rétablissement. Nous vous invitons à l'aider vraiment pour son bien et celui de sa famille. Merci beaucoup 	1	malade très grave 
4153ab46-ec50-4252-8e5b-e93bcfe0caf3	2025-04-25 14:49:57.161	197737f2-b61e-4036-9c6e-6e999886f704	Bonjour la famille nous voulons vous faire part de notre conférence organisée par les étudiants en technologie pour parler des avancées technologiques 	1	Conférence de sensibilisation 
945e7474-1271-43d9-af91-9c69f53092f1	2025-02-25 15:07:11.818	8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	Bonjour nous avons le grand plaisir de vous convier à la cérémonie de graduation des étudiants de la section informatique de l'UCAD	1	graduation étudiants en informatique 
8419e399-4f51-48e3-8dd1-bb1fe0b2676c	2025-01-25 13:58:54.494	8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	Bonjour la famille. Nous sommes très inquiets de la situation de nos confrères dont leur maison est totalement prise par l'eau. Nous sollicitons grandement votre aide pour que cette famille dont les moyens ne sont pas assez grand puisse se retrouver 	0	Aide a la famille keita
a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	2025-05-25 14:07:53.943	197737f2-b61e-4036-9c6e-6e999886f704	Bonjour la famille. Nous voudrions vous partager un cas très urgent il s'agit d'une femme qui a besoin du sang pour sa survie. partager au max	1	besoin de sang en urgence 
2feabf0a-dd56-44c8-9029-84898df240f1	2025-03-15 17:49:41.663	449786a4-7f20-4e05-991c-56cab9308f52	bonjour la famille. nous sollicitons votre intervention pour la prise en charge de notre frère étudiant malade depuis quelques semaines 	0	malade mental 
\.


--
-- Data for Name: declaration_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.declaration_images (declaration_id, image_path) FROM stdin;
311d896b-7902-442a-a2de-f6cb948ac25a	f6fccbad-d974-4e91-9078-7f28047fbeff_1000130316.jpg
311d896b-7902-442a-a2de-f6cb948ac25a	b5ab1948-0c5c-4d09-93fc-c4ca5ee5c1d5_1000125370.jpg
311d896b-7902-442a-a2de-f6cb948ac25a	10589ab8-6e25-440a-a95e-4f039f224810_1000130316.jpg
4e49c395-6155-4504-ae2b-1e9ea1d502cb	0c29f627-73f5-446b-8e98-d8d508269414_1000130317.jpg
4e49c395-6155-4504-ae2b-1e9ea1d502cb	65dbe407-7308-4094-af00-613b6bb3e87c_1000130319.jpg
4e49c395-6155-4504-ae2b-1e9ea1d502cb	7559fce4-c593-41f0-b948-a170e48485e9_1000130318.jpg
8419e399-4f51-48e3-8dd1-bb1fe0b2676c	cc9882ba-3483-48ae-9963-f7389580f605_1000130397.jpg
8419e399-4f51-48e3-8dd1-bb1fe0b2676c	2687f130-e460-4410-8b28-b8fe910a7c27_1000130396.jpg
8419e399-4f51-48e3-8dd1-bb1fe0b2676c	760b6d74-2d10-47a0-b13c-87a91f50822c_1000130395.jpg
a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	e893695f-6cc3-4b19-a6af-e16b66bd5677_1000130317.jpg
4153ab46-ec50-4252-8e5b-e93bcfe0caf3	f393b7a7-7cf3-400c-bb0a-043705f13a51_1000130321.jpg
4153ab46-ec50-4252-8e5b-e93bcfe0caf3	e634ee34-670d-45b5-9c51-3811b03b17a4_1000130320.png
4153ab46-ec50-4252-8e5b-e93bcfe0caf3	228b0ec3-5429-4dbe-94b9-b964d2f502ef_1000130322.jpg
945e7474-1271-43d9-af91-9c69f53092f1	0a6811ae-d534-4677-9d79-69e44aba3df3_1000130419.jpg
945e7474-1271-43d9-af91-9c69f53092f1	0e57f580-8a7f-48da-aeab-d6aa09699597_1000130420.jpg
945e7474-1271-43d9-af91-9c69f53092f1	42d5b2cf-0b85-461a-847e-66b15b1ca68b_1000130419.jpg
2feabf0a-dd56-44c8-9029-84898df240f1	dea639c5-3103-404e-ad9e-213012650492_Don-de-sang.jpg
2feabf0a-dd56-44c8-9029-84898df240f1	efbfb5aa-63db-4963-9daa-fbf2e490bb12_1000130323.jpg
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	ea3fbc04-f7ec-4127-aeb1-9c3a0b3e541b	f
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	af020923-9a0e-4d3e-91b6-efcdf16cb6bf	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	8d3925fe-94e4-4d0a-9ea3-f3b3f001ffbb	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	52a04847-6d6d-4f02-8f18-bc83483dade8	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	7ba3d400-2fe4-4ffe-8959-49129ff8ff92	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	6f2162fa-eb28-4c2d-be8a-5672026f848d	f
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	1a19eecb-1a7c-455f-a08d-64d9755e5a5e	f
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	2e9927c6-16b3-4e92-8f4d-6121cb97c6df	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	a989dadc-5d7e-4058-9272-33faeafb49b7	f
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4ee44bac-20d8-4734-81f2-9a8108086b4d	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	67a6b883-b10b-43ad-85fc-25c6003a31cc	t
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5	f
782a628f-1571-41ed-8beb-5caf97452730	53be55b0-38f9-44b7-8090-9ff42c74f389	f
782a628f-1571-41ed-8beb-5caf97452730	e1ab76f5-3cb7-4b26-80b0-c091e1c1652a	t
782a628f-1571-41ed-8beb-5caf97452730	1640d91f-0ebc-40a4-b254-3234a0f41478	t
782a628f-1571-41ed-8beb-5caf97452730	301d59fa-0c3b-47bf-af84-dfa38440c6e2	t
782a628f-1571-41ed-8beb-5caf97452730	591043e6-53cb-49e0-8a27-342d20ddd65d	t
782a628f-1571-41ed-8beb-5caf97452730	59e9840e-606b-4310-87c5-3a1a4caeb1bc	f
782a628f-1571-41ed-8beb-5caf97452730	cc410a9a-c9d7-479a-a6f2-388b65d8a198	f
782a628f-1571-41ed-8beb-5caf97452730	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd	t
782a628f-1571-41ed-8beb-5caf97452730	5fe49fc5-ac60-4d59-b369-9bc2384649ae	t
782a628f-1571-41ed-8beb-5caf97452730	9d34a5e9-e1be-4639-8ee4-ced4d108f609	f
782a628f-1571-41ed-8beb-5caf97452730	aeaff1ce-9975-4a7f-b612-4e332d6cfada	t
782a628f-1571-41ed-8beb-5caf97452730	b32cd6b8-7a19-4c94-beb6-80bb25618ee3	t
782a628f-1571-41ed-8beb-5caf97452730	e875fd32-23d1-4433-aa2e-15bd8bf8c608	f
\.


--
-- Data for Name: demande_donde_sang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demande_donde_sang (adresse, classe, rhesus, id) FROM stdin;
Fass Delorme 	1	0	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d
\.


--
-- Data for Name: demandeur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.demandeur (adresse, id) FROM stdin;
\.


--
-- Data for Name: don; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don (id, date_publication, declaration_id, donateur_id, type) FROM stdin;
8af7a34a-0afa-4e52-8134-3f761117440c	2024-09-26 13:21:47.331819	8419e399-4f51-48e3-8dd1-bb1fe0b2676c	8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	2
a33818f0-a6a5-4ffd-b858-531ea3879030	2024-09-26 13:27:56.775035	945e7474-1271-43d9-af91-9c69f53092f1	fd9020d0-f05c-4f37-87db-6dafda5a0795	1
497767f9-1a19-4f19-b961-8b26c36906ba	2024-09-26 13:51:59.291147	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	fd9020d0-f05c-4f37-87db-6dafda5a0795	3
41844109-ff2e-4b05-b940-f51e14783da5	2024-09-26 13:54:21.380026	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	fd9020d0-f05c-4f37-87db-6dafda5a0795	3
85f81b25-cac6-4b1b-8f0c-ceb43ca14c41	2024-09-26 13:56:47.139104	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	fd9020d0-f05c-4f37-87db-6dafda5a0795	3
63682cf9-09d7-4c83-ad5e-843380cda2ea	2024-09-26 14:02:33.196005	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	fd9020d0-f05c-4f37-87db-6dafda5a0795	3
60314c51-7c85-401c-8a2e-ea2744570c94	2024-09-26 14:06:27.37218	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	fd9020d0-f05c-4f37-87db-6dafda5a0795	3
60314c51-7c85-401c-8a2e-ea2744570huf	2025-04-05 18:51:18	311d896b-7902-442a-a2de-f6cb948ac25a	449786a4-7f20-4e05-991c-56cab9308f52	0
aa48a378-aeaf-4e7c-adcf-eb94bf5298e3	2025-04-05 18:57:39.828781	a36f3fdb-8680-4a5b-ab9c-fc650b357b4d	449786a4-7f20-4e05-991c-56cab9308f52	3
\.


--
-- Data for Name: don_espece; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don_espece (montant, id) FROM stdin;
200	60314c51-7c85-401c-8a2e-ea2744570huf
\.


--
-- Data for Name: don_materiel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don_materiel (description, titre, id) FROM stdin;
bonjour chers étudiants je peux vous apporter ma bâche très neuve pour la réussite de votre événement.	Apport de bache	a33818f0-a6a5-4ffd-b858-531ea3879030
\.


--
-- Data for Name: don_materiel_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don_materiel_images (don_id, image_path) FROM stdin;
a33818f0-a6a5-4ffd-b858-531ea3879030	34b0b6f3-bdd1-4538-8aac-7464f2fbe093_1000130886.jpg
a33818f0-a6a5-4ffd-b858-531ea3879030	dc76345a-9ac5-4bde-a98f-b5da4b03baed_1000130886.jpg
a33818f0-a6a5-4ffd-b858-531ea3879030	571eac9f-622c-4eeb-8d6b-3506ba124f02_1000130887.jpg
\.


--
-- Data for Name: don_sang; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.don_sang (adresse_donnateur, id) FROM stdin;
Sandiara 	497767f9-1a19-4f19-b961-8b26c36906ba
Sandiara	41844109-ff2e-4b05-b940-f51e14783da5
Sandiara 	85f81b25-cac6-4b1b-8f0c-ceb43ca14c41
Mbour 	63682cf9-09d7-4c83-ad5e-843380cda2ea
Mbour 	60314c51-7c85-401c-8a2e-ea2744570c94
fass Delorme 	aa48a378-aeaf-4e7c-adcf-eb94bf5298e3
\.


--
-- Data for Name: donnateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.donnateur (type, id) FROM stdin;
\.


--
-- Data for Name: evenement; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.evenement (date_debut, date_fin, lieu, type, id) FROM stdin;
2024-10-01 10:00:00	2024-10-01 18:00:00	UCAD	3	4153ab46-ec50-4252-8e5b-e93bcfe0caf3
2024-10-19 09:00:00	2024-10-19 17:00:00	UCAD	4	945e7474-1271-43d9-af91-9c69f53092f1
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
google	782a628f-1571-41ed-8beb-5caf97452730	115750163106914558001	senemamadou1999@gmail.com	\N	449786a4-7f20-4e05-991c-56cab9308f52
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
1cfb4807-44ba-4b5b-aa69-2557df95574b	t	google	google	f	f	782a628f-1571-41ed-8beb-5caf97452730	f	f	\N	\N		f	\N	f
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
1cfb4807-44ba-4b5b-aa69-2557df95574b	860119580292-4iubh6gklot7sc8ch1bpe160f03hjfne.apps.googleusercontent.com	clientId
1cfb4807-44ba-4b5b-aa69-2557df95574b	false	acceptsPromptNoneForwardFromClient
1cfb4807-44ba-4b5b-aa69-2557df95574b	false	disableUserInfo
1cfb4807-44ba-4b5b-aa69-2557df95574b	LEGACY	syncMode
1cfb4807-44ba-4b5b-aa69-2557df95574b	false	filteredByClaim
1cfb4807-44ba-4b5b-aa69-2557df95574b	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	clientSecret
1cfb4807-44ba-4b5b-aa69-2557df95574b	false	caseSensitiveOriginalUsername
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
1584521d-e96a-4219-920b-54cb047069f0	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	${role_default-roles}	default-roles-master	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	\N
19499693-3f3d-4575-be63-c3ed9afc88de	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	${role_admin}	admin	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	\N
6f7e4822-8ef3-48c4-86c6-978030e8f0eb	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	${role_create-realm}	create-realm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	\N
21ee9388-519f-4170-bfb9-a9ba9a39d6cb	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_create-client}	create-client	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
42dc9f72-7287-4b6a-a1e8-117ff588b8dc	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-realm}	view-realm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
edeb5da8-487f-470c-8384-5311e0594299	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-users}	view-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
c2a441ac-d938-45e8-a53a-963ca3f10dc3	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-clients}	view-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
81c6611c-2c2b-45dc-92ac-809b6c624822	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-events}	view-events	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
80ffe453-8211-4305-9fb8-f589c777060d	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-identity-providers}	view-identity-providers	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
40425ce7-fb16-47e9-bc9b-9748e5b64b1b	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_view-authorization}	view-authorization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
b1366d6b-2fd4-44eb-b3bc-f17160ae0872	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-realm}	manage-realm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
3bbdd7f9-38ad-4b3f-a270-3bd7b3ea7b9f	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-users}	manage-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
3e3f9a0f-7600-43cb-96c6-fcce49b420d8	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-clients}	manage-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
f39c3282-e513-4102-aa22-b2c049ca92d5	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-events}	manage-events	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
064afe56-dc44-4c02-bcd7-b428d0afb19e	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-identity-providers}	manage-identity-providers	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
97b3e2cb-f1e0-47b4-b645-771d10cf09a6	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_manage-authorization}	manage-authorization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
37a24f46-78ff-4554-8b65-442e1739f7a7	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_query-users}	query-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
e907c83d-a4f5-42f7-9d75-9206d74d05e5	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_query-clients}	query-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
56f746cf-442e-4625-b114-42fd72127834	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_query-realms}	query-realms	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
f51515a2-f091-465c-803b-38538d7d6d1d	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_query-groups}	query-groups	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
0da75ac0-8ce2-44a6-abae-5ea5b1a9f570	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_view-profile}	view-profile	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
b7bf31a7-5872-4bac-96bd-59df685832b9	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_manage-account}	manage-account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
03ab61e8-63f5-4bb5-b396-9b270e8977a3	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_manage-account-links}	manage-account-links	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
6097405c-88e5-4374-ad75-d1c081f954bf	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_view-applications}	view-applications	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
51a9fe44-1634-4b38-994f-db12e9a44076	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_view-consent}	view-consent	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
318fa365-790e-4db2-a39a-a7789df40c2f	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_manage-consent}	manage-consent	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
2b3ec696-dd0f-46e2-8cbc-8b3157600ce4	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_view-groups}	view-groups	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
e9a92700-2779-45a2-8f09-e5054e2dd3ea	e0217878-83bc-476b-bb1e-e4da9707c785	t	${role_delete-account}	delete-account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	e0217878-83bc-476b-bb1e-e4da9707c785	\N
8dc578b8-6baa-4f97-9439-0e909f25345a	9bea9ff6-31e0-490c-8a73-cf5ad54067c6	t	${role_read-token}	read-token	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	9bea9ff6-31e0-490c-8a73-cf5ad54067c6	\N
cb21bc8b-fde5-4897-8493-2d32206ada48	88109d9b-350a-4f67-b7ba-ace54b4b53a3	t	${role_impersonation}	impersonation	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	88109d9b-350a-4f67-b7ba-ace54b4b53a3	\N
2f0bada1-11ab-461d-8e7d-ced9e6c688db	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	${role_offline-access}	offline_access	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	\N
8d2cd375-f41b-44c3-8931-804c5d70979b	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	${role_uma_authorization}	uma_authorization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	\N	\N
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	782a628f-1571-41ed-8beb-5caf97452730	f	${role_default-roles}	default-roles-teranga_realm	782a628f-1571-41ed-8beb-5caf97452730	\N	\N
eb932124-80cd-48e0-af46-68676ad74e2b	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_create-client}	create-client	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
b1b9fe3a-1ef7-429a-b013-3d6f2c65df37	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-realm}	view-realm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
3a413a8b-f572-460c-8bf6-e35c69bde04c	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-users}	view-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
ad4eab25-0134-4d0a-94d9-d9ad16b7ed07	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-clients}	view-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
c3a8f67e-bf69-4fd3-9ee9-84753547b4e4	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-events}	view-events	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
a2c4a88b-0ed0-4bc2-a601-50813de3b2cb	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-identity-providers}	view-identity-providers	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
52d2e40e-8d8b-4cdb-b4a9-716345013208	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_view-authorization}	view-authorization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
a62aeb87-00fb-4028-9b56-b692467fb4a0	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-realm}	manage-realm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
228c24a6-9fe5-4e4b-843b-3748d10f43ed	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-users}	manage-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
cbbf3a8c-a235-4298-b2c4-4c950779065b	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-clients}	manage-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
4de42f70-5f30-433e-9bd3-f013c536cea6	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-events}	manage-events	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
0ba0d2a6-fa68-4356-9090-7efcef4e5534	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-identity-providers}	manage-identity-providers	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
4e1ea600-0f72-4f13-8d62-9c115af5a5cd	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_manage-authorization}	manage-authorization	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
dbd1964b-4d71-4257-bb26-8ad70432beb9	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_query-users}	query-users	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
19a50ab6-1583-4cbb-acb2-e4011dc8617a	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_query-clients}	query-clients	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
9d58a61e-80e0-489a-a8e7-9781f83688ee	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_query-realms}	query-realms	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
23c3dc80-0d2b-43ce-8c04-3ff662ed4795	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_query-groups}	query-groups	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
9d884754-2fc5-4736-8ab1-ce84ebf0bdb8	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_realm-admin}	realm-admin	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
60d48f79-7aa1-4ec3-bff6-f217be3f43e9	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_create-client}	create-client	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
0338fe9a-f4a3-421c-811d-d442eb88c1b2	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-realm}	view-realm	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
9cb775b9-a7ea-4b31-a2af-2cc0201ddabb	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-users}	view-users	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
c00ccb81-8cbf-44de-a290-5b3be9faeb41	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-clients}	view-clients	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
5c9c5641-0f0f-4fb0-b995-ebb9adf48275	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-events}	view-events	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
0c161f58-39a6-4cf1-aa46-f4dad4f0736a	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-identity-providers}	view-identity-providers	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
0711c599-2484-42ea-b309-47e5ddbc242e	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_view-authorization}	view-authorization	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
f59e6a73-f164-4720-a52c-a806243de705	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-realm}	manage-realm	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
983b2c53-0ea0-4889-8139-2e41c2bd3f5a	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-users}	manage-users	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
e771aea2-b101-4bfb-9598-7611adce26a5	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-clients}	manage-clients	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
1d1686cd-2aca-4995-86a4-62437877b35e	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-events}	manage-events	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
12ecb97f-37f6-495a-b1e3-1e37f5b3c50a	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-identity-providers}	manage-identity-providers	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
e3653591-bd33-45a7-b359-74c46a469a7b	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_manage-authorization}	manage-authorization	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
20008b10-ce37-4c6e-a647-38b5c3abc63b	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_query-users}	query-users	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
eb0d7abe-c66d-4dfb-b105-bac4cb17a68c	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_query-clients}	query-clients	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
ef920100-c0bb-4142-b391-95e8951de73c	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_query-realms}	query-realms	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
6bdee376-8dc5-4b84-8879-7ae8df27a673	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_query-groups}	query-groups	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
879c12f5-06ed-48f8-bd71-12bce31b5b1d	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_view-profile}	view-profile	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
2e014269-00d8-42f1-b03f-7ad1151d6b2a	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_manage-account}	manage-account	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
b3d44689-2af6-4650-a003-44c2dd544cc5	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_manage-account-links}	manage-account-links	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
9f989d81-0dc7-4025-b30e-bc0a2dc9d4a1	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_view-applications}	view-applications	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
861e979f-7b39-4378-acbd-3823a802b2a0	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_view-consent}	view-consent	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
36b50b7d-eced-41e1-9370-b1df24a54192	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_manage-consent}	manage-consent	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
1cc3bfa9-1d57-436e-947e-346e00012580	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_view-groups}	view-groups	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
9144f237-3c01-45c4-83e4-b15ccb946a5c	a333915a-1b01-4ca0-9941-81f18ca387d9	t	${role_delete-account}	delete-account	782a628f-1571-41ed-8beb-5caf97452730	a333915a-1b01-4ca0-9941-81f18ca387d9	\N
a836c825-fbb0-4f9d-9c41-23742c1b8674	142a2b85-9f20-4618-82a3-f86fa2d7276b	t	${role_impersonation}	impersonation	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	142a2b85-9f20-4618-82a3-f86fa2d7276b	\N
f379db11-cd8a-40bd-b123-78f946c3ad9e	c98187f5-233e-47df-990a-c1213d8fc7bf	t	${role_impersonation}	impersonation	782a628f-1571-41ed-8beb-5caf97452730	c98187f5-233e-47df-990a-c1213d8fc7bf	\N
6c943a07-b99d-4be3-9669-50072698f726	f24250e5-5a9a-4983-9a8c-53f8bf4721ee	t	${role_read-token}	read-token	782a628f-1571-41ed-8beb-5caf97452730	f24250e5-5a9a-4983-9a8c-53f8bf4721ee	\N
c64d2516-8166-404b-9892-5777b03d9cd4	782a628f-1571-41ed-8beb-5caf97452730	f	${role_offline-access}	offline_access	782a628f-1571-41ed-8beb-5caf97452730	\N	\N
bf3673d6-7b3e-4e8a-ada2-dedf8d0546e7	782a628f-1571-41ed-8beb-5caf97452730	f	${role_uma_authorization}	uma_authorization	782a628f-1571-41ed-8beb-5caf97452730	\N	\N
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	782a628f-1571-41ed-8beb-5caf97452730	f		USER	782a628f-1571-41ed-8beb-5caf97452730	\N	\N
d17201cc-b72f-4d6d-a94e-de523e985c0c	782a628f-1571-41ed-8beb-5caf97452730	f		ADMIN	782a628f-1571-41ed-8beb-5caf97452730	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
xhd1g	26.0.7	1741602577
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: pret; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pret (description, duree, titre, id) FROM stdin;
Bonjour. je pourrais leur prêter ma maison presque entièrement construite pour quelques temps 	60	prêt de maison	8af7a34a-0afa-4e52-8134-3f761117440c
\.


--
-- Data for Name: pret_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pret_images (pret_id, image_path) FROM stdin;
8af7a34a-0afa-4e52-8134-3f761117440c	7d7f92c4-731f-447d-9211-08d313dd44d1_1000130888.jpg
8af7a34a-0afa-4e52-8134-3f761117440c	4104202a-c01f-4b1b-aef5-50a009d85620_1000130889.jpg
8af7a34a-0afa-4e52-8134-3f761117440c	14abc18f-779b-4454-8762-595f3b2b2644_1000130890.png
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
4cc993ab-7c93-4ddd-aea7-11d13b5669b9	audience resolve	openid-connect	oidc-audience-resolve-mapper	1e2b4826-d794-4029-869b-ca5b7543cd0c	\N
2926e332-0c6f-4415-9e70-72828df84ee3	locale	openid-connect	oidc-usermodel-attribute-mapper	9d7bd522-e633-4aa9-8492-8e600fc28621	\N
09aa93a7-d598-45fc-b519-b479bb89a150	role list	saml	saml-role-list-mapper	\N	af020923-9a0e-4d3e-91b6-efcdf16cb6bf
2ce85cc9-b820-4167-92ce-5ee2d91c03f6	organization	saml	saml-organization-membership-mapper	\N	8d3925fe-94e4-4d0a-9ea3-f3b3f001ffbb
6021fa4d-b62b-422a-8dd3-17db13e9f911	full name	openid-connect	oidc-full-name-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
5a757df6-b23b-4051-94bc-48c0404e0291	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
0617457c-b686-4f7a-a107-4f3a84ede392	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
4c2eb183-252f-467c-ae89-454b59c5f9ea	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
584a019f-e348-4a5b-8ccc-7733920280b1	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
0aa766a1-e3b9-46dc-af8b-44344c343375	username	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
10501b2b-aabf-47a4-8431-9f7180384f90	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
3fc79ab1-e138-4e78-86ac-46d1bd140596	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
9b264ada-ed15-447c-b571-9436d03faa1c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
28075d41-90f4-4592-adbe-d41482dcdbb1	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
13039d9e-d1a3-4a98-9ec5-b1609a216e40	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
819d32a8-73a4-4acc-9375-797be4d3d63d	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
da70d05b-cd38-4263-8c0a-f0281d222d30	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	52a04847-6d6d-4f02-8f18-bc83483dade8
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	email	openid-connect	oidc-usermodel-attribute-mapper	\N	7ba3d400-2fe4-4ffe-8959-49129ff8ff92
7b8abe3e-43bf-4337-854f-3bd4e3063aac	email verified	openid-connect	oidc-usermodel-property-mapper	\N	7ba3d400-2fe4-4ffe-8959-49129ff8ff92
efde3017-01b3-481c-951a-ecdffb260186	address	openid-connect	oidc-address-mapper	\N	6f2162fa-eb28-4c2d-be8a-5672026f848d
e3ad032c-a73e-48f5-9794-54aea5423cf2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	1a19eecb-1a7c-455f-a08d-64d9755e5a5e
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	1a19eecb-1a7c-455f-a08d-64d9755e5a5e
b54fa05f-434f-48fa-8b13-e20d405aff97	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	2e9927c6-16b3-4e92-8f4d-6121cb97c6df
6f10a168-313d-468d-ae3c-8b2d10d5730f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	2e9927c6-16b3-4e92-8f4d-6121cb97c6df
85071c48-29ef-4792-b8e0-d536fb2f0b45	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	2e9927c6-16b3-4e92-8f4d-6121cb97c6df
61bfe63c-29ca-41a1-b12b-1243593e4c6d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	4433cd49-d7f4-441c-b84a-fdd5e4f2ac83
63155fe9-f87b-4a47-a1f4-392562217db5	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	a989dadc-5d7e-4058-9272-33faeafb49b7
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	a989dadc-5d7e-4058-9272-33faeafb49b7
258035f6-61ed-4b44-9ceb-2cff01e8a9ca	acr loa level	openid-connect	oidc-acr-mapper	\N	4ee44bac-20d8-4734-81f2-9a8108086b4d
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	67a6b883-b10b-43ad-85fc-25c6003a31cc
f3e27c7a-5f87-4e1a-a2af-0759e94efc68	sub	openid-connect	oidc-sub-mapper	\N	67a6b883-b10b-43ad-85fc-25c6003a31cc
60cc4ec6-6b05-4b18-b838-bb58a09b216d	organization	openid-connect	oidc-organization-membership-mapper	\N	aa18a1d9-e7ee-4a3c-acd2-9dd4778c67b5
f4cd079d-2bb5-42b3-917f-674067576b26	audience resolve	openid-connect	oidc-audience-resolve-mapper	d310d34c-f0a0-4e13-94d2-e51cae8be5a8	\N
03cc7b87-836d-406c-bef6-4fe4b7d8fc24	role list	saml	saml-role-list-mapper	\N	e1ab76f5-3cb7-4b26-80b0-c091e1c1652a
edb7677d-e322-45ce-a47d-f4894879f2e2	organization	saml	saml-organization-membership-mapper	\N	1640d91f-0ebc-40a4-b254-3234a0f41478
5547e528-dde2-45dd-ada5-4b5d554ed9a1	full name	openid-connect	oidc-full-name-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
9d9761c7-5c43-4be0-a0b6-85009e940d81	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
2737244c-1fb1-4f7b-8e92-db0644242ace	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
4b76a7dc-e901-497e-9bf7-c19b5093156d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
60eca152-2987-4ee9-bf04-d807241c66c4	username	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
8a59687d-7929-4315-85d1-36e1f4ad0ceb	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
049aafda-b537-48d4-b3f0-a44b96e1904d	website	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
e0686b44-10b7-4212-a1e7-716483fbe105	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
ae7c33a5-5942-4484-aa90-8c5226f694da	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
a50e7a0b-62df-480d-b220-c355d18cf505	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
955cdee1-cc14-49c4-9144-741c9bc226cf	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
fde6bdf0-f98e-41c4-8950-24b05eb88503	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	301d59fa-0c3b-47bf-af84-dfa38440c6e2
1b9bc368-2d9d-4882-9920-fdf99fa4e711	email	openid-connect	oidc-usermodel-attribute-mapper	\N	591043e6-53cb-49e0-8a27-342d20ddd65d
d115fc0d-38ca-44fb-ac41-7b071e87589d	email verified	openid-connect	oidc-usermodel-property-mapper	\N	591043e6-53cb-49e0-8a27-342d20ddd65d
50329e21-3196-40ac-820c-a213c7c06afe	address	openid-connect	oidc-address-mapper	\N	59e9840e-606b-4310-87c5-3a1a4caeb1bc
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	cc410a9a-c9d7-479a-a6f2-388b65d8a198
80ae79b1-3112-4895-aaa1-7398310a0b3e	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	cc410a9a-c9d7-479a-a6f2-388b65d8a198
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd
8a5e092a-fa77-4159-9c38-372f586a04a6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd
1e75f037-444b-4e01-8357-baa6fb8e8b36	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	18971c2f-254f-4a9f-8aa3-2e1597c2e9cd
c58bb144-9571-4046-80c5-bb0e49a6ffc4	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	5fe49fc5-ac60-4d59-b369-9bc2384649ae
3df247b7-df9c-477b-bd39-e66222cc7bc1	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	9d34a5e9-e1be-4639-8ee4-ced4d108f609
599a9cb2-b1b0-45b3-a5e6-69616431203a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	9d34a5e9-e1be-4639-8ee4-ced4d108f609
a5d3eb5d-d77a-4a45-8727-6a1c07e65b24	acr loa level	openid-connect	oidc-acr-mapper	\N	aeaff1ce-9975-4a7f-b612-4e332d6cfada
8aa3c75c-1546-4b08-9b93-b3990f82325d	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	b32cd6b8-7a19-4c94-beb6-80bb25618ee3
e6f36c3d-4ae5-49ec-8eff-2fa15acb6355	sub	openid-connect	oidc-sub-mapper	\N	b32cd6b8-7a19-4c94-beb6-80bb25618ee3
b83c7540-d562-4584-8870-d7042a7e9c7e	organization	openid-connect	oidc-organization-membership-mapper	\N	e875fd32-23d1-4433-aa2e-15bd8bf8c608
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	locale	openid-connect	oidc-usermodel-attribute-mapper	2793ce4a-5ecb-4800-9476-072b62529f6f	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
2926e332-0c6f-4415-9e70-72828df84ee3	true	introspection.token.claim
2926e332-0c6f-4415-9e70-72828df84ee3	true	userinfo.token.claim
2926e332-0c6f-4415-9e70-72828df84ee3	locale	user.attribute
2926e332-0c6f-4415-9e70-72828df84ee3	true	id.token.claim
2926e332-0c6f-4415-9e70-72828df84ee3	true	access.token.claim
2926e332-0c6f-4415-9e70-72828df84ee3	locale	claim.name
2926e332-0c6f-4415-9e70-72828df84ee3	String	jsonType.label
09aa93a7-d598-45fc-b519-b479bb89a150	false	single
09aa93a7-d598-45fc-b519-b479bb89a150	Basic	attribute.nameformat
09aa93a7-d598-45fc-b519-b479bb89a150	Role	attribute.name
0617457c-b686-4f7a-a107-4f3a84ede392	true	introspection.token.claim
0617457c-b686-4f7a-a107-4f3a84ede392	true	userinfo.token.claim
0617457c-b686-4f7a-a107-4f3a84ede392	firstName	user.attribute
0617457c-b686-4f7a-a107-4f3a84ede392	true	id.token.claim
0617457c-b686-4f7a-a107-4f3a84ede392	true	access.token.claim
0617457c-b686-4f7a-a107-4f3a84ede392	given_name	claim.name
0617457c-b686-4f7a-a107-4f3a84ede392	String	jsonType.label
0aa766a1-e3b9-46dc-af8b-44344c343375	true	introspection.token.claim
0aa766a1-e3b9-46dc-af8b-44344c343375	true	userinfo.token.claim
0aa766a1-e3b9-46dc-af8b-44344c343375	username	user.attribute
0aa766a1-e3b9-46dc-af8b-44344c343375	true	id.token.claim
0aa766a1-e3b9-46dc-af8b-44344c343375	true	access.token.claim
0aa766a1-e3b9-46dc-af8b-44344c343375	preferred_username	claim.name
0aa766a1-e3b9-46dc-af8b-44344c343375	String	jsonType.label
10501b2b-aabf-47a4-8431-9f7180384f90	true	introspection.token.claim
10501b2b-aabf-47a4-8431-9f7180384f90	true	userinfo.token.claim
10501b2b-aabf-47a4-8431-9f7180384f90	profile	user.attribute
10501b2b-aabf-47a4-8431-9f7180384f90	true	id.token.claim
10501b2b-aabf-47a4-8431-9f7180384f90	true	access.token.claim
10501b2b-aabf-47a4-8431-9f7180384f90	profile	claim.name
10501b2b-aabf-47a4-8431-9f7180384f90	String	jsonType.label
13039d9e-d1a3-4a98-9ec5-b1609a216e40	true	introspection.token.claim
13039d9e-d1a3-4a98-9ec5-b1609a216e40	true	userinfo.token.claim
13039d9e-d1a3-4a98-9ec5-b1609a216e40	zoneinfo	user.attribute
13039d9e-d1a3-4a98-9ec5-b1609a216e40	true	id.token.claim
13039d9e-d1a3-4a98-9ec5-b1609a216e40	true	access.token.claim
13039d9e-d1a3-4a98-9ec5-b1609a216e40	zoneinfo	claim.name
13039d9e-d1a3-4a98-9ec5-b1609a216e40	String	jsonType.label
28075d41-90f4-4592-adbe-d41482dcdbb1	true	introspection.token.claim
28075d41-90f4-4592-adbe-d41482dcdbb1	true	userinfo.token.claim
28075d41-90f4-4592-adbe-d41482dcdbb1	birthdate	user.attribute
28075d41-90f4-4592-adbe-d41482dcdbb1	true	id.token.claim
28075d41-90f4-4592-adbe-d41482dcdbb1	true	access.token.claim
28075d41-90f4-4592-adbe-d41482dcdbb1	birthdate	claim.name
28075d41-90f4-4592-adbe-d41482dcdbb1	String	jsonType.label
3fc79ab1-e138-4e78-86ac-46d1bd140596	true	introspection.token.claim
3fc79ab1-e138-4e78-86ac-46d1bd140596	true	userinfo.token.claim
3fc79ab1-e138-4e78-86ac-46d1bd140596	picture	user.attribute
3fc79ab1-e138-4e78-86ac-46d1bd140596	true	id.token.claim
3fc79ab1-e138-4e78-86ac-46d1bd140596	true	access.token.claim
3fc79ab1-e138-4e78-86ac-46d1bd140596	picture	claim.name
3fc79ab1-e138-4e78-86ac-46d1bd140596	String	jsonType.label
4c2eb183-252f-467c-ae89-454b59c5f9ea	true	introspection.token.claim
4c2eb183-252f-467c-ae89-454b59c5f9ea	true	userinfo.token.claim
4c2eb183-252f-467c-ae89-454b59c5f9ea	middleName	user.attribute
4c2eb183-252f-467c-ae89-454b59c5f9ea	true	id.token.claim
4c2eb183-252f-467c-ae89-454b59c5f9ea	true	access.token.claim
4c2eb183-252f-467c-ae89-454b59c5f9ea	middle_name	claim.name
4c2eb183-252f-467c-ae89-454b59c5f9ea	String	jsonType.label
584a019f-e348-4a5b-8ccc-7733920280b1	true	introspection.token.claim
584a019f-e348-4a5b-8ccc-7733920280b1	true	userinfo.token.claim
584a019f-e348-4a5b-8ccc-7733920280b1	nickname	user.attribute
584a019f-e348-4a5b-8ccc-7733920280b1	true	id.token.claim
584a019f-e348-4a5b-8ccc-7733920280b1	true	access.token.claim
584a019f-e348-4a5b-8ccc-7733920280b1	nickname	claim.name
584a019f-e348-4a5b-8ccc-7733920280b1	String	jsonType.label
5a757df6-b23b-4051-94bc-48c0404e0291	true	introspection.token.claim
5a757df6-b23b-4051-94bc-48c0404e0291	true	userinfo.token.claim
5a757df6-b23b-4051-94bc-48c0404e0291	lastName	user.attribute
5a757df6-b23b-4051-94bc-48c0404e0291	true	id.token.claim
5a757df6-b23b-4051-94bc-48c0404e0291	true	access.token.claim
5a757df6-b23b-4051-94bc-48c0404e0291	family_name	claim.name
5a757df6-b23b-4051-94bc-48c0404e0291	String	jsonType.label
6021fa4d-b62b-422a-8dd3-17db13e9f911	true	introspection.token.claim
6021fa4d-b62b-422a-8dd3-17db13e9f911	true	userinfo.token.claim
6021fa4d-b62b-422a-8dd3-17db13e9f911	true	id.token.claim
6021fa4d-b62b-422a-8dd3-17db13e9f911	true	access.token.claim
819d32a8-73a4-4acc-9375-797be4d3d63d	true	introspection.token.claim
819d32a8-73a4-4acc-9375-797be4d3d63d	true	userinfo.token.claim
819d32a8-73a4-4acc-9375-797be4d3d63d	locale	user.attribute
819d32a8-73a4-4acc-9375-797be4d3d63d	true	id.token.claim
819d32a8-73a4-4acc-9375-797be4d3d63d	true	access.token.claim
819d32a8-73a4-4acc-9375-797be4d3d63d	locale	claim.name
819d32a8-73a4-4acc-9375-797be4d3d63d	String	jsonType.label
9b264ada-ed15-447c-b571-9436d03faa1c	true	introspection.token.claim
9b264ada-ed15-447c-b571-9436d03faa1c	true	userinfo.token.claim
9b264ada-ed15-447c-b571-9436d03faa1c	website	user.attribute
9b264ada-ed15-447c-b571-9436d03faa1c	true	id.token.claim
9b264ada-ed15-447c-b571-9436d03faa1c	true	access.token.claim
9b264ada-ed15-447c-b571-9436d03faa1c	website	claim.name
9b264ada-ed15-447c-b571-9436d03faa1c	String	jsonType.label
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	true	introspection.token.claim
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	true	userinfo.token.claim
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	gender	user.attribute
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	true	id.token.claim
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	true	access.token.claim
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	gender	claim.name
b86e38eb-81f5-4ff5-9b0d-e7267e65d057	String	jsonType.label
da70d05b-cd38-4263-8c0a-f0281d222d30	true	introspection.token.claim
da70d05b-cd38-4263-8c0a-f0281d222d30	true	userinfo.token.claim
da70d05b-cd38-4263-8c0a-f0281d222d30	updatedAt	user.attribute
da70d05b-cd38-4263-8c0a-f0281d222d30	true	id.token.claim
da70d05b-cd38-4263-8c0a-f0281d222d30	true	access.token.claim
da70d05b-cd38-4263-8c0a-f0281d222d30	updated_at	claim.name
da70d05b-cd38-4263-8c0a-f0281d222d30	long	jsonType.label
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	true	introspection.token.claim
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	true	userinfo.token.claim
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	email	user.attribute
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	true	id.token.claim
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	true	access.token.claim
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	email	claim.name
32b5e5a9-dc25-4a8b-9b77-77935591b9ba	String	jsonType.label
7b8abe3e-43bf-4337-854f-3bd4e3063aac	true	introspection.token.claim
7b8abe3e-43bf-4337-854f-3bd4e3063aac	true	userinfo.token.claim
7b8abe3e-43bf-4337-854f-3bd4e3063aac	emailVerified	user.attribute
7b8abe3e-43bf-4337-854f-3bd4e3063aac	true	id.token.claim
7b8abe3e-43bf-4337-854f-3bd4e3063aac	true	access.token.claim
7b8abe3e-43bf-4337-854f-3bd4e3063aac	email_verified	claim.name
7b8abe3e-43bf-4337-854f-3bd4e3063aac	boolean	jsonType.label
efde3017-01b3-481c-951a-ecdffb260186	formatted	user.attribute.formatted
efde3017-01b3-481c-951a-ecdffb260186	country	user.attribute.country
efde3017-01b3-481c-951a-ecdffb260186	true	introspection.token.claim
efde3017-01b3-481c-951a-ecdffb260186	postal_code	user.attribute.postal_code
efde3017-01b3-481c-951a-ecdffb260186	true	userinfo.token.claim
efde3017-01b3-481c-951a-ecdffb260186	street	user.attribute.street
efde3017-01b3-481c-951a-ecdffb260186	true	id.token.claim
efde3017-01b3-481c-951a-ecdffb260186	region	user.attribute.region
efde3017-01b3-481c-951a-ecdffb260186	true	access.token.claim
efde3017-01b3-481c-951a-ecdffb260186	locality	user.attribute.locality
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	true	introspection.token.claim
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	true	userinfo.token.claim
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	phoneNumberVerified	user.attribute
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	true	id.token.claim
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	true	access.token.claim
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	phone_number_verified	claim.name
8b32df70-ce3b-4329-abe8-ec5e6f74e2a2	boolean	jsonType.label
e3ad032c-a73e-48f5-9794-54aea5423cf2	true	introspection.token.claim
e3ad032c-a73e-48f5-9794-54aea5423cf2	true	userinfo.token.claim
e3ad032c-a73e-48f5-9794-54aea5423cf2	phoneNumber	user.attribute
e3ad032c-a73e-48f5-9794-54aea5423cf2	true	id.token.claim
e3ad032c-a73e-48f5-9794-54aea5423cf2	true	access.token.claim
e3ad032c-a73e-48f5-9794-54aea5423cf2	phone_number	claim.name
e3ad032c-a73e-48f5-9794-54aea5423cf2	String	jsonType.label
6f10a168-313d-468d-ae3c-8b2d10d5730f	true	introspection.token.claim
6f10a168-313d-468d-ae3c-8b2d10d5730f	true	multivalued
6f10a168-313d-468d-ae3c-8b2d10d5730f	foo	user.attribute
6f10a168-313d-468d-ae3c-8b2d10d5730f	true	access.token.claim
6f10a168-313d-468d-ae3c-8b2d10d5730f	resource_access.${client_id}.roles	claim.name
6f10a168-313d-468d-ae3c-8b2d10d5730f	String	jsonType.label
85071c48-29ef-4792-b8e0-d536fb2f0b45	true	introspection.token.claim
85071c48-29ef-4792-b8e0-d536fb2f0b45	true	access.token.claim
b54fa05f-434f-48fa-8b13-e20d405aff97	true	introspection.token.claim
b54fa05f-434f-48fa-8b13-e20d405aff97	true	multivalued
b54fa05f-434f-48fa-8b13-e20d405aff97	foo	user.attribute
b54fa05f-434f-48fa-8b13-e20d405aff97	true	access.token.claim
b54fa05f-434f-48fa-8b13-e20d405aff97	realm_access.roles	claim.name
b54fa05f-434f-48fa-8b13-e20d405aff97	String	jsonType.label
61bfe63c-29ca-41a1-b12b-1243593e4c6d	true	introspection.token.claim
61bfe63c-29ca-41a1-b12b-1243593e4c6d	true	access.token.claim
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	true	introspection.token.claim
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	true	multivalued
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	foo	user.attribute
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	true	id.token.claim
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	true	access.token.claim
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	groups	claim.name
2cb8f28b-dbce-438c-bcfb-0e4c3e7d2a67	String	jsonType.label
63155fe9-f87b-4a47-a1f4-392562217db5	true	introspection.token.claim
63155fe9-f87b-4a47-a1f4-392562217db5	true	userinfo.token.claim
63155fe9-f87b-4a47-a1f4-392562217db5	username	user.attribute
63155fe9-f87b-4a47-a1f4-392562217db5	true	id.token.claim
63155fe9-f87b-4a47-a1f4-392562217db5	true	access.token.claim
63155fe9-f87b-4a47-a1f4-392562217db5	upn	claim.name
63155fe9-f87b-4a47-a1f4-392562217db5	String	jsonType.label
258035f6-61ed-4b44-9ceb-2cff01e8a9ca	true	introspection.token.claim
258035f6-61ed-4b44-9ceb-2cff01e8a9ca	true	id.token.claim
258035f6-61ed-4b44-9ceb-2cff01e8a9ca	true	access.token.claim
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	AUTH_TIME	user.session.note
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	true	introspection.token.claim
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	true	id.token.claim
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	true	access.token.claim
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	auth_time	claim.name
7cdbd33d-7ec6-4d88-b364-3666da79fd6b	long	jsonType.label
f3e27c7a-5f87-4e1a-a2af-0759e94efc68	true	introspection.token.claim
f3e27c7a-5f87-4e1a-a2af-0759e94efc68	true	access.token.claim
60cc4ec6-6b05-4b18-b838-bb58a09b216d	true	introspection.token.claim
60cc4ec6-6b05-4b18-b838-bb58a09b216d	true	multivalued
60cc4ec6-6b05-4b18-b838-bb58a09b216d	true	id.token.claim
60cc4ec6-6b05-4b18-b838-bb58a09b216d	true	access.token.claim
60cc4ec6-6b05-4b18-b838-bb58a09b216d	organization	claim.name
60cc4ec6-6b05-4b18-b838-bb58a09b216d	String	jsonType.label
03cc7b87-836d-406c-bef6-4fe4b7d8fc24	false	single
03cc7b87-836d-406c-bef6-4fe4b7d8fc24	Basic	attribute.nameformat
03cc7b87-836d-406c-bef6-4fe4b7d8fc24	Role	attribute.name
049aafda-b537-48d4-b3f0-a44b96e1904d	true	introspection.token.claim
049aafda-b537-48d4-b3f0-a44b96e1904d	true	userinfo.token.claim
049aafda-b537-48d4-b3f0-a44b96e1904d	website	user.attribute
049aafda-b537-48d4-b3f0-a44b96e1904d	true	id.token.claim
049aafda-b537-48d4-b3f0-a44b96e1904d	true	access.token.claim
049aafda-b537-48d4-b3f0-a44b96e1904d	website	claim.name
049aafda-b537-48d4-b3f0-a44b96e1904d	String	jsonType.label
2737244c-1fb1-4f7b-8e92-db0644242ace	true	introspection.token.claim
2737244c-1fb1-4f7b-8e92-db0644242ace	true	userinfo.token.claim
2737244c-1fb1-4f7b-8e92-db0644242ace	middleName	user.attribute
2737244c-1fb1-4f7b-8e92-db0644242ace	true	id.token.claim
2737244c-1fb1-4f7b-8e92-db0644242ace	true	access.token.claim
2737244c-1fb1-4f7b-8e92-db0644242ace	middle_name	claim.name
2737244c-1fb1-4f7b-8e92-db0644242ace	String	jsonType.label
4b76a7dc-e901-497e-9bf7-c19b5093156d	true	introspection.token.claim
4b76a7dc-e901-497e-9bf7-c19b5093156d	true	userinfo.token.claim
4b76a7dc-e901-497e-9bf7-c19b5093156d	nickname	user.attribute
4b76a7dc-e901-497e-9bf7-c19b5093156d	true	id.token.claim
4b76a7dc-e901-497e-9bf7-c19b5093156d	true	access.token.claim
4b76a7dc-e901-497e-9bf7-c19b5093156d	nickname	claim.name
4b76a7dc-e901-497e-9bf7-c19b5093156d	String	jsonType.label
5547e528-dde2-45dd-ada5-4b5d554ed9a1	true	introspection.token.claim
5547e528-dde2-45dd-ada5-4b5d554ed9a1	true	userinfo.token.claim
5547e528-dde2-45dd-ada5-4b5d554ed9a1	true	id.token.claim
5547e528-dde2-45dd-ada5-4b5d554ed9a1	true	access.token.claim
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	true	introspection.token.claim
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	true	userinfo.token.claim
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	picture	user.attribute
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	true	id.token.claim
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	true	access.token.claim
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	picture	claim.name
5b6ddce3-0ac9-4dbf-bdd0-8bb546f9a9dc	String	jsonType.label
60eca152-2987-4ee9-bf04-d807241c66c4	true	introspection.token.claim
60eca152-2987-4ee9-bf04-d807241c66c4	true	userinfo.token.claim
60eca152-2987-4ee9-bf04-d807241c66c4	username	user.attribute
60eca152-2987-4ee9-bf04-d807241c66c4	true	id.token.claim
60eca152-2987-4ee9-bf04-d807241c66c4	true	access.token.claim
60eca152-2987-4ee9-bf04-d807241c66c4	preferred_username	claim.name
60eca152-2987-4ee9-bf04-d807241c66c4	String	jsonType.label
8a59687d-7929-4315-85d1-36e1f4ad0ceb	true	introspection.token.claim
8a59687d-7929-4315-85d1-36e1f4ad0ceb	true	userinfo.token.claim
8a59687d-7929-4315-85d1-36e1f4ad0ceb	profile	user.attribute
8a59687d-7929-4315-85d1-36e1f4ad0ceb	true	id.token.claim
8a59687d-7929-4315-85d1-36e1f4ad0ceb	true	access.token.claim
8a59687d-7929-4315-85d1-36e1f4ad0ceb	profile	claim.name
8a59687d-7929-4315-85d1-36e1f4ad0ceb	String	jsonType.label
955cdee1-cc14-49c4-9144-741c9bc226cf	true	introspection.token.claim
955cdee1-cc14-49c4-9144-741c9bc226cf	true	userinfo.token.claim
955cdee1-cc14-49c4-9144-741c9bc226cf	locale	user.attribute
955cdee1-cc14-49c4-9144-741c9bc226cf	true	id.token.claim
955cdee1-cc14-49c4-9144-741c9bc226cf	true	access.token.claim
955cdee1-cc14-49c4-9144-741c9bc226cf	locale	claim.name
955cdee1-cc14-49c4-9144-741c9bc226cf	String	jsonType.label
9d9761c7-5c43-4be0-a0b6-85009e940d81	true	introspection.token.claim
9d9761c7-5c43-4be0-a0b6-85009e940d81	true	userinfo.token.claim
9d9761c7-5c43-4be0-a0b6-85009e940d81	lastName	user.attribute
9d9761c7-5c43-4be0-a0b6-85009e940d81	true	id.token.claim
9d9761c7-5c43-4be0-a0b6-85009e940d81	true	access.token.claim
9d9761c7-5c43-4be0-a0b6-85009e940d81	family_name	claim.name
9d9761c7-5c43-4be0-a0b6-85009e940d81	String	jsonType.label
a50e7a0b-62df-480d-b220-c355d18cf505	true	introspection.token.claim
a50e7a0b-62df-480d-b220-c355d18cf505	true	userinfo.token.claim
a50e7a0b-62df-480d-b220-c355d18cf505	zoneinfo	user.attribute
a50e7a0b-62df-480d-b220-c355d18cf505	true	id.token.claim
a50e7a0b-62df-480d-b220-c355d18cf505	true	access.token.claim
a50e7a0b-62df-480d-b220-c355d18cf505	zoneinfo	claim.name
a50e7a0b-62df-480d-b220-c355d18cf505	String	jsonType.label
ae7c33a5-5942-4484-aa90-8c5226f694da	true	introspection.token.claim
ae7c33a5-5942-4484-aa90-8c5226f694da	true	userinfo.token.claim
ae7c33a5-5942-4484-aa90-8c5226f694da	birthdate	user.attribute
ae7c33a5-5942-4484-aa90-8c5226f694da	true	id.token.claim
ae7c33a5-5942-4484-aa90-8c5226f694da	true	access.token.claim
ae7c33a5-5942-4484-aa90-8c5226f694da	birthdate	claim.name
ae7c33a5-5942-4484-aa90-8c5226f694da	String	jsonType.label
e0686b44-10b7-4212-a1e7-716483fbe105	true	introspection.token.claim
e0686b44-10b7-4212-a1e7-716483fbe105	true	userinfo.token.claim
e0686b44-10b7-4212-a1e7-716483fbe105	gender	user.attribute
e0686b44-10b7-4212-a1e7-716483fbe105	true	id.token.claim
e0686b44-10b7-4212-a1e7-716483fbe105	true	access.token.claim
e0686b44-10b7-4212-a1e7-716483fbe105	gender	claim.name
e0686b44-10b7-4212-a1e7-716483fbe105	String	jsonType.label
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	true	introspection.token.claim
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	true	userinfo.token.claim
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	firstName	user.attribute
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	true	id.token.claim
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	true	access.token.claim
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	given_name	claim.name
e1ec9d4d-34d7-45f5-a922-d48a52d2eccd	String	jsonType.label
fde6bdf0-f98e-41c4-8950-24b05eb88503	true	introspection.token.claim
fde6bdf0-f98e-41c4-8950-24b05eb88503	true	userinfo.token.claim
fde6bdf0-f98e-41c4-8950-24b05eb88503	updatedAt	user.attribute
fde6bdf0-f98e-41c4-8950-24b05eb88503	true	id.token.claim
fde6bdf0-f98e-41c4-8950-24b05eb88503	true	access.token.claim
fde6bdf0-f98e-41c4-8950-24b05eb88503	updated_at	claim.name
fde6bdf0-f98e-41c4-8950-24b05eb88503	long	jsonType.label
1b9bc368-2d9d-4882-9920-fdf99fa4e711	true	introspection.token.claim
1b9bc368-2d9d-4882-9920-fdf99fa4e711	true	userinfo.token.claim
1b9bc368-2d9d-4882-9920-fdf99fa4e711	email	user.attribute
1b9bc368-2d9d-4882-9920-fdf99fa4e711	true	id.token.claim
1b9bc368-2d9d-4882-9920-fdf99fa4e711	true	access.token.claim
1b9bc368-2d9d-4882-9920-fdf99fa4e711	email	claim.name
1b9bc368-2d9d-4882-9920-fdf99fa4e711	String	jsonType.label
d115fc0d-38ca-44fb-ac41-7b071e87589d	true	introspection.token.claim
d115fc0d-38ca-44fb-ac41-7b071e87589d	true	userinfo.token.claim
d115fc0d-38ca-44fb-ac41-7b071e87589d	emailVerified	user.attribute
d115fc0d-38ca-44fb-ac41-7b071e87589d	true	id.token.claim
d115fc0d-38ca-44fb-ac41-7b071e87589d	true	access.token.claim
d115fc0d-38ca-44fb-ac41-7b071e87589d	email_verified	claim.name
d115fc0d-38ca-44fb-ac41-7b071e87589d	boolean	jsonType.label
50329e21-3196-40ac-820c-a213c7c06afe	formatted	user.attribute.formatted
50329e21-3196-40ac-820c-a213c7c06afe	country	user.attribute.country
50329e21-3196-40ac-820c-a213c7c06afe	true	introspection.token.claim
50329e21-3196-40ac-820c-a213c7c06afe	postal_code	user.attribute.postal_code
50329e21-3196-40ac-820c-a213c7c06afe	true	userinfo.token.claim
50329e21-3196-40ac-820c-a213c7c06afe	street	user.attribute.street
50329e21-3196-40ac-820c-a213c7c06afe	true	id.token.claim
50329e21-3196-40ac-820c-a213c7c06afe	region	user.attribute.region
50329e21-3196-40ac-820c-a213c7c06afe	true	access.token.claim
50329e21-3196-40ac-820c-a213c7c06afe	locality	user.attribute.locality
80ae79b1-3112-4895-aaa1-7398310a0b3e	true	introspection.token.claim
80ae79b1-3112-4895-aaa1-7398310a0b3e	true	userinfo.token.claim
80ae79b1-3112-4895-aaa1-7398310a0b3e	phoneNumberVerified	user.attribute
80ae79b1-3112-4895-aaa1-7398310a0b3e	true	id.token.claim
80ae79b1-3112-4895-aaa1-7398310a0b3e	true	access.token.claim
80ae79b1-3112-4895-aaa1-7398310a0b3e	phone_number_verified	claim.name
80ae79b1-3112-4895-aaa1-7398310a0b3e	boolean	jsonType.label
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	true	introspection.token.claim
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	true	userinfo.token.claim
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	phoneNumber	user.attribute
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	true	id.token.claim
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	true	access.token.claim
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	phone_number	claim.name
fc8f8251-40bf-4ce6-bd6d-cd33c1adf64d	String	jsonType.label
1e75f037-444b-4e01-8357-baa6fb8e8b36	true	introspection.token.claim
1e75f037-444b-4e01-8357-baa6fb8e8b36	true	access.token.claim
8a5e092a-fa77-4159-9c38-372f586a04a6	true	introspection.token.claim
8a5e092a-fa77-4159-9c38-372f586a04a6	true	multivalued
8a5e092a-fa77-4159-9c38-372f586a04a6	foo	user.attribute
8a5e092a-fa77-4159-9c38-372f586a04a6	true	access.token.claim
8a5e092a-fa77-4159-9c38-372f586a04a6	resource_access.${client_id}.roles	claim.name
8a5e092a-fa77-4159-9c38-372f586a04a6	String	jsonType.label
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	true	introspection.token.claim
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	true	multivalued
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	foo	user.attribute
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	true	access.token.claim
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	realm_access.roles	claim.name
e4e8a2f5-8c5e-425e-8b16-d3eccd53b5fa	String	jsonType.label
c58bb144-9571-4046-80c5-bb0e49a6ffc4	true	introspection.token.claim
c58bb144-9571-4046-80c5-bb0e49a6ffc4	true	access.token.claim
3df247b7-df9c-477b-bd39-e66222cc7bc1	true	introspection.token.claim
3df247b7-df9c-477b-bd39-e66222cc7bc1	true	userinfo.token.claim
3df247b7-df9c-477b-bd39-e66222cc7bc1	username	user.attribute
3df247b7-df9c-477b-bd39-e66222cc7bc1	true	id.token.claim
3df247b7-df9c-477b-bd39-e66222cc7bc1	true	access.token.claim
3df247b7-df9c-477b-bd39-e66222cc7bc1	upn	claim.name
3df247b7-df9c-477b-bd39-e66222cc7bc1	String	jsonType.label
599a9cb2-b1b0-45b3-a5e6-69616431203a	true	introspection.token.claim
599a9cb2-b1b0-45b3-a5e6-69616431203a	true	multivalued
599a9cb2-b1b0-45b3-a5e6-69616431203a	foo	user.attribute
599a9cb2-b1b0-45b3-a5e6-69616431203a	true	id.token.claim
599a9cb2-b1b0-45b3-a5e6-69616431203a	true	access.token.claim
599a9cb2-b1b0-45b3-a5e6-69616431203a	groups	claim.name
599a9cb2-b1b0-45b3-a5e6-69616431203a	String	jsonType.label
a5d3eb5d-d77a-4a45-8727-6a1c07e65b24	true	introspection.token.claim
a5d3eb5d-d77a-4a45-8727-6a1c07e65b24	true	id.token.claim
a5d3eb5d-d77a-4a45-8727-6a1c07e65b24	true	access.token.claim
8aa3c75c-1546-4b08-9b93-b3990f82325d	AUTH_TIME	user.session.note
8aa3c75c-1546-4b08-9b93-b3990f82325d	true	introspection.token.claim
8aa3c75c-1546-4b08-9b93-b3990f82325d	true	id.token.claim
8aa3c75c-1546-4b08-9b93-b3990f82325d	true	access.token.claim
8aa3c75c-1546-4b08-9b93-b3990f82325d	auth_time	claim.name
8aa3c75c-1546-4b08-9b93-b3990f82325d	long	jsonType.label
e6f36c3d-4ae5-49ec-8eff-2fa15acb6355	true	introspection.token.claim
e6f36c3d-4ae5-49ec-8eff-2fa15acb6355	true	access.token.claim
b83c7540-d562-4584-8870-d7042a7e9c7e	true	introspection.token.claim
b83c7540-d562-4584-8870-d7042a7e9c7e	true	multivalued
b83c7540-d562-4584-8870-d7042a7e9c7e	true	id.token.claim
b83c7540-d562-4584-8870-d7042a7e9c7e	true	access.token.claim
b83c7540-d562-4584-8870-d7042a7e9c7e	organization	claim.name
b83c7540-d562-4584-8870-d7042a7e9c7e	String	jsonType.label
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	true	introspection.token.claim
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	true	userinfo.token.claim
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	locale	user.attribute
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	true	id.token.claim
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	true	access.token.claim
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	locale	claim.name
e65f900e-fdcd-46ea-b103-cf0c4b2a0d4a	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
782a628f-1571-41ed-8beb-5caf97452730	60	300	300	\N	\N	\N	t	f	0	\N	teranga_realm	0	\N	t	t	t	f	EXTERNAL	1800	36000	f	f	142a2b85-9f20-4618-82a3-f86fa2d7276b	1800	f	\N	t	f	f	f	0	1	30	6	HmacSHA1	totp	9cbe321c-e26c-4924-be04-af89bba52cf6	d2e39f9d-474f-432c-81d2-13a40459d526	7b12c54c-a32c-42fe-907c-a0b6aba902fc	7c44cf59-60b1-4d48-b436-0a37edc07f9a	beac8b7d-ed82-4f2d-8ea7-1f82f17ca9c6	2592000	f	900	t	f	090a99a9-3211-4e1b-8947-73bd07d35b54	0	f	0	0	bdeb5e0a-ad30-48f3-9a69-eea5802a637e
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	88109d9b-350a-4f67-b7ba-ace54b4b53a3	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	9fc25276-e893-474d-874a-76454099be2a	d3b9fe55-f1f7-44dd-888c-1ea8a738c685	9c89314f-4411-427b-93ab-ceee7fea41a4	56c60703-9604-4c82-bc59-7b7c0c477d1e	ec3c96df-c14c-49af-8280-6bddfa4ce15a	2592000	f	900	t	f	ddd28839-18a6-4d86-bbc8-8125deb64305	0	f	0	0	1584521d-e96a-4219-920b-54cb047069f0
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	
_browser_header.xContentTypeOptions	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	nosniff
_browser_header.referrerPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	no-referrer
_browser_header.xRobotsTag	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	none
_browser_header.xFrameOptions	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	SAMEORIGIN
_browser_header.contentSecurityPolicy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	1; mode=block
_browser_header.strictTransportSecurity	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	max-age=31536000; includeSubDomains
bruteForceProtected	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	false
permanentLockout	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	false
maxTemporaryLockouts	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	0
bruteForceStrategy	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	MULTIPLE
maxFailureWaitSeconds	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	900
minimumQuickLoginWaitSeconds	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	60
waitIncrementSeconds	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	60
quickLoginCheckMilliSeconds	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	1000
maxDeltaTimeSeconds	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	43200
failureFactor	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	30
realmReusableOtpCode	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	false
firstBrokerLoginFlowId	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	4ba36b95-9098-4b6e-b954-633350622108
displayName	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	Keycloak
displayNameHtml	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	RS256
offlineSessionMaxLifespanEnabled	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	false
offlineSessionMaxLifespan	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	5184000
bruteForceProtected	782a628f-1571-41ed-8beb-5caf97452730	false
permanentLockout	782a628f-1571-41ed-8beb-5caf97452730	false
maxTemporaryLockouts	782a628f-1571-41ed-8beb-5caf97452730	0
bruteForceStrategy	782a628f-1571-41ed-8beb-5caf97452730	MULTIPLE
maxFailureWaitSeconds	782a628f-1571-41ed-8beb-5caf97452730	900
minimumQuickLoginWaitSeconds	782a628f-1571-41ed-8beb-5caf97452730	60
waitIncrementSeconds	782a628f-1571-41ed-8beb-5caf97452730	60
quickLoginCheckMilliSeconds	782a628f-1571-41ed-8beb-5caf97452730	1000
maxDeltaTimeSeconds	782a628f-1571-41ed-8beb-5caf97452730	43200
failureFactor	782a628f-1571-41ed-8beb-5caf97452730	30
realmReusableOtpCode	782a628f-1571-41ed-8beb-5caf97452730	false
defaultSignatureAlgorithm	782a628f-1571-41ed-8beb-5caf97452730	RS256
offlineSessionMaxLifespanEnabled	782a628f-1571-41ed-8beb-5caf97452730	false
offlineSessionMaxLifespan	782a628f-1571-41ed-8beb-5caf97452730	5184000
actionTokenGeneratedByAdminLifespan	782a628f-1571-41ed-8beb-5caf97452730	43200
actionTokenGeneratedByUserLifespan	782a628f-1571-41ed-8beb-5caf97452730	300
oauth2DeviceCodeLifespan	782a628f-1571-41ed-8beb-5caf97452730	600
oauth2DevicePollingInterval	782a628f-1571-41ed-8beb-5caf97452730	5
webAuthnPolicyRpEntityName	782a628f-1571-41ed-8beb-5caf97452730	keycloak
webAuthnPolicySignatureAlgorithms	782a628f-1571-41ed-8beb-5caf97452730	ES256,RS256
webAuthnPolicyRpId	782a628f-1571-41ed-8beb-5caf97452730	
webAuthnPolicyAttestationConveyancePreference	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyAuthenticatorAttachment	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyRequireResidentKey	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyUserVerificationRequirement	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyCreateTimeout	782a628f-1571-41ed-8beb-5caf97452730	0
webAuthnPolicyAvoidSameAuthenticatorRegister	782a628f-1571-41ed-8beb-5caf97452730	false
webAuthnPolicyRpEntityNamePasswordless	782a628f-1571-41ed-8beb-5caf97452730	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	782a628f-1571-41ed-8beb-5caf97452730	ES256,RS256
webAuthnPolicyRpIdPasswordless	782a628f-1571-41ed-8beb-5caf97452730	
webAuthnPolicyAttestationConveyancePreferencePasswordless	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyRequireResidentKeyPasswordless	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	782a628f-1571-41ed-8beb-5caf97452730	not specified
webAuthnPolicyCreateTimeoutPasswordless	782a628f-1571-41ed-8beb-5caf97452730	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	782a628f-1571-41ed-8beb-5caf97452730	false
cibaBackchannelTokenDeliveryMode	782a628f-1571-41ed-8beb-5caf97452730	poll
cibaExpiresIn	782a628f-1571-41ed-8beb-5caf97452730	120
cibaInterval	782a628f-1571-41ed-8beb-5caf97452730	5
cibaAuthRequestedUserHint	782a628f-1571-41ed-8beb-5caf97452730	login_hint
parRequestUriLifespan	782a628f-1571-41ed-8beb-5caf97452730	60
firstBrokerLoginFlowId	782a628f-1571-41ed-8beb-5caf97452730	2afe6009-5ee4-400c-9ac8-00f0cd1276c7
organizationsEnabled	782a628f-1571-41ed-8beb-5caf97452730	false
clientSessionIdleTimeout	782a628f-1571-41ed-8beb-5caf97452730	0
clientSessionMaxLifespan	782a628f-1571-41ed-8beb-5caf97452730	0
clientOfflineSessionIdleTimeout	782a628f-1571-41ed-8beb-5caf97452730	0
clientOfflineSessionMaxLifespan	782a628f-1571-41ed-8beb-5caf97452730	0
client-policies.profiles	782a628f-1571-41ed-8beb-5caf97452730	{"profiles":[]}
client-policies.policies	782a628f-1571-41ed-8beb-5caf97452730	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	782a628f-1571-41ed-8beb-5caf97452730	
_browser_header.xContentTypeOptions	782a628f-1571-41ed-8beb-5caf97452730	nosniff
_browser_header.referrerPolicy	782a628f-1571-41ed-8beb-5caf97452730	no-referrer
_browser_header.xRobotsTag	782a628f-1571-41ed-8beb-5caf97452730	none
_browser_header.xFrameOptions	782a628f-1571-41ed-8beb-5caf97452730	SAMEORIGIN
_browser_header.contentSecurityPolicy	782a628f-1571-41ed-8beb-5caf97452730	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	782a628f-1571-41ed-8beb-5caf97452730	1; mode=block
_browser_header.strictTransportSecurity	782a628f-1571-41ed-8beb-5caf97452730	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	jboss-logging
782a628f-1571-41ed-8beb-5caf97452730	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf
password	password	t	t	782a628f-1571-41ed-8beb-5caf97452730
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e0217878-83bc-476b-bb1e-e4da9707c785	/realms/master/account/*
1e2b4826-d794-4029-869b-ca5b7543cd0c	/realms/master/account/*
9d7bd522-e633-4aa9-8492-8e600fc28621	/admin/master/console/*
a333915a-1b01-4ca0-9941-81f18ca387d9	/realms/teranga_realm/account/*
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	/realms/teranga_realm/account/*
2793ce4a-5ecb-4800-9476-072b62529f6f	/admin/teranga_realm/console/*
0f8b949c-dea0-4092-a532-8aba3a67b8dd	http://localhost:8081/*
5adbd09e-054c-40bd-bd53-f90f69def82d	http://localhost:8084/*
c214ed28-8adc-49f7-881a-4f8989ffb487	http://localhost:8083/*
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	http://localhost:8090/*
3b69e458-b218-41d8-88f4-e35fbd7c637b	http://localhost:4200/*
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	com.example.terangaconnect:/callback
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
7dcd9b7e-ea26-40fb-b228-d202e758936e	VERIFY_EMAIL	Verify Email	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	VERIFY_EMAIL	50
d2a18822-3aa4-41f9-8dc9-7b6914c465cc	UPDATE_PROFILE	Update Profile	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	UPDATE_PROFILE	40
b5f7db9d-ee30-4294-9eb8-0fef48a9c6cb	CONFIGURE_TOTP	Configure OTP	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	CONFIGURE_TOTP	10
1847d978-7c66-4b42-bf1c-5b29ad31e2b5	UPDATE_PASSWORD	Update Password	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	UPDATE_PASSWORD	30
b3c4c34f-f88e-40e5-af3f-db900e853c78	TERMS_AND_CONDITIONS	Terms and Conditions	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	f	TERMS_AND_CONDITIONS	20
ddd1642d-0b34-4716-b9d4-98ee76b2d28b	delete_account	Delete Account	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	f	f	delete_account	60
d431b1a9-add1-4341-b28c-f38d7109a47e	delete_credential	Delete Credential	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	delete_credential	100
c591dbb1-8ff6-4801-afc6-21953f51be9e	update_user_locale	Update User Locale	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	update_user_locale	1000
5d35e834-29e4-4138-bcaf-e3cda0c1969c	webauthn-register	Webauthn Register	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	webauthn-register	70
7518d969-5df4-4603-ae74-948a93271e5c	webauthn-register-passwordless	Webauthn Register Passwordless	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	webauthn-register-passwordless	80
ac205d28-e140-4a5a-b4a4-2dc584e22a00	VERIFY_PROFILE	Verify Profile	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	t	f	VERIFY_PROFILE	90
7964969b-97a1-42a3-9f86-c32b860f9d73	VERIFY_EMAIL	Verify Email	782a628f-1571-41ed-8beb-5caf97452730	t	f	VERIFY_EMAIL	50
08b0348a-79c9-4b6e-837d-157069c35b79	UPDATE_PROFILE	Update Profile	782a628f-1571-41ed-8beb-5caf97452730	t	f	UPDATE_PROFILE	40
edf52ba4-9a27-4c62-a929-9dd9843773ca	CONFIGURE_TOTP	Configure OTP	782a628f-1571-41ed-8beb-5caf97452730	t	f	CONFIGURE_TOTP	10
da0eaa73-3814-401b-9f72-240a706d1347	UPDATE_PASSWORD	Update Password	782a628f-1571-41ed-8beb-5caf97452730	t	f	UPDATE_PASSWORD	30
623a2913-42ef-428d-93b1-ddfcbdc1bcf5	TERMS_AND_CONDITIONS	Terms and Conditions	782a628f-1571-41ed-8beb-5caf97452730	f	f	TERMS_AND_CONDITIONS	20
7ba72337-c140-468c-8b92-774e13807516	delete_account	Delete Account	782a628f-1571-41ed-8beb-5caf97452730	f	f	delete_account	60
a19eee99-5c9f-429d-9ebe-161de7fa3462	delete_credential	Delete Credential	782a628f-1571-41ed-8beb-5caf97452730	t	f	delete_credential	100
86708818-768c-4485-a74c-dbc0e64e277f	update_user_locale	Update User Locale	782a628f-1571-41ed-8beb-5caf97452730	t	f	update_user_locale	1000
f09206ab-b190-4260-bdcc-37e3c970a87a	webauthn-register	Webauthn Register	782a628f-1571-41ed-8beb-5caf97452730	t	f	webauthn-register	70
e447b216-5b44-4199-b136-fc6d235bbbc8	webauthn-register-passwordless	Webauthn Register Passwordless	782a628f-1571-41ed-8beb-5caf97452730	t	f	webauthn-register-passwordless	80
d1efe7d6-9f05-44f0-84b3-3c388c582e4d	VERIFY_PROFILE	Verify Profile	782a628f-1571-41ed-8beb-5caf97452730	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
1e2b4826-d794-4029-869b-ca5b7543cd0c	b7bf31a7-5872-4bac-96bd-59df685832b9
1e2b4826-d794-4029-869b-ca5b7543cd0c	2b3ec696-dd0f-46e2-8cbc-8b3157600ce4
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	2e014269-00d8-42f1-b03f-7ad1151d6b2a
d310d34c-f0a0-4e13-94d2-e51cae8be5a8	1cc3bfa9-1d57-436e-947e-346e00012580
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: urgence_sociale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.urgence_sociale (lieu, montant_requis, type, id) FROM stdin;
Colobane	250000	0	311d896b-7902-442a-a2de-f6cb948ac25a
Mbour	400000	0	4e49c395-6155-4504-ae2b-1e9ea1d502cb
Touba	500000	1	8419e399-4f51-48e3-8dd1-bb1fe0b2676c
Dakar	300000	0	2feabf0a-dd56-44c8-9029-84898df240f1
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	fa91ad78-b9c6-4602-817e-638274475db7	40dafc42-7c34-4e06-b15a-a8a861980a7e	\N	\N	\N
telephone	778340335	449786a4-7f20-4e05-991c-56cab9308f52	386ecfeb-a9fe-4224-923f-2933c21af635	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
449786a4-7f20-4e05-991c-56cab9308f52	senemamadou1999@gmail.com	senemamadou1999@gmail.com	f	t	\N	Mamadou	SENE	782a628f-1571-41ed-8beb-5caf97452730	senemamadou1999@gmail.com	1741606265988	\N	0
fa91ad78-b9c6-4602-817e-638274475db7	senemamadou1999@gmail.com	senemamadou1999@gmail.com	f	t	\N	Mamadou	SENE	ffb022f7-1cce-44ab-9b9f-2c5b303eedcf	admin	1741602578324	\N	0
06b6403c-3ed0-425a-8a5d-92abaa530831	mohamed@gmail.com	mohamed@gmail.com	f	t	\N	Mohamed	Ndione	782a628f-1571-41ed-8beb-5caf97452730	mohamed@gmail.com	1745165013682	\N	0
6c9af926-014e-4ef5-a05b-a75642c2eb68	babacar@gmail.com	babacar@gmail.com	f	t	\N	Babacar	SENE	782a628f-1571-41ed-8beb-5caf97452730	babacar@gmail.com	1745676845433	\N	0
ed11b48f-7d87-453a-96db-d102390f2859	idrissa@gmail.com	idrissa@gmail.com	f	t	\N	idrissa	Fofana	782a628f-1571-41ed-8beb-5caf97452730	idrissa@gmail.com	1745165239477	\N	0
8ed7fe37-abd3-4723-844d-e1fc50053e06	moussa@gmail.com	moussa@gmail.com	f	t	\N	Moussa	Thior	782a628f-1571-41ed-8beb-5caf97452730	moussa@gmail.com	1745165416656	\N	0
d9fb2ccd-813c-44fb-9ce7-67371c9c1be7	papedemba@gmail.com	papedemba@gmail.com	t	t	\N	Papa demba	Ndione	782a628f-1571-41ed-8beb-5caf97452730	papedemba@gmail.com	1747516277150	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
1584521d-e96a-4219-920b-54cb047069f0	fa91ad78-b9c6-4602-817e-638274475db7
19499693-3f3d-4575-be63-c3ed9afc88de	fa91ad78-b9c6-4602-817e-638274475db7
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	449786a4-7f20-4e05-991c-56cab9308f52
d17201cc-b72f-4d6d-a94e-de523e985c0c	449786a4-7f20-4e05-991c-56cab9308f52
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	449786a4-7f20-4e05-991c-56cab9308f52
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	06b6403c-3ed0-425a-8a5d-92abaa530831
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	06b6403c-3ed0-425a-8a5d-92abaa530831
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	ed11b48f-7d87-453a-96db-d102390f2859
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	ed11b48f-7d87-453a-96db-d102390f2859
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	8ed7fe37-abd3-4723-844d-e1fc50053e06
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	8ed7fe37-abd3-4723-844d-e1fc50053e06
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	6c9af926-014e-4ef5-a05b-a75642c2eb68
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	6c9af926-014e-4ef5-a05b-a75642c2eb68
bdeb5e0a-ad30-48f3-9a69-eea5802a637e	d9fb2ccd-813c-44fb-9ce7-67371c9c1be7
bb3dec37-c604-4e9e-97bf-c6c5fe3af695	d9fb2ccd-813c-44fb-9ce7-67371c9c1be7
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: utilisateur; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur (id, email, profile, score, telephone, keycloak_id) FROM stdin;
449786a4-7f20-4e05-991c-56cab9308f52	idrissa@gmail.com	\N	12	779090000	ed11b48f-7d87-453a-96db-d102390f2859
8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	moussa@gmail.com	\N	11	768900091	8ed7fe37-abd3-4723-844d-e1fc50053e06
197737f2-b61e-4036-9c6e-6e999886f704	mohamed@gmail.com		0	778567788	06b6403c-3ed0-425a-8a5d-92abaa530831
b432b319-a9e0-41fc-8f45-cce46b647849	babacar@gmail.com	8442d6b7-055f-4794-aadd-a461ee0e944b_profile.jpg	0	760369965	6c9af926-014e-4ef5-a05b-a75642c2eb68
fd9020d0-f05c-4f37-87db-6dafda5a0795	senemamadou1999@gmail.com	8442d6b7-055f-4794-aadd-a461ee0e944b_profile.jpg	10	778340335	449786a4-7f20-4e05-991c-56cab9308f52
cc77e56e-ec2c-479e-939d-58a8285e49d1	papedemba@gmail.com	\N	0	779099900	d9fb2ccd-813c-44fb-9ce7-67371c9c1be7
\.


--
-- Data for Name: utilisateur_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.utilisateur_roles (utilisateur_id, roles) FROM stdin;
fd9020d0-f05c-4f37-87db-6dafda5a0795	USER
fd9020d0-f05c-4f37-87db-6dafda5a0795	MODERATEUR
8fadacf3-b9b3-44f5-bc2d-ee9f048697cb	USER
449786a4-7f20-4e05-991c-56cab9308f52	USER
197737f2-b61e-4036-9c6e-6e999886f704	USER
b432b319-a9e0-41fc-8f45-cce46b647849	USER
cc77e56e-ec2c-479e-939d-58a8285e49d1	USER
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
9d7bd522-e633-4aa9-8492-8e600fc28621	+
2793ce4a-5ecb-4800-9476-072b62529f6f	+
0f8b949c-dea0-4092-a532-8aba3a67b8dd	http://localhost:8081
5adbd09e-054c-40bd-bd53-f90f69def82d	http://localhost:8084
c214ed28-8adc-49f7-881a-4f8989ffb487	http://localhost:8083
89c2f499-0d49-4d3b-acd8-bb1cdfbbef1b	http://localhost:8090
3b69e458-b218-41d8-88f4-e35fbd7c637b	http://localhost:4200
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	com.example.terangaconnect://*
f9acb999-2424-4cdf-ac58-cd35dcedd4fd	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: declaration declaration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaration
    ADD CONSTRAINT declaration_pkey PRIMARY KEY (id);


--
-- Name: demande_donde_sang demande_donde_sang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demande_donde_sang
    ADD CONSTRAINT demande_donde_sang_pkey PRIMARY KEY (id);


--
-- Name: demandeur demandeur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demandeur
    ADD CONSTRAINT demandeur_pkey PRIMARY KEY (id);


--
-- Name: don_espece don_espece_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_espece
    ADD CONSTRAINT don_espece_pkey PRIMARY KEY (id);


--
-- Name: don_materiel don_materiel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_materiel
    ADD CONSTRAINT don_materiel_pkey PRIMARY KEY (id);


--
-- Name: don don_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don
    ADD CONSTRAINT don_pkey PRIMARY KEY (id);


--
-- Name: don_sang don_sang_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_sang
    ADD CONSTRAINT don_sang_pkey PRIMARY KEY (id);


--
-- Name: donnateur donnateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donnateur
    ADD CONSTRAINT donnateur_pkey PRIMARY KEY (id);


--
-- Name: evenement evenement_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement
    ADD CONSTRAINT evenement_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: pret pret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pret
    ADD CONSTRAINT pret_pkey PRIMARY KEY (id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: urgence_sociale urgence_sociale_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urgence_sociale
    ADD CONSTRAINT urgence_sociale_pkey PRIMARY KEY (id);


--
-- Name: utilisateur utilisateur_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur
    ADD CONSTRAINT utilisateur_pkey PRIMARY KEY (id);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: don_materiel_images fk5atv5sf1kodnfqdmw4h9rib93; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_materiel_images
    ADD CONSTRAINT fk5atv5sf1kodnfqdmw4h9rib93 FOREIGN KEY (don_id) REFERENCES public.don_materiel(id);


--
-- Name: don_espece fk6iq4fyg3twg0wcpoohbsq0jvv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_espece
    ADD CONSTRAINT fk6iq4fyg3twg0wcpoohbsq0jvv FOREIGN KEY (id) REFERENCES public.don(id);


--
-- Name: demande_donde_sang fk920t5qgv7w2lve8athnfdo8mq; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demande_donde_sang
    ADD CONSTRAINT fk920t5qgv7w2lve8athnfdo8mq FOREIGN KEY (id) REFERENCES public.declaration(id);


--
-- Name: utilisateur_roles fk9lop304xtodorgho9w56lpjhn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.utilisateur_roles
    ADD CONSTRAINT fk9lop304xtodorgho9w56lpjhn FOREIGN KEY (utilisateur_id) REFERENCES public.utilisateur(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: pret_images fkbndkjm0lho9mq07fxccditfu0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pret_images
    ADD CONSTRAINT fkbndkjm0lho9mq07fxccditfu0 FOREIGN KEY (pret_id) REFERENCES public.pret(id);


--
-- Name: donnateur fkcfmw3g0ho3n9nqlhpo5tiqm2p; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.donnateur
    ADD CONSTRAINT fkcfmw3g0ho3n9nqlhpo5tiqm2p FOREIGN KEY (id) REFERENCES public.utilisateur(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- Name: don_sang fkdj4ij3tmx3y30xo0peji7ah6l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_sang
    ADD CONSTRAINT fkdj4ij3tmx3y30xo0peji7ah6l FOREIGN KEY (id) REFERENCES public.don(id);


--
-- Name: demandeur fkeh44b6k5oj0695oqb898tjeq2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.demandeur
    ADD CONSTRAINT fkeh44b6k5oj0695oqb898tjeq2 FOREIGN KEY (id) REFERENCES public.utilisateur(id);


--
-- Name: don_materiel fkeptolihb0my1rkjb2n6wwdm3g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.don_materiel
    ADD CONSTRAINT fkeptolihb0my1rkjb2n6wwdm3g FOREIGN KEY (id) REFERENCES public.don(id);


--
-- Name: declaration_images fkf5igkupggny10gcckdfblgcmc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.declaration_images
    ADD CONSTRAINT fkf5igkupggny10gcckdfblgcmc FOREIGN KEY (declaration_id) REFERENCES public.declaration(id);


--
-- Name: evenement fkgkhl1k9wbnlallmlveciuoue8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.evenement
    ADD CONSTRAINT fkgkhl1k9wbnlallmlveciuoue8 FOREIGN KEY (id) REFERENCES public.declaration(id);


--
-- Name: urgence_sociale fkjwhnn79b2bsjmh8r4rjuwfg8t; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.urgence_sociale
    ADD CONSTRAINT fkjwhnn79b2bsjmh8r4rjuwfg8t FOREIGN KEY (id) REFERENCES public.declaration(id);


--
-- Name: pret fkt7s4sv27q3706qppjh0267fpp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pret
    ADD CONSTRAINT fkt7s4sv27q3706qppjh0267fpp FOREIGN KEY (id) REFERENCES public.don(id);


--
-- PostgreSQL database dump complete
--


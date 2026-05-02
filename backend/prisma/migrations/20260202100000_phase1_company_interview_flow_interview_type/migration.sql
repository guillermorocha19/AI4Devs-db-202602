-- Phase 1 (opción A): companies, interview_flows, interview_types

CREATE TABLE companies (
    id         SERIAL NOT NULL,
    name       VARCHAR(255) NOT NULL,

    CONSTRAINT companies_pkey PRIMARY KEY (id)
);

CREATE INDEX companies_name_idx ON companies (name);

CREATE TABLE interview_flows (
    id          SERIAL NOT NULL,
    description TEXT NOT NULL,

    CONSTRAINT interview_flows_pkey PRIMARY KEY (id)
);

CREATE TABLE interview_types (
    id          SERIAL NOT NULL,
    name        VARCHAR(120) NOT NULL,
    description TEXT,

    CONSTRAINT interview_types_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX interview_types_name_key ON interview_types (name);

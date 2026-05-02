-- Phase 3 (opción A): positions

CREATE TABLE positions (
    id                   SERIAL NOT NULL,
    company_id           INTEGER NOT NULL,
    interview_flow_id    INTEGER NOT NULL,
    title                VARCHAR(255) NOT NULL,
    description          TEXT,
    status               VARCHAR(50) NOT NULL,
    is_visible           BOOLEAN NOT NULL DEFAULT TRUE,
    location             VARCHAR(255),
    job_description      TEXT,
    requirements         TEXT,
    responsibilities     TEXT,
    salary_min           DECIMAL(12, 2),
    salary_max           DECIMAL(12, 2),
    employment_type      VARCHAR(80),
    benefits             TEXT,
    company_description  TEXT,
    application_deadline DATE,
    contact_info         VARCHAR(500),

    CONSTRAINT positions_pkey PRIMARY KEY (id),
    CONSTRAINT positions_salary_range_check CHECK (
        salary_min IS NULL
        OR salary_max IS NULL
        OR salary_min <= salary_max
    )
);

CREATE INDEX positions_company_id_idx ON positions (company_id);
CREATE INDEX positions_interview_flow_id_idx ON positions (interview_flow_id);
CREATE INDEX positions_status_idx ON positions (status);
CREATE INDEX positions_application_deadline_idx ON positions (application_deadline);

ALTER TABLE positions ADD CONSTRAINT positions_company_id_fkey
    FOREIGN KEY (company_id) REFERENCES companies (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE positions ADD CONSTRAINT positions_interview_flow_id_fkey
    FOREIGN KEY (interview_flow_id) REFERENCES interview_flows (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

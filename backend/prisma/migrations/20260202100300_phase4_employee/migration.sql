-- Phase 4 (opción A): employees

CREATE TABLE employees (
    id          SERIAL NOT NULL,
    company_id  INTEGER NOT NULL,
    name        VARCHAR(255) NOT NULL,
    email       VARCHAR(255) NOT NULL,
    role        VARCHAR(100) NOT NULL,
    is_active   BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT employees_pkey PRIMARY KEY (id),
    CONSTRAINT employees_company_id_email_key UNIQUE (company_id, email)
);

CREATE INDEX employees_company_id_idx ON employees (company_id);
CREATE INDEX employees_company_id_is_active_idx ON employees (company_id, is_active);

ALTER TABLE employees ADD CONSTRAINT employees_company_id_fkey
    FOREIGN KEY (company_id) REFERENCES companies (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

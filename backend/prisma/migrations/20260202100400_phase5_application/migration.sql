-- Phase 5 (opción A): applications (FK a positions y candidates)

CREATE TABLE applications (
    id                SERIAL NOT NULL,
    position_id       INTEGER NOT NULL,
    candidate_id      INTEGER NOT NULL,
    application_date  DATE NOT NULL DEFAULT CURRENT_DATE,
    status            VARCHAR(50) NOT NULL,
    notes             TEXT,

    CONSTRAINT applications_pkey PRIMARY KEY (id),
    CONSTRAINT applications_position_id_candidate_id_key UNIQUE (position_id, candidate_id)
);

CREATE INDEX applications_position_id_idx ON applications (position_id);
CREATE INDEX applications_candidate_id_idx ON applications (candidate_id);
CREATE INDEX applications_status_idx ON applications (status);
CREATE INDEX applications_application_date_idx ON applications (application_date);

ALTER TABLE applications ADD CONSTRAINT applications_position_id_fkey
    FOREIGN KEY (position_id) REFERENCES positions (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE applications ADD CONSTRAINT applications_candidate_id_fkey
    FOREIGN KEY (candidate_id) REFERENCES candidates (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

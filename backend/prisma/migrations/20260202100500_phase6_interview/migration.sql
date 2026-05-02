-- Phase 6 (opción A): interviews

CREATE TABLE interviews (
    id                 SERIAL NOT NULL,
    application_id     INTEGER NOT NULL,
    interview_step_id  INTEGER NOT NULL,
    employee_id        INTEGER NOT NULL,
    interview_date     DATE NOT NULL,
    result             VARCHAR(80),
    score              INTEGER,
    notes              TEXT,

    CONSTRAINT interviews_pkey PRIMARY KEY (id),
    CONSTRAINT interviews_application_id_interview_step_id_key UNIQUE (application_id, interview_step_id),
    CONSTRAINT interviews_score_check CHECK (
        score IS NULL OR (score >= 0 AND score <= 100)
    )
);

CREATE INDEX interviews_application_id_idx ON interviews (application_id);
CREATE INDEX interviews_interview_step_id_idx ON interviews (interview_step_id);
CREATE INDEX interviews_employee_id_idx ON interviews (employee_id);
CREATE INDEX interviews_interview_date_idx ON interviews (interview_date);

ALTER TABLE interviews ADD CONSTRAINT interviews_application_id_fkey
    FOREIGN KEY (application_id) REFERENCES applications (id)
    ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE interviews ADD CONSTRAINT interviews_interview_step_id_fkey
    FOREIGN KEY (interview_step_id) REFERENCES interview_steps (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE interviews ADD CONSTRAINT interviews_employee_id_fkey
    FOREIGN KEY (employee_id) REFERENCES employees (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

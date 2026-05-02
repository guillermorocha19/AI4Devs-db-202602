-- Phase 2 (opción A): interview_steps

CREATE TABLE interview_steps (
    id                 SERIAL NOT NULL,
    interview_flow_id  INTEGER NOT NULL,
    interview_type_id  INTEGER NOT NULL,
    name               VARCHAR(255) NOT NULL,
    order_index        INTEGER NOT NULL,

    CONSTRAINT interview_steps_pkey PRIMARY KEY (id),
    CONSTRAINT interview_steps_order_index_check CHECK (order_index >= 0)
);

CREATE INDEX interview_steps_interview_flow_id_idx ON interview_steps (interview_flow_id);
CREATE INDEX interview_steps_interview_flow_id_order_index_idx ON interview_steps (interview_flow_id, order_index);

ALTER TABLE interview_steps ADD CONSTRAINT interview_steps_interview_flow_id_fkey
    FOREIGN KEY (interview_flow_id) REFERENCES interview_flows (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE interview_steps ADD CONSTRAINT interview_steps_interview_type_id_fkey
    FOREIGN KEY (interview_type_id) REFERENCES interview_types (id)
    ON DELETE RESTRICT ON UPDATE CASCADE;

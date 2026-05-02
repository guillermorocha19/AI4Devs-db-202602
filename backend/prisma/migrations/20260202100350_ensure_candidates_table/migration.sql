-- Entorno sin tabla Candidate previa: el legado no creó `candidates`.
-- Idempotente: solo añade la tabla si no existe.

CREATE TABLE IF NOT EXISTS candidates (
    id          SERIAL NOT NULL,
    first_name  VARCHAR(100) NOT NULL,
    last_name   VARCHAR(100) NOT NULL,
    email       VARCHAR(255) NOT NULL,
    phone       VARCHAR(15),
    address     VARCHAR(100),

    CONSTRAINT candidates_pkey PRIMARY KEY (id)
);

CREATE UNIQUE INDEX IF NOT EXISTS candidates_email_key ON candidates (email);

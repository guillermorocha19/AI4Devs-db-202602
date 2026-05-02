-- Opción A: alinear tablas existentes (Candidate / Education / WorkExperience / Resume) a snake_case.
-- Idempotente: solo actúa si detecta los nombres antiguos de Prisma.

-- --- Candidate -> candidates ---
DO $$
BEGIN
  IF to_regclass('public."Candidate"') IS NOT NULL AND to_regclass('public.candidates') IS NULL THEN
    ALTER TABLE "Candidate" RENAME TO candidates;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'candidates' AND column_name = 'firstName') THEN
    ALTER TABLE candidates RENAME COLUMN "firstName" TO first_name;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'candidates' AND column_name = 'lastName') THEN
    ALTER TABLE candidates RENAME COLUMN "lastName" TO last_name;
  END IF;
END $$;

-- --- Education -> educations ---
DO $$
BEGIN
  IF to_regclass('public."Education"') IS NOT NULL AND to_regclass('public.educations') IS NULL THEN
    ALTER TABLE "Education" RENAME TO educations;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'educations' AND column_name = 'startDate') THEN
    ALTER TABLE educations RENAME COLUMN "startDate" TO start_date;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'educations' AND column_name = 'endDate') THEN
    ALTER TABLE educations RENAME COLUMN "endDate" TO end_date;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'educations' AND column_name = 'candidateId') THEN
    ALTER TABLE educations RENAME COLUMN "candidateId" TO candidate_id;
  END IF;
END $$;

-- --- WorkExperience -> work_experiences (columna position -> job_title: evita conflicto con función POSITION) ---
DO $$
BEGIN
  IF to_regclass('public."WorkExperience"') IS NOT NULL AND to_regclass('public.work_experiences') IS NULL THEN
    ALTER TABLE "WorkExperience" RENAME TO work_experiences;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'work_experiences' AND column_name = 'startDate') THEN
    ALTER TABLE work_experiences RENAME COLUMN "startDate" TO start_date;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'work_experiences' AND column_name = 'endDate') THEN
    ALTER TABLE work_experiences RENAME COLUMN "endDate" TO end_date;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'work_experiences' AND column_name = 'candidateId') THEN
    ALTER TABLE work_experiences RENAME COLUMN "candidateId" TO candidate_id;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'work_experiences' AND column_name = 'position') THEN
    ALTER TABLE work_experiences RENAME COLUMN "position" TO job_title;
  END IF;
END $$;

-- --- Resume -> resumes ---
DO $$
BEGIN
  IF to_regclass('public."Resume"') IS NOT NULL AND to_regclass('public.resumes') IS NULL THEN
    ALTER TABLE "Resume" RENAME TO resumes;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'resumes' AND column_name = 'filePath') THEN
    ALTER TABLE resumes RENAME COLUMN "filePath" TO file_path;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'resumes' AND column_name = 'fileType') THEN
    ALTER TABLE resumes RENAME COLUMN "fileType" TO file_type;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'resumes' AND column_name = 'uploadDate') THEN
    ALTER TABLE resumes RENAME COLUMN "uploadDate" TO upload_date;
  END IF;
END $$;

DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'resumes' AND column_name = 'candidateId') THEN
    ALTER TABLE resumes RENAME COLUMN "candidateId" TO candidate_id;
  END IF;
END $$;

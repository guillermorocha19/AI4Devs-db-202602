-- Elimina objetos creados con la convención opción B (PascalCase) y limpia historial Prisma de esas migraciones.
-- Ejecutar antes de aplicar las migraciones opción A desde cero.

DROP TABLE IF EXISTS "Position" CASCADE;
DROP TABLE IF EXISTS "InterviewStep" CASCADE;
DROP TABLE IF EXISTS "InterviewFlow" CASCADE;
DROP TABLE IF EXISTS "InterviewType" CASCADE;
DROP TABLE IF EXISTS "Company" CASCADE;

DELETE FROM "_prisma_migrations"
WHERE migration_name IN (
  '20260202100000_phase1_company_interview_flow_interview_type',
  '20260202100100_phase2_interview_step',
  '20260202100200_phase3_position'
);

## Ejercicio base de datos + migraciones Prisma (ERD → PostgreSQL)

Hola equipo 👋  
Esta PR recoge el trabajo de diseño relacional a partir del ERD en Mermaid, generación de SQL de referencia, plan de migraciones con Prisma, ejecución por fases y corrección de convención de nombres (opción A: **snake_case** en PostgreSQL). Va con contexto para quien revise el diff sin estar en la sesión.

---

### Qué se ha hecho (resumen relámpago)

- **Del diagrama al SQL**: script PostgreSQL en `docs/schema_from_erd.sql` (3FN, PK/FK, índices, `CHECK`, tabla `positions` para evitar el identificador reservado `POSITION`).
- **Análisis vs código**: comparativa entre ese SQL y el `schema.prisma` inicial (solo dominio candidato/CV); documentación de tablas nuevas del reclutamiento y ambigüedades del ERD.
- **Migraciones Prisma**: carpetas numeradas por fases; primero convención **opción B** (tablas Prisma estilo `"Company"` / `camelCase`), luego **pivot a opción A** tras aclaración: teardown de tablas opción B, migración legado `Candidate` → `candidates` + columnas snake_case, SQL de fases reescrito y `schema.prisma` con `@@map` / `@map`.
- **Fases por entorno**: despliegue incremental desplazando carpetas entre `migrations/` y `migrations_deferred/` para no aplicar todo de golpe.
- **Hotfix fase 5**: migración intermedia `20260202100350_ensure_candidates_table` porque en una BD “limpia” no existía `Candidate`; sin `candidates` la FK de `applications` fallaba (`42P01`).
- **Cliente**: `prisma generate` tras cerrar el ciclo de migraciones.

---

### Estructura de ficheros nuevos / tocados (orientación rápida)

```
docs/
  ERD.md                          # Fuente Mermaid del diagrama
  schema_from_erd.sql             # SQL de referencia desde el ERD
  images/
    migracion-fase-*.png          # Capturas por fase aplicada
    migracion-fase-0.png          # Contexto / legado
    gestion-migracion-scripts-por-fases.png
    fail/                         # Evidencias de intentos fallidos (p. ej. fases antes del pivot)

prompts/
  historico-prompts.md            # Solo prompts de la sesión (trazabilidad)

backend/prisma/
  schema.prisma                   # Modelos completos + @@map (opción A)
  migrations/
    20260202070000_legacy_tables_snake_case/
    20260202100000_phase1_company_interview_flow_interview_type/
    20260202100100_phase2_interview_step/
    20260202100200_phase3_position/
    20260202100300_phase4_employee/
    20260202100350_ensure_candidates_table/   # Fix falta tabla candidates
    20260202100400_phase5_application/
    20260202100500_phase6_interview/
  migrations_deferred/            # Vacío cuando todas las fases están ya en migrations/
  teardown_option_b_tables.sql    # Script manual usado al cambiar de opción B → A (referencia)
```

*(La raíz incluye este `PR.md` solo como plantilla para pegar en GitHub; no cuenta como entregable del ejercicio.)*

---

### Warnings / situaciones incómodas que encontramos ⚠️

| Tema | Qué pasó |
|------|-----------|
| **CLI Prisma** | `npx prisma` global puede ser otra versión que la del `package.json`; para comandos reproducibles conviene `backend/node_modules/.bin/prisma` o `npm install` en `backend`. |
| **`DATABASE_URL`** | El `.env` está en la **raíz del repo**; `migrate deploy` desde `backend/` sin variables puede fallar. Ejecutar desde la raíz o exportar `DATABASE_URL`. |
| **Opción B vs A** | Primera pasada con tablas citadas (`"Company"`, …); se corrigió a **snake_case** en BD + `@@map` tras decisión explícita del autor. |
| **Fase 5** | Error PostgreSQL `relation "candidates" does not exist`: la migración legado no crea datos si no había tabla `Candidate`; se resolvió con `ensure_candidates_table` + `migrate resolve --rolled-back` donde aplicaba. |
| **`validate` Prisma 7** | Si el entorno usa Prisma 7 global, puede avisar por `url` en `datasource`; el proyecto aquí usa Prisma 5.x en dependencias locales. |

---

### Evidencias en `/docs` 📎

- **`docs/ERD.md`**: diagrama fuente.
- **`docs/schema_from_erd.sql`**: artefacto SQL “desde el ERD” (referencia; convención snake_case plural).
- **`docs/images/`**: capturas de terminal / herramienta por fase (`migracion-fase-1.png` … `migracion-fase-6.png`, `migracion-fase-0.png`, diagrama de gestión por fases).
- **`docs/images/fail/`**: capturas de intentos previos al pivot opción A (útiles para narrar el cambio de convención).

---

### Checklist mental para el revisor ✅

- [ ] Migraciones aplican en orden lexicográfico; la intermedia `00350` va **antes** de la fase 5 en nombre de carpeta.
- [ ] Dominio legado (`candidates`, `educations`, `work_experiences`, `resumes`): columna `job_title` en experiencia laboral (evita choque con `POSITION()`).
- [ ] Borrado en cascada: entrevistas hijas si se borra una `application` (diseño deliberado en la fase 6).

---

Gracias por la lectura — cualquier duda sobre el orden de carpetas o el fix de `candidates`, ping en comentarios 💬

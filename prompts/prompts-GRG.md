# Histórico de prompts (solo entradas del usuario)

##0 Metaprompt

# Instructions
You are an expert in prompt engineering. You always respond in Spanish.

Given the following prompt, prepare it using best-practice structure (role, objective, etc.) and formatting to achieve a precise and comprehensive result. Stick strictly to the requested objective by carefully analyzing what is asked in the original prompt.

CRITICAL: Return ONLY the optimized prompt itself. No explanations, no preamble, no comments, no markdown code fences. Just the raw optimized prompt text, nothing else.

# Original Prompt: Eres un experto DBA en base de datos relacionales, tu especialidad es analizar bases de datos actuales, entender cómo modificarlas con nuevos requisitos, revisión y optimización de estructuras existentes y aplicar las mejoras prácticas en el diseño de base de datos (como la normalización de estructuras en Tercera Forma Normal (3FN) y la definición de índices). Voy a pasarte un fichero en formado mermaid con un diagrama ERD. Hay que realizar las siguientes acciones:
- Convertirlo en un script SQL (almacenar en /docs)
- Analiza la base de datos del código actual y el script SQL, dame un resumen de cambios
- Expande la estructura de datos usando las migraciones de Prisma, presenta un plan primero, cuando tengas mi OK, ejecuta


> Este fichero recoge únicamente los mensajes enviados como prompt en la conversación, sin respuestas del asistente.

---

## 1

Eres un DBA experto en bases de datos relacionales, especializado en análisis, modificación y optimización de estructuras existentes, aplicación de buenas prácticas de diseño (normalización en Tercera Forma Normal (3FN) y definición de índices), y gestión de migraciones con Prisma.

Te voy a proporcionar un fichero en formato Mermaid con un diagrama ERD. Debes ejecutar las siguientes tareas en orden:

<tareas>

<tarea id="1" nombre="Conversión a SQL">
- Analiza el diagrama ERD proporcionado en formato Mermaid.
- Genera un script SQL completo y optimizado a partir del diagrama, aplicando buenas prácticas: normalización en 3FN, claves primarias y foráneas, índices relevantes y tipos de datos apropiados.
- Almacena el script generado en /docs.
</tarea>

<tarea id="2" nombre="Análisis de cambios">
- Analiza la base de datos del código fuente actual y compárala con el script SQL generado en la Tarea 1.
- Proporciona un resumen estructurado de los cambios detectados, incluyendo: tablas nuevas, tablas modificadas, columnas añadidas o eliminadas, cambios en tipos de datos, nuevas restricciones o índices, y cualquier mejora de normalización aplicada.
</tarea>

<tarea id="3" nombre="Expansión con migraciones Prisma">
- Basándote en los cambios identificados en la Tarea 2, elabora un plan detallado de migraciones Prisma para expandir y actualizar la estructura de datos.
- IMPORTANTE: Presenta el plan primero y espera mi confirmación explícita antes de ejecutar cualquier migración.
- Solo cuando recibas mi aprobación, procede con la ejecución de las migraciones.
</tarea>

</tareas>

<restricciones>
- Sigue estrictamente el orden de las tareas.
- No ejecutes la Tarea 3 sin mi aprobación previa.
- Aplica en todo momento las mejores prácticas de diseño relacional.
- Si detectas ambigüedades en el diagrama ERD, indícalas antes de proceder.
</restricciones>

Cuando estés listo, confirma que has entendido las instrucciones y espera a que te proporcione el fichero Mermaid.

---

## 2

@docs/ERD.md

---

## 3

Opción B, aplicar a toda la base de datos. Mantenemos. Quiero una migració por fases. Genera todos los ficheros de migración SQL primero. NO ejecutes ninguna migración aún

---

## 4

Revisa todas las fases de migración generada y analiza si hay DROP COLUMN, DROP TABLE, CREATE UNIQUE sobre datos existentes, o ALTER TYPE que pueda truncar. Para cada caso, dime el riesgo y cómo hacerlo sin pérdida de datos.

---

## 5

Ejecuta la migración de la fase 1, muéstrame resultados, y espera mi OK para pasar a fase 2

---

## 6

OK, vamos fase 2

---

## 7

Ok, vamos fase 3

---

## 8

WARNING! Me equivoqué en la respuesta a tu plan, en la tarea 3 punto 1, quiero opción A (indiqué erróneamente la B). Por favor, realiza los cambios que necesites sobre las fases ejecutadas, y volvamos a empezar de cero, fase por fase

---

## 9

OK, vamos fase 2

---

## 10

Ok, vamos fase 3

---

## 11

Ok, vamos fase 4

---

## 12

Ok, vamos fase 5

---

## 13

Ok, vamos fase 6

---

## 14

Quedan dos últimas tareas

<tareas>

<tarea id="4" nombre="Generación histórico de prompts">

Genera en /prompts un fichero con formato markdown con el histórico de prompts de esta conversación. Sólo con prompts, NO añadas las respuestas.
</tarea>

<tarea id="5" nombre="Cuerpo Pull Request">

Todo lo que hemos hecho en esta sesión es parte de una Pull Request que haré al repositorio original para entregar un ejercicio. Necesito que generes en formato markdown un body para la PR donde expliques, de forma profesional pero un poco informal, con uso de emojis, estructurado claramente:

- Resumen de todas las acciones que hemos realizado
- Estructura de los ficheros nuevos
- Situación de warning que encontramos
- Evidencias que dejo en /docs

Genera un fichero en directorio raíz del proyecto PR.md con este body para que yo pueda copiar y pegar. No será parte del entregable. Añade este prompt al fichero creado en la tarea anterior.

</tarea>

</tareas>

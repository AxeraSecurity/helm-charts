#!/usr/bin/env bash
# Removes full-line SQL comments (lines whose first non-blank characters are "--") from the schema
# files the axera chart ships, charts/axera/sql/app-init.sql and charts/axera/sql/radar-init.sql.
# Run it after EVERY sync of those files from the Axera source, before packaging: the source keeps
# development notes in its comments that do not belong in a published chart. It drops every line
# whose first non-blank characters are "--" and keeps all other lines byte for byte, inline trailing
# comments included. It does not parse SQL: a line starting with "--" inside a multi-line quoted
# literal ('...' or $tag$...$tag$, e.g. seeded text or YAML with "---") would be dropped too, and
# silently change that data. So after each sync check the result before packaging: apply the
# original and the stripped file to two empty PostgreSQL databases with psql -v ON_ERROR_STOP=1,
# then compare `pg_dump --schema-only` and `pg_dump --data-only` of the two (both must be
# identical), and the newest "__EFMigrationsHistory" migration ID the chart reads from each file.
# The script is idempotent.
#
# Usage: hack/strip-sql-comments.sh [chart dir, default charts/axera]
set -euo pipefail
d="${1:-charts/axera}"
for f in "$d/sql/app-init.sql" "$d/sql/radar-init.sql"; do
  [ -f "$f" ] || { echo "missing: $f" >&2; exit 1; }
  LC_ALL=C awk '!/^[ \t]*--/' "$f" > "$f.tmp"
  mv "$f.tmp" "$f"
done

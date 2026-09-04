#!/usr/bin/env bash
# Create a new ticket folder from templates.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SLUG="${1:-}"
if [[ -z "$SLUG" ]]; then
  echo "Usage: $0 short-slug-description" >&2
  exit 1
fi
# normalize slug
SLUG="$(echo "$SLUG" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g')"
DATE="$(date +%F)"
ID="${DATE}-${SLUG}"
DIR="$ROOT/tickets/$ID"
if [[ -e "$DIR" ]]; then
  echo "Already exists: $DIR" >&2
  exit 1
fi
mkdir -p "$DIR/evidence/screenshots" "$DIR/notes"
for f in TICKET.md TASK-LOG.md PROMPT.md; do
  sed "s/{{TICKET_ID}}/$ID/g; s/{{TITLE}}/$SLUG/g" "$ROOT/templates/$f" > "$DIR/$f"
done
cat > "$DIR/resolution.txt" <<EOF
Status: Open
Ticket: $ID
Opened: $(date -Iseconds)
Resolution: (pending)
EOF
echo "Created $DIR"
echo "Next: copy screenshots into $DIR/evidence/screenshots/"
echo "Then open GrokBuild and point it at that folder."

# SysAdmin Ticket Tray

Portfolio-ready **mock helpdesk / desktop-support ticket tray** for guided learning with GrokBuild.

Each closed ticket is a self-contained folder: professional write-up, tutoring prompt, task log, and evidence (screenshots). The goal is a daily ops journal you can push to GitHub and selectively amplify to a blog or social posts.

## Workflow (GrokBuild tutoring loop)

1. **Do the work** on the desktop (break / fix / lab).
2. **Screenshot** key steps → drop into the ticket `evidence/screenshots/`.
3. **Prompt GrokBuild** as Guided Learning Agent with the symptom + screenshots.
4. GrokBuild produces / updates:
   - `TICKET.md` — Desktop Support–style ticket (open → investigate → resolve → close)
   - `TASK-LOG.md` — what you learned / commands used
   - `PROMPT.md` — session prompt archive
5. **Commit** the ticket folder. Optional: one-line entry in `journal/YYYY-MM-DD.md`.

## Layout

```text
SysAdmin-Ticket-Tray/
├── README.md
├── templates/           # blank forms for new tickets
├── tickets/             # one folder per ticket ID
│   └── YYYY-MM-DD-short-slug/
│       ├── TICKET.md
│       ├── TASK-LOG.md
│       ├── PROMPT.md
│       ├── resolution.txt
│       └── evidence/screenshots/
├── journal/             # optional daily rollup
└── scripts/             # helpers (new-ticket, etc.)
```

## Quick start

```bash
cd ~/SysAdmin-Ticket-Tray
./scripts/new-ticket.sh "short-slug-description"
# then paste screenshots into the new evidence/ folder and open a GrokBuild session
```

## Publishing (see research note)

Primary store of record: **this GitHub repo** (mock ticket tray).  
Optional amplifiers: GitHub Pages / Hugo site, X posts linking tickets, LinkedIn summaries.  
Decision write-up: `journal/2026-09-04-publishing-strategy.md` (filled after deep-research).

## Related

- AIDE_OS / Destroy The Kraken (GrokAide DE) — product work, separate from this learning tray
- Incident cross-link: `~/AIDE_OS/docs/ops/INCIDENT-2026-09-03-grok-pwa-tiling-spill.md`

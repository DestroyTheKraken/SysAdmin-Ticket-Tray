# Publishing strategy — SysAdmin Ticket Tray

**Date:** 2026-09-04  
**Status:** Decision recorded (research: Partial — see uncertainties below)  
**Research:** GrokBuild `/deep-research` run for portfolio publishing options

---

## Decision (short)

| Role | Choice |
|------|--------|
| **Primary (source of truth)** | **GitHub repo = mock closed-ticket tray** (`SysAdmin-Ticket-Tray`) |
| **Optional render layer** | GitHub Pages *or* Hugo later — thin HTML view of *selected* tickets |
| **Amplifiers** | LinkedIn summaries / Featured link; occasional X posts linking tickets |
| **Not primary** | X Articles–first, LinkedIn-article–first, or full dual-homing of every ticket |

**Rule:** One canonical write-up location. Amplifiers **link out**; they do not become a second master copy.

---

## Why this wins for Desktop Support / SysAdmin learning

1. **Hiring signal** — For Linux/scripting/ops-adjacent paths, a public GitHub with real write-ups + evidence beats empty profile decoration. Desktop-support candidates already use “ticket tray” lab repos (walkthrough + business-style ticket + screenshots). A fancy personal site is usually unnecessary until the tray has volume.
2. **Workflow fit** — Your GrokBuild loop is already markdown + screenshots → `TICKET.md` / `TASK-LOG.md` → commit. Docs-as-code matches the agent.
3. **Ownership** — Files stay yours in Git. Social CMSes are distribution, not the vault.
4. **Single source of truth** — Multi-homing full tickets wastes time and creates version drift.

### Option scores (for *your* use case)

| Option | Hiring depth | Daily friction | Ownership | Media | Verdict |
|--------|--------------|----------------|-----------|-------|---------|
| 3. GitHub ticket tray | High for ops labs | Low (already built) | Full | Watch repo size | **Primary** |
| 4. GitHub Pages | Better browsing/SEO than raw MD | Medium (CI/builds) | Full | 1 GB site soft limit | Amplifier when ready |
| 1. Self-hosted Hugo | Same as Pages + more control | Higher (theme/CI/latency) | Full | Best image pipelines | Optional later, not day-1 |
| 5. LinkedIn articles | Recruiter reach, shallow depth | Medium (reformat) | Shared platform | Easy uploads | Summaries + link only |
| 2. X Articles | Reach; Premium required | Medium | Platform | Easy uploads | Occasional links, not SoT |

---

## Practical operating model

```text
Capture → GrokBuild tutoring → tickets/YYYY-MM-DD-slug/ → git commit/push
                ↓ (optional, weekly or “best of”)
         Pages/Hugo render of featured tickets
                ↓ (optional)
         LinkedIn / X post with link + 3-bullet sound-bite
```

### Repo hygiene (do now / soon)

- Keep tickets **text-first**; compress PNGs before commit when possible.
- GitHub warns &gt;50 MiB/file, blocks &gt;100 MiB without LFS; Pages ~1 GB published.
- Pin the repo; link it from LinkedIn Featured and resume *after* you have several solid closed tickets (avoid empty-portfolio signal).
- Do **not** rebuild a full Hugo site on every typo; if you add Pages/Hugo, prefer selected exports or separated content/assets.

### When to add Hugo / Pages

Add a render layer when:

- You have **~8–15** closed tickets worth showing, and
- Recruiters or you need a nicer browse UX than raw GitHub folders.

Until then, the tray repo alone is enough.

### When to use X / LinkedIn

- Ship a **3–5 sentence** post + link to `TICKET.md` (or Pages URL).
- Do not paste full investigation tables into social — that breaks formatting and duplicates SoT.

---

## Sources (selected)

- Huntr — Sysadmin resume / GitHub as minority but real signal for scripting-heavy Linux paths  
- Prepare.sh — DevOps portfolio: real GitHub + write-ups; personal site often unnecessary  
- IT Support Group — portfolio guidance; rendered docs vs LinkedIn Featured as supplement  
- Example format: `github.com/sharklovin/IT-Support-And-Help-Desk-Lab-Scenarios`  
- GitHub Docs — Pages limits; large files  
- Hugo docs — static ownership, image pipeline, deploy paths  
- X Help — Articles + Premium  
- LinkedIn Help — article SEO fields / ownership language  
- Practitioner notes on SSOT and tool sprawl (dsebastien et al.)

Full cited report: Grok session workflow scratch `report.md` (deep-research, 2026-09-04).

## Known uncertainties (research was Partial)

- No strong primary hiring-manager ranking of “ticket tray vs Hugo vs X Articles” specifically.
- X Articles SEO / indexing not confirmed from official docs.
- Exact X Premium tier eligibility for Articles can differ by account UI — verify in-product if used.
- IT Support Group percentage claims were not re-verified against their underlying studies.

---

## Action items

- [x] Create `~/SysAdmin-Ticket-Tray` as primary SoT  
- [x] Close first ticket in Desktop Support format  
- [ ] Push repo to GitHub when ready (`gh repo create` / remote add)  
- [ ] After ~10 tickets: decide Pages vs Hugo for featured render  
- [ ] LinkedIn Featured → repo URL (not full ticket republication)  

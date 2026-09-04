# Ticket 2026-09-03-grok-pwa-tiling-spill — Grok app spills onto secondary display when tiling

| Field | Value |
|-------|--------|
| **Ticket ID** | `2026-09-03-grok-pwa-tiling-spill` |
| **Status** | **Closed — Resolved** |
| **Priority** | Low |
| **Category** | Desktop Support · Display / Window Manager · Web App (PWA) |
| **Opened** | 2026-09-03 ~21:45 |
| **Closed** | 2026-09-04 ~00:15 |
| **Agent** | Joshua Hickman — Desktop Support |
| **User / Host** | joshua @ `um690` |
| **Environment** | Linux · KDE Plasma **6.6.6** · **Wayland** (`kwin_wayland`) · SDDM |

---

## 1. Request / Symptom (user words)

> Grok app is not tiling on my Display 2 (Scepter monitor). It’s spilling over onto Display 1 rather than tiling cleanly on the Display 2 monitor.

## 2. Scope & impact

- **Users affected:** Single workstation (operator / lab host).
- **Impact:** Dual-monitor tiling workflow degraded on portrait secondary; no data loss; primary landscape display unaffected.
- **Workaround before fix:** Maximize on Display 2, or move Grok to Display 1.

## 3. Investigation

### 3.1 Inventory

| Output | Monitor | Role | Mode | Scale (at failure) | Logical geometry (at failure) |
|--------|---------|------|------|--------------------|-------------------------------|
| HDMI-A-1 | Samsung C27F390 | Display 1 (priority 1) | 1920×1080 landscape | 1.0 | `864,397 1920×1080` |
| HDMI-A-2 | **Sceptre F22** | Display 2 (portrait) | 1920×1080 rotated 90° | **1.25** | `0,0 864×1536` |

Additional findings:

- Compositor: KWin Wayland with per-desktop **Custom Tiling** layouts in `~/.config/kwinrc`.
- Affected window is **not** the native `grok` CLI binary; it is a **Google Chrome installed web app (PWA)**:
  - `desktopFile`: `chrome-ggjocahimgaohmigbfhghnlfcnjemagj-Default`
  - `Exec`: `google-chrome --app-id=ggjocahimgaohmigbfhghnlfcnjemagj`
  - Window class / resource: Chrome PWA (`resourceName: chrome`).

Tooling note for future agents: plain `qdbus` fails on this host (`qtchooser` with empty `QT_SELECT`). Use **`qdbus6`**.

### 3.2 Reproduction steps

1. Place SuperGrok (Chrome PWA) on the Sceptre (Display 2).
2. Tile into a **half-width / column** slot (e.g. beside Konsole).
3. Observe right edge of Grok drawing onto Samsung (Display 1).

### 3.3 Evidence gathered

**Window geometry while broken** (`qdbus6 org.kde.KWin /KWin org.kde.KWin.queryWindowInfo`):

| Window | x | width | Right edge | Fits Sceptre (864)? |
|--------|---|-------|------------|---------------------|
| Konsole (control) | 432 | **432** | 864 | Yes |
| Grok PWA | 432 | **500** | **932** | **No — spills 68 px** |

Screenshots: `evidence/screenshots/` (Display Configuration, Global Scale, dual-monitor layout, GrokAide session context).

### 3.4 Hypotheses

| # | Hypothesis | Result |
|---|------------|--------|
| H1 | Fractional scale + multi-monitor geometry bug in KWin | Partially relevant environment; **not** primary — Konsole tiled cleanly |
| H2 | Corrupt / wrong custom tile layout | Ruled out as sole cause — layout placed windows at expected `x`; width mismatch was app-side |
| H3 | Quick-tile targeting wrong output | Ruled out — both apps shared same column start (`x=432`) on HDMI-A-2 |
| H4 | **App minimum width > tile slot width** | **Confirmed** |
| H5 | Window rule restoring spanning size | Ruled out — no Grok-specific KWin rules found |

### 3.5 Root cause

Portrait Sceptre at **125% scale** yields only **864** logical pixels of width. A half-tile column is **432 px**. The Chrome Grok PWA retains approximately **500 px** minimum width, so KWin anchors the tile’s `x` but the window overflows **68 px** past `x=864` onto Display 1.

```text
Sceptre @ 1.25:  |←—— 864 px ——→|
Half column:                  |←432→|
Konsole:                      |████|     right edge = 864
Grok PWA:                     |████████| right edge = 932 → onto Samsung
```

## 4. Resolution

### Actions taken

1. Confirmed diagnosis with geometry math and Konsole control test.
2. Evaluated options: full-width tile, KWin custom tile redesign, Window Rules, **scale change**, relocate app.
3. **Implemented (user-approved):** set Sceptre / global display zoom to **100%** (integer scale).  
   - Rationale: vertical secondary is a **personal convenience**, not an MVP requirement for GrokAide DE; KWin rule/tile work would be higher complexity than needed.

### Post-change configuration

| Output | Scale | Logical geometry |
|--------|-------|------------------|
| HDMI-A-2 Sceptre | **1.0** | `0,0 1080×1920` |
| HDMI-A-1 Samsung | 1.0 | `1080,840 1920×1080` |

Half-tile width on Sceptre is now **540 px ≥ ~500 px** PWA floor → no spill.

### Verification

- [x] `kscreen-doctor -o` shows Sceptre Scale **1**, geometry **1080×1920**
- [x] Grok PWA + Konsole tile on Display 2 without crossing onto Display 1
- [x] Math check: `540 ≥ 500`

## 5. Prevention / user education

1. Prefer **100% (integer) scale** on portrait secondaries when tiling Chrome/Electron PWAs.
2. Before half-tiling a web app, ensure tile width ≳ **500 px**.
3. Control-test with Konsole/Dolphin before escalating as a compositor defect.
4. Use `qdbus6` for Plasma 6 window queries on this distro.
5. Product note (GrokAide): do not treat portrait + fractional scale as a required reference layout.

## 6. Closure

| | |
|--|--|
| **Resolution code** | **Config change** (display scale) |
| **Time to resolve** | Same evening / early next morning (guided session) |
| **Follow-ups** | None required for this ticket. Drive MCP / GrokAide context sync tracked separately under DTK product work. |
| **Knowledge base** | Also filed under AIDE_OS `docs/ops/INCIDENT-2026-09-03-grok-pwa-tiling-spill.md` |

**Ticket closed by:** Joshua Hickman — Desktop Support  
**Date:** 2026-09-04

---

*SysAdmin Ticket Tray · Guided Learning session with GrokBuild*

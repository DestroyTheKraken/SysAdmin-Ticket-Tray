# Task Log — 2026-09-03-grok-pwa-tiling-spill

**Date:** 2026-09-03 → 2026-09-04  
**Focus skill:** Desktop Support triage · multi-monitor geometry · Wayland/KWin · Chrome PWA behavior  
**Tutor:** GrokBuild Guided Learning Agent

## Objectives

- [x] Practice full support lifecycle: investigate → options → implement → prevent → document
- [x] Identify display topology (EDID, scale, rotation, logical geometry)
- [x] Distinguish compositor bugs from application min-size constraints
- [x] Choose fix complexity appropriate to product vs personal preference

## What I did (chronological)

| Step | Action | Result |
|------|--------|--------|
| 1 | Reported spill of Grok on Display 2 → Display 1 | Ticket opened |
| 2 | Inventoried session (Plasma 6 Wayland, dual HDMI) | Baseline environment |
| 3 | Hit `qdbus` qtchooser failure; switched to `qdbus6` | Tooling lesson |
| 4 | `queryWindowInfo` on Grok + Konsole | Grok = Chrome PWA; widths 500 vs 432 |
| 5 | Mapped geometry: Sceptre 864 wide @ 1.25; half = 432 | Root cause math |
| 6 | Ranked fixes; rejected heavy KWin rules for MVP | Scope discipline |
| 7 | Set vertical monitor / global scale to **100%** | Resolved |
| 8 | Documented ticket + evidence for portfolio tray | Closed |

## Commands worth keeping

```bash
kscreen-doctor -o
qdbus6 org.kde.KWin /KWin org.kde.KWin.queryWindowInfo
qdbus6 org.kde.KWin /KWin org.kde.KWin.activeOutputName
# Identify monitor names from EDID under /sys/class/drm/card*-HDMI-A-*/edid
```

## Concepts learned

- Logical size under fractional scaling: portrait 1920×1080 @ 1.25 → **864×1536**
- Chrome PWAs often will not shrink below ~**500 px** width
- Control tests (Konsole) separate WM bugs from app constraints
- Prefer removing the **constraint** (scale) over encoding special cases in the WM when the layout is optional

## Mistakes / false leads

- Initial `qdbus` error looked like a KWin outage — it was a Qt chooser wrapper issue
- Easy to over-invest in Window Rules when a one-slider display change fixes the math

## Portfolio sound-bite

> Diagnosed a dual-monitor tiling spill as Chrome PWA minimum width exceeding a 432 px half-tile on a 125%-scaled portrait display; resolved by returning the secondary to 100% scale after confirming with geometry math and a Konsole control test.

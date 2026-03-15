# Proposal: Rebrand "Paper Trail"

## Description
This proposal covers a full UI/UX rebrand for DIVI from the current "FinTech Premium" aesthetic (Glassmorphism, clean blues, carded tabs) to a "Paper Trail" (Skeuomorphic) design. The core idea is to mimic physical financial records—like receipts, ledger books, manila folders, and bill spikes—making the experience warmer, less stressful, and extremely intuitive for less tech-savvy users (like Luciana and Giovanna).

The layout will also shift to a strict "Mobile-First: One Screen at a Time" approach, replacing complex multi-tab dashboards with full-screen, focused modals and discrete views.

## Motivation
The current app works flawlessly due to the new high-performance `DiviEngine`, but visually it looks and feels like a strict banking app. Bills and shared debts already generate anxiety; the "Paper Trail" aesthetic humanizes the process. By introducing visual metaphors like a Z-Report receipt for fixed expenses, a notebook page for adding entries, and stacked manila files for older months, DIVI becomes more accessible and inherently organizes time intuitively.

## Scope
1. **Design System Update:**
   - Update global colors: `Paper (#F4F1EA)`, `Ink (#2C2C2C)`, `Faded Ink (#6B6B6B)`, `Primary/Debt (#e63819)`, `Paid (#2A7F62)`, `Highlight/Manila (#FCEDA8, #D3C6AD)`.
   - Update typography: Replace headers with `Young Serif`, body with `Inter`, and data/money displays with `Space Mono`.
   - Add algorithmic (CSS/Flutter Painter) jagged edges, dashed lines, and notebook ruled backgrounds.
2. **Navigation Re-architecture:**
   - Shift from 3 equal tabs (`Despesas`, `Cartão`, `Resumo`) to a new hybrid bottom nav focusing on `Ledger` (Home) and `Archive` (History), with a prominent `+` FAB for additions.
3. **Views Redesign (100% Mobile First):**
   - **The Ledger (Home):** Always focused on the *current month*. Combines a centralized "Z-Report" receipt for fixed expenses and overview cards for each resident's current debt/credit status.
   - **The Bill Spike (FAB Action):** A full-screen modal (or full bottom sheet) mimicking a spiral notebook page. Merges adding fixed expenses and credit card purchases in a single form with a toggle switch.
   - **The Statement (Details):** A dedicated sliding screen to view a specific resident's detailed receipt of debts/credits, replacing the old generic inline expansion or bottom sheet.
   - **The Archive:** A list of manila folder widgets showing previously closed months.
4. **Engine Adaptations:**
   - Modifying the generic `periodProvider` header filter. The "Archive" directly sets the period when viewing an old folder, but the Home (`Ledger`) will be pinned to the current running month.
5. **Impact on Existing Data:**
   - The data models (`Despesa`, `CompraCartao`, Records setup in `DiviEngine`) will largely remain untouched. The changes are concentrated on how the UI digests this data to present it cleanly.

## Success Criteria
- The transition is visually faithful to the HTML prototypes provided.
- The app retains its 60fps performance and single-pass capabilities.
- The UX makes opening the app less daunting: one focused screen per action (no split views).
- The transition from FinTech generic to DIVI Paper Trail correctly signals the identity of "Divida sem Dívida".

# Design: Rebrand "Paper Trail"

## Context
DIVI is transitioning its UI from a modern "FinTech/Glassmorphism" look to a "Skeuomorphic/Paper Trail" aesthetic to make the app feel warmer, more familiar, and less stressful. The new UX demands a strictly "Mobile-First: One Screen at a Time" flow over the current three-tab dashboard pattern.

## Architecture & Layout Changes

### 1. Global Themes & Shell
- **Aesthetic:** Replace all blue-centric, clean colors with an ink/paper palette.
  - Paper: `#F4F1EA`
  - Ink: `#2C2C2C`
  - Primary (Debt): `#e63819`
  - Paid: `#2A7F62`
  - Highlight/Manila: `#FCEDA8` (folder colors)
- **Typography:**
  - `Young Serif` for big headers/titles.
  - `Inter` for standard body text.
  - `Space Mono` for numbers and dates to give a receipt-like feel.
- **Texture Overlay:** Implement a global `Stack` covering the entire app window (pointer-ignored) drawing a faint noise pattern to mimic textured paper.
- **Visuals:** Create custom `ClipPath` (Clipper) classes for drawing jagged edges (top and bottom of receipts) and `CustomPainter` or standard `DottedLine` dependencies to separate items on the Z-Report.

### 2. View Re-architecture (One Concept Per Screen)

Instead of `Home` containing 3 tabs, the base hierarchy translates to:
1. `LedgerScreen` (Default Home, current month)
2. `ArchiveScreen` (Replaces `ResumoTab`/Month Switcher, separate screen showing old folders)
3. `SpikeSheet` (Full-Screen bottom sheet acting as a modal for new expenses)
4. `StatementScreen` (Pushed to stack when tapping on a resident in the Ledger, specific user detail)

### 3. Engine and Providers integration
- **`DiviEngine`**: Remains largely O(N). No heavy modifications required since the underlying calculation of who owes what and who paid what is completely reused.
- **`periodProvider`**: Currently used globally for a top-bar month selector.
  - The behavior changes: The `LedgerScreen` automatically pins `periodProvider` to the *current month/year* when navigated to.
  - When clicking on a folder in the `ArchiveScreen`, the app *pushes* a new instance or state of the `LedgerScreen` specifically updating the `periodProvider` for that old month (which can be read-only).
- **Consolidated Forms:** The Spike handles both Fixed `Despesa` and Credit Card `CompraCartao`. We simply use a segmented control or toggle button in the form state to determine the Supabase table and specific fields to persist.

## State Management Decisions
- Keep Riverpod with `select()` patterns for extreme performance.
- The `SpikeSheet` will be a `StatefulConsumerWidget` running a simple `Enum` state (`SpikeType.fixed` vs `SpikeType.credit`) which dynamically reveals or hides the "Who owes this?" section (only needed for credit card purchases).

## Security & Persistence
- Data persistence stays on Supabase. Only UI presentation code is rewritten.

## Trade-offs
- The jagged edges (`ClipPath`) and the noise texture `Stack` could introduce minor rendering overhead, but typically safe under Flutter's Impeller Engine on modern phones. We will avoid complex shadows overlapping the SVGs if performance stutters.
- Merging the addition form into one Full-Screen mode ("The Spike") might make it slower for a user who used to click `+` on the specific credit tab to jump straight there, but the simpler visual mapping (toggle switch at top) counterbalances this.

# Specification: Paper Trail UI

## Overview
This specification details the user flows and visual behaviors for the DIVI Paper Trail rebrand. The focus is to map out the "One Screen at a Time" mobile experience accurately.

## 1. Views & Flows

### 1.1 The Ledger (Home Screen)
- **Status:** Default starting view of the app.
- **Header:** Displays only the current month and year. No month carousel arrows.
- **Z-Report Card (Fixed Expenses):** An itemized receipt layout showing the total "House Total" (Rent, Energy, etc.). Clicking the Z-Report could show a `DespesaDetailsSheet` or remain a high-level summary if clicked on specific dotted lines.
- **Resident Cards:** Three stackable card components showing the state of `Luan`, `Luciana`, `Giovanna`.
- **Bottom Navigation:** Fixed to the bottom. Features `Ledger` (Active by default), `Archive`, and the `FAB (+)` spike action.

### 1.2 The Spike (Add Expense Form - Modal)
- **Status:** Triggered by tapping the `+` FAB.
- **Display:** A full-screen modal (or 0.95 screen height bottom sheet) that sweeps up from the bottom.
- **Aesthetic:** Features a spiral bound or horizontal ruled notebook aesthetic.
- **Behavior (Toggle Switch):**
  - Toggle segmented control for `Fixed Bill` vs `Credit Card`.
  - If `Fixed Bill`, hide the "Who owes this?" section.
  - If `Credit Card`, reveal radio buttons for `Luciana`, `Giovanna` (since Luan is the cardholder).
- **Behavior (Save):** Clicking the "Print to Ledger" bottom sticky button saves the record optimistically in the `DiviEngine`, triggers a success haptic, and slides the modal back down to reveal the Ledger updated.

### 1.3 The Statement (Resident Details)
- **Status:** Triggered by tapping on a resident's card in the `Ledger`.
- **Display:** Pushes a new page directly replacing the Ledger (swipe to go back).
- **Aesthetic:** A long vertical receipt format (`#0042`, custom names).
- **Content:** Lists exactly what the user owes (card purchases specific to them + their share of the house).
- **Action:** A prominent "Settle Up" action to pay their dues (which could mark all their current month items as Paid).

### 1.4 The Filing Cabinet / Archive
- **Status:** Triggered by the `Archive` button on the Bottom Nav.
- **Display:** Replaces the home screen view entirely. 
- **Content:** Shows vertical stacked "Folder" SVGs or Containers (`FolderTab` custom CSS/Flutter) representing all past months where the user has data.
- **Behavior:** Clicking a folder takes the user back to the `Ledger` view but explicitly locked into history mode (viewing the stats of that specific historical month).

## 2. Shared Assets & Visuals
- **Textures:** Global noise overlay.
- **Colors:** Defined in Design document.
- **Icons:** Material Symbols (`receipt_long`, `folder_open`, `check_circle`) aligned in `Space Mono` or `Inter` as appropriate.
- **Haptics:** Strong usage of `HapticFeedback.lightImpact()` and `mediumImpact()` across card taps and form toggles to emphasize the tactile "physical" nature of the Paper Trail theme.

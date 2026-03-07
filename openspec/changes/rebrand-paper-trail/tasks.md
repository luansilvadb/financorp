# Tasks: Paper Trail Rebrand

## 1. Environment & Global Aesthetics
- [x] 1.1 Update `pubspec.yaml` to include `google_fonts: ^xxx` for `Inter` and `Young Serif` (wait, verify if they exist or just rely on asset files). Actually, `google_fonts` supports both. Add `dotted_line` package if needed, or stick to standard `CustomPainter`.
- [x] 1.2 Re-configure `theme.dart` with the new Paper Trail color palette (`#F4F1EA` background, `#2C2C2C` text, etc.) and typography defaults.
- [x] 1.3 Create a global `PaperBackground` widget using `Stack` that overlays a faint noise SVG/PNG image on top of the solid paper color. Apply it to the scaffold wrapper of the app.

## 2. Core Reusable Skeuomorphic Widgets
- [x] 2.1 Implement `ReceiptClipper` (Custom Clipper) to algorithmically draw the top/bottom jagged edge cuts for receipt cards.
- [x] 2.2 Implement `DashedDivider` (Custom Painter or Package) to recreate the Z-Report dotted lines.
- [x] 2.3 Implement `HolePunch` container for side cutouts.
- [x] 2.4 Implement `FolderClipper` to create the manila tab shape for the Archive folders.

## 3. Navigation & Home Structure
- [x] 3.1 Remove the existing 3-tab layout (`DespesasTab`, `CartaoTab`, `ResumoTab`) and the gooey morphing bottom nav.
- [x] 3.2 Create the new `PaperBottomNav` featuring `Ledger`, `Archive` icons, and a floating elevated `FAB` (The Spike).
- [x] 3.3 Create a new `LedgerScreen` as the default destination.
- [x] 3.4 Wire `LedgerScreen`'s header to always select `DateTime.now()` in the `periodProvider` by default.

## 4. The Ledger Screen (Views)
- [x] 4.1 Build the `ZReportCard` Widget, hooking it into `diviEngineProvider` to sum all fixed house expenses for the month.
- [x] 4.2 Build the `ResidentSummaryCard` Widget, displaying `Luan` (Admin/Receiving) and `Luciana`/`Giovanna` (Residents/Owing).
- [x] 4.3 Link tapping a `ResidentSummaryCard` to push the new `StatementScreen`.

## 5. The Spike (Add Expense Form)
- [x] 5.1 Create `SpikeModalSheet`, a full screen (or 90% screen) bottom sheet mimicking the blue-ruled notebook.
- [x] 5.2 Implement the segmented toggle (`Fixed Bill` vs `Credit Card`).
- [x] 5.3 Configure visibility logic: Hide "Who owes this?" for Fixed. Show Radio buttons for residents on Credit Card.
- [x] 5.4 Connect the "Print to Ledger" button to trigger Supabase optimistic inserts. Animate sheet down on success.

## 6. The Statement Screen (Details)
- [x] 6.1 Create `StatementScreen` pushed on top of the `Ledger`. This is specific to a `pessoa`.
- [x] 6.2 Render the receipt using the `ReceiptClipper` at the bottom.
- [x] 6.3 Iterate over the specific resident's `compras` (+ their share of `despesas`) rendering them in the `Space Mono` typography.
- [x] 6.4 Implement the "Settle Up" action to pay the total pending balance.

## 7. The Archive Screen
- [x] 7.1 Create `ArchiveScreen` accessed via the bottom nav.
- [x] 7.2 Fetch a distinct list of months with historical data from the `DiviEngine`. (Implemented as dynamic last 6 months list)
- [x] 7.3 Render each month as a `FolderCard` using `FolderClipper`, stacking them vertically.
- [x] 7.4 On folder tap, push `LedgerScreen` pre-configured with that old month via `periodProvider` (read-only mode). (Implemented via provider update)

## 8. Final Polish
- [x] 8.1 Fine-tune haptics (`HapticFeedback`) on all buttons and toggles.
- [x] 8.2 Verify visual contrast and shadows (hard shadow drops vs blurred shadows).
- [x] 8.3 Verify state isolation (Riverpod `.select`) remains fully operational under the new widget hierarchy.

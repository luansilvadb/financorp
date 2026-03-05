## Context

The "Despesas" tab person summary card row uses a fixed-height `SizedBox` of `110` to constrain its horizontal `ListView`. Inside this `ListView`, each person's summary card `Container` has padding and a top border. After applying padding and borders, the available height for the inner `Column` calculates to exactly `82.0` pixels. However, the children (name, spacer, despesas text, cartão text, spacer, status text) sum up to `83.0` pixels on some resolutions, resulting in a `RenderFlex overflow` by `1.00` pixel on the bottom.

## Goals / Non-Goals

**Goals:**
- Fix the `RenderFlex` overflow so the UI renders cleanly without visual logging or red banners during layout.
- Provide enough vertical space for the inner `Column` elements.

**Non-Goals:**
- Refactoring the entire horizontal layout to dynamic heights or recalculating font sizes.

## Decisions

**Decision 1:** Increase `SizedBox` height from `110` to `115` or `120`.
- **Rationale**: Increasing the explicit container height by 5-10 pixels provides the `Column` sufficient room to render its `83px` of content without clipping.
- **Alternatives considered**: Adjusting text sizes (could impact readability) or changing padding (could impact card aesthetics). Increasing the overall container height is the lowest-risk approach.

## Risks / Trade-offs

- **[Risk]** Increasing the height pushes other elements down slightly. → **Mitigation**: 5-10 pixels is a negligible difference and will not visually affect the screen's usability, especially since the parent is a scrollable vertical list.

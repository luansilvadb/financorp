# Specification: Premium Bottom Nav UX

## Overview
The "Premium Bottom Nav" should feel high-end, using fluid motion and tactile feedback during navigation.

## ADDED Requirements

### Requirement: Gooey Navigation Transition
The indicator for the active tab should "stretch" towards the new tab and "snap" back into its final shape, simulating a liquid or elastic movement.

### Requirement: Subtle Visual Feedback
Selected icons should scale up by ~20% (`scale: 1.2`) using a 200ms `curves.easeOut` animation.

### Requirement: Tactile Experience
Each tab tap should trigger a `HapticFeedback.lightImpact()` to provide a tactile sense of interaction.

## UI Scenarios

### Scenario: Switching between Despesas and Cartão
- **WHEN** user taps "Cartão" tab while "Despesas" is active
- **THEN** the active indicator should stretch horizontally to span both tabs during the 350ms transition
- **THEN** the "Despesas" icon should scale down to `1.0` and its label should fade out
- **THEN** the "Cartão" icon should scale up to `1.2`, transition to the `fill` style, and its label should fade in.

### Scenario: Rapid Multiple Taps
- **WHEN** user taps "Resumo" and then immediately taps "Despesas"
- **THEN** the active indicator's animation should interrupt and redirect smoothly to the latest target without visual jitter.

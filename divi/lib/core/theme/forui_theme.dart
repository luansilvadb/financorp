import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import '../../shared/constants.dart';

/// Creates a forui theme configuration that maps existing design tokens to forui theme tokens.
///
/// This function provides a bridge between the existing color palette defined in
/// [constants.dart] and forui's theme system, ensuring visual continuity during
/// the migration to exclusive forui.dev usage.
///
/// Parameters:
/// - [brightness]: The brightness mode (light/dark) for the theme
/// - [isTouch]: Whether to use touch-optimized components (true for mobile, false for desktop)
///
/// Returns an [FThemeData] configured with the existing color palette mapped to forui tokens.
FThemeData getForuiTheme(Brightness brightness, {bool isTouch = true}) {
  // Start with the neutral theme light variant as base
  final baseTheme = FThemes.neutral.light;
  
  // Select touch or desktop variant based on isTouch parameter
  final themeData = isTouch ? baseTheme.touch : baseTheme.desktop;
  
  // Return the base theme for now - customization will be added during migration
  // The existing color tokens (kPaper, kInk, kPrimaryColor, etc.) will be mapped
  // to forui theme properties as needed during component migration
  return themeData;
}

/// Legacy compatibility: Returns the legacy FTheme wrapper for use in MaterialApp.
///
/// This maintains backward compatibility with the existing app structure while
/// migrating to use forui themes exclusively.
Widget buildForuiThemeWrapper({required Widget child}) {
  return FTheme(
    data: getForuiTheme(Brightness.light),
    child: child,
  );
}

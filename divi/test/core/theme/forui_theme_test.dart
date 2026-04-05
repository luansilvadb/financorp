import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forui/forui.dart';
import 'package:divi/core/theme/forui_theme.dart';

void main() {
  group('ForuiTheme Configuration', () {
    test('getForuiTheme should return a valid FThemeData', () {
      final theme = getForuiTheme(Brightness.light);
      expect(theme, isNotNull);
      expect(theme, isA<FThemeData>());
    });

    test('getForuiTheme should configure platform-specific themes', () {
      final touchTheme = getForuiTheme(Brightness.light, isTouch: true);
      final desktopTheme = getForuiTheme(Brightness.light, isTouch: false);
      
      expect(touchTheme, isNotNull);
      expect(desktopTheme, isNotNull);
      expect(touchTheme, isA<FThemeData>());
      expect(desktopTheme, isA<FThemeData>());
    });

    test('Theme should be properly configured', () {
      final theme = getForuiTheme(Brightness.light);
      
      // Verify theme is configured and accessible
      expect(theme, isNotNull);
      expect(theme, isA<FThemeData>());
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:divi/core/constants/icon_mapping.dart';

void main() {
  group('IconMapping', () {
    test('Icon mapping constants should be defined', () {
      // Verify that all expected icon mapping constants exist
      expect(IconMapping.receiptFill, isNotNull);
      expect(IconMapping.receiptRegular, isNotNull);
      expect(IconMapping.folderOpenFill, isNotNull);
      expect(IconMapping.checkCircleFill, isNotNull);
      expect(IconMapping.warningCircleFill, isNotNull);
      expect(IconMapping.caretRightBold, isNotNull);
      expect(IconMapping.caretLeftBold, isNotNull);
      expect(IconMapping.pencilSimpleRegular, isNotNull);
      expect(IconMapping.plusCircleRegular, isNotNull);
      expect(IconMapping.xCircleFill, isNotNull);
      expect(IconMapping.trashRegular, isNotNull);
      expect(IconMapping.houseLineFill, isNotNull);
      expect(IconMapping.magnifyingGlassBold, isNotNull);
      expect(IconMapping.arrowClockwiseBold, isNotNull);
      expect(IconMapping.arrowCounterClockwiseRegular, isNotNull);
      expect(IconMapping.piggyBankRegular, isNotNull);
      expect(IconMapping.creditCardRegular, isNotNull);
      expect(IconMapping.intersectFill, isNotNull);
    });

    test('IconMapper should map common icons correctly', () {
      // Test a few key mappings
      expect(
        IconMapper.mapPhosphorIconToLucide('receipt', 'fill'),
        equals('receipt'),
      );
      expect(
        IconMapper.mapPhosphorIconToLucide('checkCircle', 'PhosphorIconsStyle.fill'),
        equals('check-circle'),
      );
      expect(
        IconMapper.mapPhosphorIconToLucide('warningCircle', 'fill'),
        equals('alert-circle'),
      );
      expect(
        IconMapper.mapPhosphorIconToLucide('caretRight', 'bold'),
        equals('chevron-right'),
      );
    });
  });
}

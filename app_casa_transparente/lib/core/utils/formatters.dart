import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Formats user input as BRL currency (e.g. 1.500,00) in real-time.
class BrlCurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return newValue;

    // Get only digits
    String cleaned = newValue.text.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.isEmpty) cleaned = '0';

    double value = double.parse(cleaned) / 100;
    final formatter = NumberFormat.currency(locale: 'pt_BR', symbol: '');
    String newText = formatter.format(value).trim();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

/// Parses a BRL-formatted string (e.g. "1.500,00") back to a double.
double parseBrl(String text) {
  if (text.isEmpty) return 0.0;
  String cleaned = text.replaceAll('.', '').replaceAll(',', '.');
  return double.tryParse(cleaned) ?? 0.0;
}

/// Formats a double value back to BRL display string.
String fmt(double v) {
  return NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(v);
}

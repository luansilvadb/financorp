import 'package:flutter/material.dart';
import 'package:divi/shared/widgets/divi_toasts.dart';

/// Retries an operation with exponential backoff.
/// 
/// Attempts up to [maxRetries] times with delays of 1s, 2s, 4s, etc.
/// Shows a toast on final failure.
Future<T?> withRetry<T>({
  required Future<T> Function() operation,
  required BuildContext context,
  String? successMessage,
  String? failureMessage,
  int maxRetries = 3,
}) async {
  for (int i = 0; i < maxRetries; i++) {
    try {
      final result = await operation();
      if (successMessage != null && context.mounted) {
        DiviToasts.show(context, successMessage, isError: false);
      }
      return result;
    } catch (e) {
      if (i == maxRetries - 1) {
        // Final attempt failed
        if (context.mounted) {
          DiviToasts.show(
            context,
            failureMessage ?? 'Não foi concluir operação. Tente novamente.',
            isError: true,
          );
        }
        return null;
      }
      // Wait with exponential backoff: 1s, 2s, 4s
      await Future.delayed(Duration(seconds: 1 << i));
    }
  }
  return null;
}

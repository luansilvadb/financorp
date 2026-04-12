import 'package:flutter/material.dart';
import 'package:divi/shared/constants.dart';

/// Offline banner shown at top of screens when connection is lost.
/// 
/// Never blocks interaction — just informs the user.
class OfflineBanner extends StatelessWidget {
  final bool isOffline;
  final Widget child;

  const OfflineBanner({
    super.key,
    required this.isOffline,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isOffline)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: kSemanticPending.withValues(alpha: 0.15),
            child: Row(
              children: [
                Icon(
                  Icons.wifi_off,
                  size: 16,
                  color: kSemanticPending,
                ),
                const SizedBox(width: 8),
                Text(
                  'Offline — dados locais disponíveis',
                  style: TextStyle(
                    fontFamily: 'Space Mono',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: kSemanticPending,
                  ),
                ),
              ],
            ),
          ),
        Expanded(child: child),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/engine/finance_engine.dart';
import '../../../shared/constants.dart';
import '../../../shared/widgets/divi_avatar.dart';

/// GroupSummary widget shows "X/Y em dia" with resident avatars
/// and expands to show individual details on tap.
class GroupSummary extends ConsumerStatefulWidget {
  const GroupSummary({super.key});

  @override
  ConsumerState<GroupSummary> createState() => _GroupSummaryState();
}

class _GroupSummaryState extends ConsumerState<GroupSummary>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    HapticFeedback.lightImpact();
    setState(() {
      _expanded = !_expanded;
      if (_expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final financeState = ref.watch(diviEngineProvider);

    final resumo = financeState.resumo;
    final totalResidentes = resumo.length;

    // Count residents with no pending balance (totalGeral <= 0 means all paid/credit)
    final residentesEmDia = resumo.values
        .where((r) => r.totalGeral <= 0.001)
        .length;
    final pendentes = totalResidentes - residentesEmDia;

    // Determine status color
    Color statusColor;
    String emotionalMessage;

    if (residentesEmDia == totalResidentes) {
      statusColor = kSemanticPaid; // Green
      emotionalMessage = "Paz na casa ✨";
    } else if (residentesEmDia > 0) {
      statusColor = kSemanticPending; // Amber
      emotionalMessage = pendentes == 1 ? "1 pendente" : "$pendentes pendentes";
    } else {
      statusColor = kSemanticOverdue; // Rust
      emotionalMessage = pendentes == 1 ? "1 pendente" : "$pendentes pendentes";
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: statusColor.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - Always visible
          GestureDetector(
            onTap: _toggleExpanded,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Main status text
                      Expanded(
                        child: Semantics(
                          label:
                              '$residentesEmDia de $totalResidentes residentes em dia. $emotionalMessage',
                          child: Text(
                            '$residentesEmDia/$totalResidentes em dia',
                            style: TextStyle(
                              fontFamily: 'Young Serif',
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: statusColor,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ),
                      ),
                      // Avatars
                      Row(
                        children: resumo.entries.map((entry) {
                          final residentName = entry.key;
                          final residentData = entry.value;
                          final isPaid = residentData.totalGeral == 0.0;

                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isPaid
                                      ? kSemanticPaid
                                      : kSemanticPending,
                                  width: 2,
                                ),
                              ),
                              child: DiviAvatar(pessoa: residentName, size: 32),
                            ),
                          );
                        }).toList(),
                      ),
                      // Expand icon
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: RotationTransition(
                          turns: Tween(
                            begin: 0.0,
                            end: 0.5,
                          ).animate(_animation),
                          child: Icon(
                            Icons.expand_more,
                            color: statusColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Emotional message
                  Text(
                    emotionalMessage,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: statusColor.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Expanded section - Only visible when expanded
          SizeTransition(
            sizeFactor: _animation,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.02),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  children: resumo.entries.map((entry) {
                    final residentName = entry.key;
                    final residentData = entry.value;
                    final isPaid = residentData.totalGeral <= 0.001;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isPaid
                                    ? kSemanticPaid
                                    : kSemanticPending,
                                width: 2,
                              ),
                            ),
                            child: DiviAvatar(pessoa: residentName, size: 36),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              residentName,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: kTextPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          isPaid
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      color: kSemanticPaid,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      "Em dia",
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kSemanticPaid,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Icon(
                                      Icons.warning,
                                      color: kSemanticPending,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'R\$ ${residentData.totalGeral.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: kSemanticPending,
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

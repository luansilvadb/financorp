import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:divi/shared/constants.dart';
import 'package:divi/shared/widgets/skeuomorphic.dart';

class ReceiptItemCard extends StatefulWidget {
  final String title;
  final String date;
  final double amount;
  final bool isPaid;
  final VoidCallback onToggle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final bool isHouseExpense;

  const ReceiptItemCard({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    required this.isPaid,
    required this.onToggle,
    this.onTap,
    this.onDelete,
    this.isHouseExpense = false,
  });

  @override
  State<ReceiptItemCard> createState() => _ReceiptItemCardState();
}

class _ReceiptItemCardState extends State<ReceiptItemCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ClipPath(
          clipper:
              ReceiptClipper(jaggedTop: true, jaggedBottom: true, toothSize: 4),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: widget.onTap,
              onLongPress: () {
                HapticFeedback.mediumImpact();
                widget.onDelete?.call();
              },
              highlightColor: kInk.withOpacity(0.05),
              splashColor: kInk.withOpacity(0.1),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if (widget.isHouseExpense)
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: PhosphorIcon(
                                    PhosphorIcons.houseLine(
                                        PhosphorIconsStyle.fill),
                                    size: 14,
                                    color: kInkFaded,
                                  ),
                                ),
                              Text(
                                widget.title,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: kInk,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.date,
                            style: const TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 11,
                              color: kInkFaded,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          formatCurrency.format(widget.amount),
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: widget.isPaid ? kPaid : kInk,
                            decoration: widget.isPaid
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    GestureDetector(
                      onTap: widget.onToggle,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.isPaid ? kPaid : kLine, width: 2),
                          borderRadius: BorderRadius.circular(6),
                          color: widget.isPaid ? kPaid : Colors.transparent,
                        ),
                        child: widget.isPaid
                            ? const Icon(Icons.check,
                                size: 16, color: Colors.white)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

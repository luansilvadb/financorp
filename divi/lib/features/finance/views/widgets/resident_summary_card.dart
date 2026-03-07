import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../../core/engine/finance_engine.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/widgets/skeuomorphic.dart';

class ResidentSummaryCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final PersonSummaryRecord data;
  final Color highlightColor;
  final VoidCallback onTap;

  const ResidentSummaryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.highlightColor,
    required this.onTap,
  });

  @override
  State<ResidentSummaryCard> createState() => _ResidentSummaryCardState();
}

class _ResidentSummaryCardState extends State<ResidentSummaryCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    // Display totalGeral directly, if Luan it might be negative meaning owes, or positive meaning receives
    final amount = (widget.data.totalGeral).abs();
    bool owes = widget.data.totalGeral > 0;
    bool isSettled = widget.data.totalGeral == 0;

    String statusText = "QUITADO";
    Color statusColor = kPaid;
    if (owes) {
      statusText = "TOTAL DEVIDO";
      statusColor = kPrimaryColor;
    }

    return AnimatedScale(
      scale: _isPressed ? 0.96 : 1.0,
      duration: const Duration(milliseconds: 100),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ClipPath(
          clipper:
              ReceiptClipper(jaggedTop: true, jaggedBottom: true, toothSize: 5),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTapDown: (_) => setState(() => _isPressed = true),
              onTapUp: (_) => setState(() => _isPressed = false),
              onTapCancel: () => setState(() => _isPressed = false),
              onTap: widget.onTap,
              highlightColor: kInk.withOpacity(0.05),
              splashColor: kInk.withOpacity(0.1),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Row(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: widget.highlightColor.withOpacity(0.2),
                      backgroundImage: avataresPessoa[widget.title] != null
                          ? NetworkImage(avataresPessoa[widget.title]!)
                          : null,
                      child: avataresPessoa[widget.title] == null
                          ? Text(widget.title[0],
                              style: TextStyle(color: widget.highlightColor))
                          : null,
                    ),
                    const SizedBox(width: 16),
                    // Naming
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: kInk,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.subtitle,
                            style: const TextStyle(
                              fontFamily: 'Space Mono',
                              fontSize: 12,
                              color: kInkFaded,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Value
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          statusText,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: isSettled ? kPaid : statusColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          formatCurrency.format(amount),
                          style: TextStyle(
                            fontFamily: 'Space Mono',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isSettled ? kPaid : statusColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    PhosphorIcon(
                      PhosphorIcons.caretRight(PhosphorIconsStyle.bold),
                      color: kLine,
                      size: 16,
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

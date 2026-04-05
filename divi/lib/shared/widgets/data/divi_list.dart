import 'package:flutter/material.dart';

/// A reusable list component.
class DiviList<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final void Function(T item)? onTap;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;

  const DiviList({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.onTap,
    this.padding,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          onTap: onTap != null ? () => onTap!(item) : null,
          title: itemBuilder(context, item),
        );
      },
    );
  }
}

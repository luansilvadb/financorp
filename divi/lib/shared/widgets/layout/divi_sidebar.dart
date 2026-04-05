import 'package:flutter/material.dart';

/// A reusable sidebar/navigation drawer component.
class DiviSidebar extends StatelessWidget {
  final List<DiviSidebarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final Color? backgroundColor;

  const DiviSidebar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: backgroundColor ?? Theme.of(context).cardColor,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = index == selectedIndex;

          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
            selected: isSelected,
            onTap: () => onItemSelected(index),
          );
        },
      ),
    );
  }
}

/// A sidebar menu item.
class DiviSidebarItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const DiviSidebarItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }
}

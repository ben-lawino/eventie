import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final Color selectedColor;

  const FilterButton({
    super.key,
    required this.label,
    required this.icon,
    this.isSelected = false,
    this.selectedColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? selectedColor : Theme.of(context).colorScheme.primary,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isSelected ? selectedColor : Colors.black54,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? selectedColor : Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
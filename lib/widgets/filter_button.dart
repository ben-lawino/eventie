import 'package:flutter/material.dart';

import '../common/constants/colors.dart';

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
    this.selectedColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
   padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

      decoration: BoxDecoration(
        color: isSelected ? selectedColor : Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
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
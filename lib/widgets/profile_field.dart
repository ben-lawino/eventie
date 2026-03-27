import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final String text;
  final IconData? suffixIcon;
  final Widget? prefixWidget;

  const ProfileField({
    super.key,
    required this.text,
    this.suffixIcon,
    this.prefixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color:Color(0xFFAAAAAA).withOpacity(0.15),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          if (prefixWidget != null) ...[
            prefixWidget!,
            const SizedBox(width: 8),
          ],

          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w800
              )
            ),
          ),

          if (suffixIcon != null)
            Icon(
              suffixIcon,
              size: 18,
              color: Colors.black,
            ),
        ],
      ),
    );
  }
}
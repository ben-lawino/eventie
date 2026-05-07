
import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  final TextEditingController? controller;
  final String? text; // kept for backward compat
  final String? label;
  final IconData? suffixIcon;
  final Widget? prefixWidget;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onSuffixTap;
  final String? Function(String?)? validator;

  const ProfileField({
    super.key,
    this.controller,
    this.text,
    this.label,
    this.suffixIcon,
    this.prefixWidget,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.onSuffixTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? TextEditingController(text: text),
      readOnly: readOnly,
      keyboardType: keyboardType,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        prefixIcon: prefixWidget != null
            ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: prefixWidget,
        )
            : null,
        prefixIconConstraints: prefixWidget != null
            ? const BoxConstraints(minWidth: 0, minHeight: 0)
            : null,
        suffixIcon: suffixIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: Icon(suffixIcon),
        )
            : null,
      ),
    );
  }
}
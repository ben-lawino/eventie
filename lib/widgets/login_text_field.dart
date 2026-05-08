import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String? hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffix;
  final String? Function(String?)? validator;

  const LoginTextField({
    super.key,
    this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.suffix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.grey[500]),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFFAAAAAA).withOpacity(0.1),
        hintStyle: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Colors.grey[500], fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
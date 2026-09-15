import 'package:flutter/material.dart';

const _navy = Color(0xFF1E3A8A);
const _fieldFill = Color(0xFFF1F5F9);

/// Custom input field untuk halaman Auth (ID Karyawan / Password / PIN).
///
/// Memakai gaya konsisten: fill terang `#F1F5F9`, icon prefix navy,
/// border rounded 14, dan border fokus navy.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.suffix,
  });

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13.5, color: Color(0xFF9AA3B8)),
        prefixIcon: Icon(icon, size: 20, color: _navy),
        suffixIcon: suffix,
        filled: true,
        fillColor: _fieldFill,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: _navy, width: 1.2),
        ),
      ),
    );
  }
}
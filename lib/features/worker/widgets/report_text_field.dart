import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Field teks berlabel untuk formulir pencatatan barang temuan.
///
/// Mendukung input satu baris (misal nama barang) maupun multi-baris
/// (misal deskripsi/catatan tambahan), dengan background lavender/biru muda
/// lembut `#F0F3FF` default dan ikon prefix opsional.
class ReportTextField extends StatelessWidget {
  const ReportTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor = const Color(0xFFF0F3FF),
  });

  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: AppColors.navy),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 14, color: AppColors.ink),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: fillColor,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: AppColors.navy, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card aksi besar kuning "+ Catat Barang Temuan" di dashboard.
class QuickCaptureCard extends StatelessWidget {
  const QuickCaptureCard({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.yellow,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _capsule('● 1-Tap Quick Capture', Colors.white.withValues(alpha: 0.65), AppColors.navy),
                    const SizedBox(height: 10),
                    const Text(
                      '+ Catat Barang Temuan',
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.navy),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 15, color: AppColors.navy),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'Kamera Langsung & Deteksi Cepat',
                            style: TextStyle(fontSize: 11, color: Color(0xFF3F3F3F), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(color: AppColors.navy, shape: BoxShape.circle),
                child: const Icon(Icons.camera_alt, color: Colors.white, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _capsule(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(text, style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.w800, color: fg)),
    );
  }
}
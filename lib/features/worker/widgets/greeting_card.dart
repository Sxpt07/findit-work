import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Card sapaan "Selamat Bertugas" di dashboard, menampilkan shift aktif dan
/// jumlah temuan hari ini.
class GreetingCard extends StatelessWidget {
  const GreetingCard({super.key, required this.todayCount});

  final int todayCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _capsule('● SHIFT AKTIF', AppColors.greenSoft, AppColors.greenStrong),
              const Spacer(),
              _capsule('Lantai 3 & 4', AppColors.softBlue, const Color(0xFF3730A3)),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Selamat Bertugas, Siti!',
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800, color: AppColors.navy),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.apartment_outlined, size: 15, color: Colors.black54),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Kamar 301 – 420 • $todayCount Temuan Hari Ini',
                  style: const TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
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
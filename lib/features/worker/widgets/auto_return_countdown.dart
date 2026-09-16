import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Box status timed: teks "Otomatis kembali ke Beranda", progress bar biru,
/// dan hitungan mundur (detik).
class AutoReturnCountdown extends StatelessWidget {
  const AutoReturnCountdown({
    super.key,
    required this.seconds,
    this.total = 10,
  });

  final int seconds;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = (total - seconds) / total;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.refresh, size: 18, color: AppColors.navy),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Otomatis kembali ke Beranda',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: AppColors.softBlue,
                    valueColor: const AlwaysStoppedAnimation(AppColors.navy),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            '${seconds}s',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.navy),
          ),
        ],
      ),
    );
  }
}
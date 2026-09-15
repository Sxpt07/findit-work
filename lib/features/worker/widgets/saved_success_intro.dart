import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Ikhtisar sukses: lingkaran hijau bercentang + badge kuning bergerigi,
/// judul, dan subtitle.
class SavedSuccessIntro extends StatelessWidget {
  const SavedSuccessIntro({
    super.key,
    this.title = 'Barang Berhasil Tersimpan!',
    this.subtitle = 'Data audit inventaris kamar diperbarui secara real-time.',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: 86,
              height: 86,
              decoration: const BoxDecoration(
                color: AppColors.successGreen,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 46),
            ),
            Positioned(
              top: 2,
              right: 2,
              child: Transform.rotate(
                angle: 0.7854,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: AppColors.yellow,
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                  ),
                  child: const Center(
                    child: Icon(Icons.check, color: AppColors.navy, size: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.navy),
        ),
        const SizedBox(height: 5),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black45.withValues(alpha: 0.6),
            height: 1.4,
          ),
        ),
      ],
    );
  }
}